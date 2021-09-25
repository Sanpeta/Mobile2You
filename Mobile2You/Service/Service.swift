//
//  Service.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 24/09/21.
//

import Foundation
import UIKit

class Service: NSObject {
    static let shared = Service()
    
    func searchMovie(completion: @escaping (Movie?, Error?) -> ()) {
        guard let minhaUrl = NSURL(string: "https://api.themoviedb.org/3/movie/157336?api_key=\(API_KEY)") else {
            return
        }
        let request = NSMutableURLRequest(url: minhaUrl as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus?.statusCode == 200 {
                
                if data?.count != 0 {
                    
                    do {
                        
                        let movieJSON = try JSONDecoder().decode(Movie.self, from: data!)
                        
                        DispatchQueue.main.async {
                            completion(movieJSON, nil)                            
                        }
                        
                        
                    } catch let error {
                        
                        print("Error to decode \(error)")
                        
                    }
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    func searchSimilarMovieList(completion: @escaping ([SimilarMovie]?, Error?) -> ()) {
        guard let minhaUrl = NSURL(string: "https://api.themoviedb.org/3/movie/157336/similar?api_key=\(API_KEY)") else {
            return
        }
        let request = NSMutableURLRequest(url: minhaUrl as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus?.statusCode == 200 {
                
                if data?.count != 0 {
                    
                    do {
                                             
                        let similarMovieListJSON = try JSONDecoder().decode(Similar.self, from: data!)
                        
                        
                        DispatchQueue.main.async {
                            
                            completion(similarMovieListJSON.results, nil)
                            
                        }
                        
                        
                    } catch let error {
                        print("Error to decode \(error)")
                    }
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    func loadImage(url imageEndPoint: String, _ completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(imageEndPoint)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
//                    self.heroImage.image =
                    completion(UIImage(data: data))
                }
            }
            
            task.resume()
        }
        completion(nil)
    }
    
}
