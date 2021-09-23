//
//  ViewController.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 22/09/21.
//

import UIKit

class ViewController: UIViewController {

    var heroImage: HeroImage!
    var heroTitle: UILabel!
    var likesIcon: UIImageView!
    var likes: UILabel!
    var popularity: UILabel!
    var favButton: UIButton!
    var filmsTableView: UITableView!
    
    //size view
    var widthScreen = CGFloat()
    var heightScreen = CGFloat()
    
//    https://image.tmdb.org/t/p/original/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search()
        
        //take size of screen
        widthScreen = self.view.frame.size.width
        heightScreen = self.view.frame.size.height
        
        view.backgroundColor = .black
        
        heroImage = HeroImage(
            frame: CGRect(
                x: 0,
                y: 0,
                width: widthScreen, // 100% of the Width Screen
                height: heightScreen * 0.45 // 45% of the Height Screen
            )
        )
        
        
        //MARK: - Config Label HeroTitle
        heroTitle = UILabel(
            frame: CGRect(
                x: 16,
                y: heroImage.frame.maxY,
                width: widthScreen*0.60,
                height: heightScreen*0.07
            )
        )
        heroTitle.textColor = .white
        heroTitle.textAlignment = .left
        heroTitle.font = UIFont.boldSystemFont(ofSize: 32)
        
        
        //MARK: - Config Image LikesIcon
        likesIcon = UIImageView(
            frame: CGRect(
                x: 16,
                y: heroTitle.frame.maxY + 16,
                width: 20,
                height: 18
            )
        )
        likesIcon.image = UIImage(systemName: "suit.heart.fill")
        likesIcon.tintColor = .white
        
        
        //MARK: - Config Label Likes
        likes = UILabel(
            frame: CGRect(
                x: likesIcon.frame.maxX + 8,
                y: likesIcon.frame.minY,
                width: widthScreen*0.25,
                height: 20
            )
        )
        likes.textColor = .white
        likes.textAlignment = .left
        likes.font = likes.font.withSize(16)
        
        
        popularity = UILabel(
            frame: CGRect(
                x: 0,
                y: 130,
                width: 100,
                height: 40
            )
        )
        
        favButton = UIButton(
            frame: CGRect(
                x: 0,
                y: 170,
                width: 40,
                height: 40
            )
        )
        
        favButton.backgroundColor = .red
        
        //Add all on the main view
        self.view.addSubview(heroImage)
        self.view.addSubview(heroTitle)
        self.view.addSubview(likes)
        self.view.addSubview(likesIcon)
        self.view.addSubview(popularity)
//        self.view.addSubview(favButton)
//        self.view.addSubview(filmsTableView)
    }

    
    func decode(json: Data) {
        if let movie = try? JSONDecoder().decode(Movie.self, from: json) {
            print(movie.title)
        }
    }
    
    @objc func search() {
        guard let minhaUrl = NSURL(string: "https://api.themoviedb.org/3/movie/157336?api_key=\(API_KEY)") else {
            return
        }
        let request = NSMutableURLRequest(url: minhaUrl as URL)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus?.statusCode == 200 {
                
                if data?.count != 0 {
                    
                    do {
                     
                        let respostaJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                        
                        DispatchQueue.main.async {
                            self.heroTitle.text = respostaJSON.value(forKey: "title") as? String
                            self.likes.text = String((respostaJSON.value(forKey: "vote_count") as? Int)!)
                            self.popularity.text = String((respostaJSON.value(forKey: "popularity") as? Double)!)
                            
                            self.loadImage(url: (respostaJSON.value(forKey: "backdrop_path") as? String)!)
                            
                            self.view.layoutIfNeeded()
                        }
                        
                        
                    } catch {
                        print("Error")
                    }
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    func loadImage(url imageEndPoint: String) {
        if let url = URL(string: "https://image.tmdb.org/t/p/original\(imageEndPoint)") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.heroImage.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
    
}
