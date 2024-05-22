//
//  HomeRouter.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 17.04.2024.
//

import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController {
        createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourseView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("ERROR VIEW") }
        self.sourceView = view
    }
        
    func navigateToDetailView(movieID: String) {
        let detailView = DetailRouter(movieId: movieID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
