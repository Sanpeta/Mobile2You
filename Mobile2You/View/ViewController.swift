//
//  ViewController.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 22/09/21.
//

import UIKit

//Global variable sizes
var widthScreen = CGFloat()
var heightScreen = CGFloat()
var statusBarHeight = CGFloat()

class ViewController: UIViewController {
    
    //UIs
    var scrollView: UIScrollView!
    var shadowImageView: UIImageView!
    var heroImage: HeroImage!
    var heroTitle: UILabel!
    var likesIcon: UIImageView!
    var likes: UILabel!
    var popularityIcon: UIImageView!
    var popularity: UILabel!
    var favButton: UIImageView!
    var statusFavButton: Bool = true
    var moviesTableView: UITableView!
    
    //Array
    var listMovies: NSArray = []
    var listGenres: NSArray = []
    
    //ViewModels
    //MovieViewModel
    var movieViewModel: MovieViewModel!    
    
    //MARK: - Change to Status Bar Style to Light(White)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie()
        searchList()
        getGenre()
        
        //take size of screen
        widthScreen = self.view.frame.size.width
        heightScreen = self.view.frame.size.height
        statusBarHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.size.height

        
        view.backgroundColor = UIColor(named: Constants.backgroundColor)
        
        scrollView = UIScrollView(
            frame: CGRect(
                x: 0,
                y: -statusBarHeight,
                width: widthScreen,
                height: heightScreen
            )
        )
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = false
        
        shadowImageView = UIImageView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: widthScreen, // 100% of the Width Screen
                height: heightScreen * 0.45 // 45% of the Height Screen
            )
        )
        shadowImageView.image = UIImage(named: "Shadow")
        shadowImageView.layer.zPosition = 2
        
        
        heroImage = HeroImage(
            frame: CGRect(
                x: 0,
                y: 0,
                width: widthScreen, // 100% of the Width Screen
                height: heightScreen * 0.45 // 45% of the Height Screen
            )
        )
        heroImage.layer.zPosition = 1
    
        
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
        
        
        //MARK: - Config Image PopularityIcon
        popularityIcon = UIImageView(
            frame: CGRect(
                x: likes.frame.maxX + widthScreen*0.01,
                y: heroTitle.frame.maxY + 16,
                width: 20,
                height: 18
            )
        )
        popularityIcon.image = UIImage(systemName: "star.fill")
        popularityIcon.tintColor = .white
        
        
        //MARK: - Config Lavel Popularity
        popularity = UILabel(
            frame: CGRect(
                x: popularityIcon.frame.maxX + 8,
                y: popularityIcon.frame.minY,
                width: widthScreen*0.30,
                height: 20
            )
        )
        popularity.textColor = .white
        popularity.textAlignment = .left
        popularity.font = popularity.font.withSize(16)
        
        
        //MARK: - Config Button FavButton
        favButton = UIImageView(
            frame: CGRect(
                x: widthScreen - 56,
                y: heroImage.frame.maxY + 16,
                width: 26,
                height: 24
            )
        )
        favButton.image = UIImage(systemName: "suit.heart.fill")
        favButton.tintColor = .white
        favButton.isUserInteractionEnabled = true
        favButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeIconFavButton(tap:)) ))
        
        
        //MARK: - Config MoviesTableView
        moviesTableView = UITableView(
            frame: CGRect(
                x: 0,
                y: popularity.frame.maxY + 16,
                width: widthScreen,
                height: heightScreen
            )
        )
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        moviesTableView.isScrollEnabled = false
        moviesTableView.showsVerticalScrollIndicator = false
        moviesTableView.backgroundColor = UIColor(named: Constants.backgroundColor)
        moviesTableView.layer.zPosition = 1
        moviesTableView.rowHeight = heightScreen*0.11
                
        
        //MARK: - Add all on the main view
        self.view.addSubview(scrollView)
        scrollView.addSubview(shadowImageView)
        scrollView.addSubview(heroImage)
        scrollView.addSubview(heroTitle)
        scrollView.addSubview(likes)
        scrollView.addSubview(likesIcon)
        scrollView.addSubview(popularityIcon)
        scrollView.addSubview(popularity)
        scrollView.addSubview(favButton)
        scrollView.addSubview(moviesTableView)
    }
    
    fileprivate func fetchMovie() {
        Service.shared.searchMovie { movie, err in
            if let err = err {
                print("Erro Fetch movie", err)
                return
            }
            
            self.movieViewModel = MovieViewModel(movie: movie!)
            
            self.heroTitle.text = self.movieViewModel.title
            self.likes.text = self.movieViewModel.vote_count
            self.popularity.text = self.movieViewModel.popularity
            self.loadImage(url: self.movieViewModel.backdrop_path)
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func searchList() {
        guard let minhaUrl = NSURL(string: "https://api.themoviedb.org/3/movie/157336/similar?api_key=\(API_KEY)") else {
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
                            
                            self.listMovies = (respostaJSON.value(forKey: "results") as! NSArray)
                            self.moviesTableView.reloadData()
                            
                        }
                        
                        
                    } catch {
                        print("Error")
                    }
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    
    @objc func getGenre() {
        guard let minhaUrl = NSURL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(API_KEY)") else {
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
                            
                            self.listGenres = (respostaJSON.value(forKey: "genres") as! NSArray)
                                                        
                            self.moviesTableView.reloadData()
                            
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
    
    @objc func changeIconFavButton(tap: UITapGestureRecognizer) {
        if statusFavButton {
            self.favButton.image = UIImage(systemName: "suit.heart.fill")
            statusFavButton = !statusFavButton
        } else {
            self.favButton.image = UIImage(systemName: "heart")
            statusFavButton = !statusFavButton
        }
    }
    
}

//MARK: - EXTENSION TableViewDataSource
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.listMovies.count != 0) {
            scrollView.contentSize.height = self.likes.frame.maxY + 16 + heightScreen*0.11 * CGFloat(self.listMovies.count)
            self.moviesTableView.frame.size.height = heightScreen*0.11 * CGFloat(self.listMovies.count)
            return self.listMovies.count
        } else {
            scrollView.contentSize.height = 0
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.selectionStyle = .none
        let dict = self.listMovies.object(at: Int(indexPath.row)) as! NSDictionary
        // Download in memory
        if dict.isEqual(nil) {
            cell.imageCell.image = UIImage(named: "teste")
            cell.titleCell.text = "A nightmare on Elm Street"
            cell.yearCell.text = "1984"
            cell.genreCell.text = "Horror, Drama"
        } else {
            let imageEndPoint = dict.value(forKey: "poster_path") as! String
            if let url = URL(string: "https://image.tmdb.org/t/p/original\(imageEndPoint)") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        cell.imageCell.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            }
            cell.titleCell.text = dict.value(forKey: "title") as? String
            let year = String((dict.value(forKey: "release_date") as? String)!).split(separator: "-")
            cell.yearCell.text = String(year[0])
            var genreString = ""
            for g in self.listGenres {
                let value = g as! NSDictionary
                let dictGenreIds = dict.value(forKey: "genre_ids") as! NSArray
                for (index, genreMovie) in dictGenreIds.enumerated() {
                    if value.allValues[0] as! Int == genreMovie as! Int {
                        if index != dictGenreIds.count-1 {
                            genreString += "\(value.allValues[1]), "
                        } else {
                            genreString += "\(value.allValues[1])"
                        }
                    }
                }
            }
            cell.genreCell.text = genreString
        }
        
        return cell
    }
    
}


//MARK: - EXTENSION TableViewDelegate
extension ViewController: UITableViewDataSource {}
