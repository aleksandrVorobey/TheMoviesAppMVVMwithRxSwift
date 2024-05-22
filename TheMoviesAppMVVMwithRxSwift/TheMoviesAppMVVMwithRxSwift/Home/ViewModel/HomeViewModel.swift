//
//  HomeViewModel.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 17.04.2024.
//

import Foundation
import RxSwift

class HomeViewModel {
    private weak var view: HomeView?
    private var router: HomeRouter?
    private let managerConections = ManagerConnections()
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourseView(view)
    }
    
    func getListMoviesData() -> Observable<[Movie]>{
        managerConections.getPopularMovies()
    }
    
    func makeDetailView(movieId: String) {
        router?.navigateToDetailView(movieID: movieId)
    }
}
