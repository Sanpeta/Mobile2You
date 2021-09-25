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
    
    //ViewModels
    //MovieViewModel
    var movieViewModel: MovieViewModel!
    //SimilarMovieViewModel
    var similarMovieViewModels = [SimilarMovieViewModel]()
    //GenreViewModel
    var genreViewModels = [GenreViewModel]()
    
    //MARK: - Change to Status Bar Style to Light(White)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovie()
        fetchSimilarMovieList()
        fetchGenreList()
        
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
            Service.shared.loadImage(url: self.movieViewModel.backdrop_path, { img in
                self.heroImage.image = img
            })
            
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func fetchSimilarMovieList() {
        Service.shared.searchSimilarMovieList { similarMovies, err in
            if let err = err {
                print("Erro Fetch movie", err)
                return
            }
            
            self.similarMovieViewModels = similarMovies?.map({return SimilarMovieViewModel(similarMovie: $0)}) ?? []
            
            self.moviesTableView.reloadData()
        }
    }
    
    fileprivate func fetchGenreList() {
        Service.shared.getGenres { genres, err in
            if let err = err {
                print("Erro Fetch Genres", err)
                return
            }
            
            self.genreViewModels = genres?.map({return GenreViewModel(genre: $0)}) ?? []
            
            self.moviesTableView.reloadData()
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
        if(self.similarMovieViewModels.count != 0) {
            scrollView.contentSize.height = self.likes.frame.maxY + 16 + heightScreen*0.11 * CGFloat(self.similarMovieViewModels.count)
            self.moviesTableView.frame.size.height = heightScreen*0.11 * CGFloat(self.similarMovieViewModels.count)
            return self.similarMovieViewModels.count
        } else {
            scrollView.contentSize.height = 0
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.selectionStyle = .none
        let movieViewModelIndex = self.similarMovieViewModels[indexPath.row]
        // Download in memory
        let imageEndPoint = movieViewModelIndex.poster_path!
        Service.shared.loadImage(url: imageEndPoint, {img in
            cell.imageCell.image = img
        })
                
        var genreString = ""
        for (index, genreMovie) in movieViewModelIndex.genre_ids.enumerated() {
            for genre in genreViewModels {
                if genre.id == genreMovie {
                    if index != movieViewModelIndex.genre_ids.count-1 {
                        genreString += "\(genre.name), "
                    } else {
                        genreString += "\(genre.name)"
                    }
                }
            }
        }
        
        cell.genreCell.text = genreString
        cell.titleCell.text = movieViewModelIndex.title
        cell.yearCell.text = movieViewModelIndex.release_date
        
        return cell
    }
    
}


//MARK: - EXTENSION TableViewDelegate
extension ViewController: UITableViewDataSource {}
