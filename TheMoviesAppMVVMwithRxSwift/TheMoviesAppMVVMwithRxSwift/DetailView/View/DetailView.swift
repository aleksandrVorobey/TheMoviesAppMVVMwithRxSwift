//
//  DetailView.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 15.05.2024.
//

import UIKit
import RxSwift

class DetailView: UIViewController {

    @IBOutlet private weak var titleHeaderLabel: UILabel!
    @IBOutlet private weak var imageMovie: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    
    private var disposeBag = DisposeBag()
    
    var movieId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
        getDataAndShowDetailMovie()
    }
    
    private func getDataAndShowDetailMovie() {
        guard let idMovie = movieId else { return  }
        return viewModel.getMovieData(movieId: idMovie).subscribe { movie in
            self.showDetailMovie(movie: movie)
        } onError: { error in
            print(" Error \(error.localizedDescription)")
        }.disposed(by: disposeBag)
    }
    
    private func getImageMovie(movie: MovieDetail) {
        self.imageMovie.image  = UIImage(named: "myImage")!
        return viewModel.getImageMovie(urlString: Constants.URL.urlImages+movie.imageMovie)
            .observe(on: MainScheduler())
            .subscribe { data in
                self.imageMovie.image = UIImage(data: data)
        }.disposed(by: disposeBag)
    }
    
    func showDetailMovie(movie: MovieDetail) {
        DispatchQueue.main.async {
            self.titleHeaderLabel.text = movie.title
            self.descriptionLabel.text = movie.descriptionMovie
            self.releaseDateLabel.text = movie.releaseDate
            self.voteAverageLabel.text = String(movie.voteAverage)
            self.getImageMovie(movie: movie)
        }
    }

}
