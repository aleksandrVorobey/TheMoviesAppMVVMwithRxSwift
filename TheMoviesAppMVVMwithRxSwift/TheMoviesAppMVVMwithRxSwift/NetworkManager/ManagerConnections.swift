//
//  ManagerConnections.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 14.05.2024.
//

import Foundation
import RxSwift

class ManagerConnections {
    func getPopularMovies() -> Observable<[Movie]> {
        return Observable.create { observer in
            
            let sessiion = URLSession.shared
            let url = URL(string: Constants.URL.main + Constants.Endpoints.urlListPopularMovies + Constants.apiKey)
            let request = URLRequest(url: url!)
            
            sessiion.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfMovies)
                    } catch (let error) {
                        observer.onError(error)
                        print("Error decode \(error.localizedDescription)")
                    }
                } else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create {
                sessiion.finishTasksAndInvalidate()
            }
        }
    }
    
    func getDetailMovies(movieID: String) -> Observable<MovieDetail> {
        return Observable.create { observer in
            
            let sessiion = URLSession.shared
            let url = URL(string: Constants.URL.main + Constants.Endpoints.urlDetailMovie + movieID + Constants.apiKey)
            let request = URLRequest(url: url!)
            
            sessiion.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let detailMovie = try decoder.decode(MovieDetail.self, from: data)
                        observer.onNext(detailMovie)
                    } catch (let error) {
                        observer.onError(error)
                        print("Error decode \(error.localizedDescription)")
                    }
                } else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create {
                sessiion.finishTasksAndInvalidate()
            }
        }
    }
    
    func getImageFromServer(urlString: String) -> Observable<Data> {
        return Observable.create { observer in
            let sessiion = URLSession.shared
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            
            sessiion.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 200 {
                    observer.onNext(data)
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create {
                sessiion.finishTasksAndInvalidate()
            }
        }
    }
}
