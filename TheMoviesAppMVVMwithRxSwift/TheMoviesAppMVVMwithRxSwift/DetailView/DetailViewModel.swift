//
//  DetailViewModel.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 16.05.2024.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = ManagerConnections()
    private(set) weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getMovieData(movieId: String) -> Observable<MovieDetail> {
        managerConnections.getDetailMovies(movieID: movieId)
    }
    
    func getImageMovie(urlString: String) -> Observable<Data> {
        managerConnections.getImageFromServer(urlString: urlString)
    }
}
