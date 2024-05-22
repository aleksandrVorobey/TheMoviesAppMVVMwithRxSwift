//
//  HomeView.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 17.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

class HomeView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    
    lazy var searchController = {
        let controller = UISearchController()
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .default
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Find movie"
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
        title = "List of films"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.bind(view: self, router: router)
        getData()
        manageSearchBarController()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: CustomMovieCell.indetifierCell, bundle: nil), forCellReuseIdentifier: CustomMovieCell.indetifierCell)
    }
    
    private func getData() {
       return viewModel.getListMoviesData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { movies in
                self.movies = movies
                self.reloadTableView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar
        searchController.delegate = self
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe { result in
                self.filteredMovies = self.movies.filter({ movie in
                    movie.title.contains(result)
                })
                self.reloadTableView()
            }.disposed(by: disposeBag)
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive && searchController.searchBar.text != "" ? filteredMovies.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomMovieCell.indetifierCell, for: indexPath) as! CustomMovieCell
        let movie = searchController.isActive && searchController.searchBar.text != "" ? filteredMovies[indexPath.row] : movies[indexPath.row]
        cell.configureCell(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.makeDetailView(movieId: String(filteredMovies[indexPath.row].movieId))
        } else {
            viewModel.makeDetailView(movieId: String(movies[indexPath.row].movieId))
        }
    }
}

extension HomeView: UISearchControllerDelegate {
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchController.isActive = false
        reloadTableView()
    }
}
