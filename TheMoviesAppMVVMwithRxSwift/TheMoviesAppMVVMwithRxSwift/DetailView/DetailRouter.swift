//
//  DetailRouter.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 16.05.2024.
//

import UIKit

class DetailRouter {
    var viewController : UIViewController {
        return createViewController()
    }
    
    var movieId: String?
    
    private var sourceView: UIViewController?
    
    init(movieId: String? = "") {
        self.movieId = movieId
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("Error") }
        self.sourceView = view
    }
    
    private func createViewController() -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.movieId = self.movieId
        return view
    }
}
