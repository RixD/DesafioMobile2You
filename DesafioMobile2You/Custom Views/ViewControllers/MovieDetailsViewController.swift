//
//  MovieDetailsViewController.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var similarMoviesTableView: UITableView!
        
    @IBOutlet weak var headerImage: UIImageView!
    
    var headerView: UIView!
    var headerImageHeight: CGFloat = 300.0
    
    var movieDetails = [Movie]()
    var similarMovies = [SimilarMoviesResult]()
    
    private var movieDetailsViewModel = MovieDetailsViewModel()
    private var similarMoviesViewModel = SimilarMoviesViewModel()
    private var genresViewModel = GenresViewModel()
    
    /// Inception: The practice of entering dreams and planting an idea in someone's head. - Inception: a prática de entrar em sonhos e plantar uma ideia na cabeça de alguém.
    /// O Ricardo vai passar nessa entrevista e ser contratado ;p
    let movieId: Int = 27205
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTable()
        
        getGenresList()
        getMovieDetails()
        getSimilarMovies()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }

    func setupTable() {
        similarMoviesTableView.rowHeight = UITableView.automaticDimension
        
        headerView = similarMoviesTableView.tableHeaderView
        similarMoviesTableView.tableHeaderView = nil
        similarMoviesTableView.addSubview(headerView)
        similarMoviesTableView.contentInset = UIEdgeInsets(top: headerImageHeight, left: 0, bottom: 0, right: 0)
        similarMoviesTableView.contentOffset = CGPoint(x: 0, y: -headerImageHeight)
        similarMoviesTableView.allowsSelection = false
        similarMoviesTableView.separatorStyle = .none
        
        updateHeaderView()
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -headerImageHeight, width: similarMoviesTableView.bounds.width, height: headerImageHeight)
        if similarMoviesTableView.contentOffset.y < -headerImageHeight || similarMoviesTableView.contentOffset.y < headerImageHeight {
            headerRect.origin.y = similarMoviesTableView.contentOffset.y
            headerRect.size.height = -similarMoviesTableView.contentOffset.y
        }
                                
        headerView.frame = headerRect
    }
    
    func getMovieDetails() {
        movieDetailsViewModel.getMovieDetails(from: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                self.movieDetailsViewModel.movieDetails = movie
                self.loadMovieHeaderImage(with: movie.backdropPath)
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case .error(let error):
                if let errorMessage = error.statusMessage {
                    print(errorMessage)
                } else {
                    print("erro")
                }
            }
        }
    }
    
    func loadMovieHeaderImage(with posterPath: String) {
        headerImage.getMoviePosterImage(from: posterPath, with: "w780")
    }
    
    func getSimilarMovies() {
        similarMoviesViewModel.getSimilarMovies(from: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let similarMoviesResult):
                self.similarMoviesViewModel.similarMovies = similarMoviesResult
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case .error(let error):
                if let errorMessage = error.statusMessage {
                    print(errorMessage)
                } else {
                    print("erro")
                }
            }
        }
    }
    
    func getGenresList() {
        genresViewModel.getGenresList() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let genresList):
                self.genresViewModel.genresList = genresList
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case .error(let error):
                if let errorMessage = error.statusMessage {
                    print(errorMessage)
                } else {
                    print("erro")
                }
            }
        }
    }
    
    func updateUI() {
        similarMoviesTableView.reloadDataOnMainThread()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
/// If the view controller is going to recieve more code we should consider carving off the data sources and create their own files
extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int = 0
        if let similarMovies = similarMoviesViewModel.similarMovies {
            
            numberOfRows += similarMovies.results != nil ? similarMovies.results!.count : 0
        }
        
        if self.movieDetailsViewModel.movieDetails != nil {
            numberOfRows += 1
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell {
                cell.indentationLevel = 2
                
                if let movieDetails = movieDetailsViewModel.movieDetails {
                    cell.set(movie: movieDetails)
                }
                        
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "similarMovieCell", for: indexPath) as! SimilarMovieTableViewCell
            cell.indentationLevel = 2
            let index = movieDetailsViewModel.movieDetails != nil ? (indexPath.row - 1) : indexPath.row
            if let similarMovies = similarMoviesViewModel.similarMovies, let movies = similarMovies.results {
                let similarMovie = movies[index]
                cell.set(movie: similarMovie, genreList: genresViewModel.genresList)
            }
                    
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
    
extension MovieDetailsViewController: UITableViewDelegate { }
