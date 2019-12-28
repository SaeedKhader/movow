//
//  MovieDetailsViewController.swift
//  movow
//
//  Created by Saeed Khader on 19/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsViewController: UIViewController {
    
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var movie: Media!
    var movieObjc: Movie?
    var poster: UIImage!
    
    func isFavorite() -> Bool {
        return self.movieObjc?.isFavorite ?? false
    }
    
    func isOnWatchlist() -> Bool {
        return self.movieObjc?.isOnWatchlist ?? false
    }
    
    
    //MARK: - UI Properties
    
    let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.showsVerticalScrollIndicator = false
        return s
    }()
    
    let viewContent: UIStackView = {
        let s = UIStackView()
        s.alignment = .fill
        s.axis = .vertical
        s.distribution = .fill
        s.spacing = 20
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    var posterView: BigPosterView!
    let favoriteButton = FavoriteButton()
    let watchlistButton = WatchlistButton()
    var mainInfoView: MediaMainInfoView!
    var overviewView: OverviewView!
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1408713758, green: 0.1505542099, blue: 0.2467504144, alpha: 1)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = GoBackBarButtonItem(superVC: self)
        favoriteButton.addTarget(self, action: #selector(markFavorite), for: .touchUpInside)
        watchlistButton.addTarget(self, action: #selector(markOnWatchList), for: .touchUpInside)
        
        posterView = BigPosterView(poster: poster!)
        mainInfoView = MediaMainInfoView(media: movie, mediaType: .movie)
        overviewView = OverviewView(overview: movie.overview)
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        viewContent.addArrangedSubview(posterView)
        posterView.addSubview(favoriteButton)
        posterView.addSubview(watchlistButton)
        viewContent.addArrangedSubview(mainInfoView)
        viewContent.addArrangedSubview(overviewView)
        
        fetchDataFromDB()
        if Reachability.isConnectedToNetwork() {
            TMDBClient.getCredits(mediaType: .movie, id: movie.id, completion: handelGetCreditsResponse(credits:error:))
        }

        setUpLayout()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.isTranslucent = true
    }
    
    
    //MARK: - Actions
    
    @objc func markFavorite() {
        if isFavorite() {
            movieObjc!.isFavorite = false
            if !movieObjc!.isOnWatchlist {
                context.delete(movieObjc!)
                movieObjc = nil
            }
            try? context.save()
        } else {
            if let movieObjc = movieObjc {
                movieObjc.isFavorite = true
                try? context.save()
            } else {
                let newFavMovie = Movie(context: context)
                newFavMovie.id = Int32(movie.id)
                newFavMovie.isFavorite = true
                newFavMovie.title = movie.title
                newFavMovie.releaseDate = movie.releaseDateForMovie
                newFavMovie.overview = movie.overview
                newFavMovie.genreIds = movie.genreIds
                newFavMovie.poster = poster?.jpegData(compressionQuality: 1)
                newFavMovie.voteCount = Int32(movie.voteCount)
                newFavMovie.voteAverage = movie.voteAverage
                try? context.save()
                movieObjc = newFavMovie
            }
        }
        favoriteButton.isFavorite(isFavorite())
    }
    
    @objc func markOnWatchList() {
        if isOnWatchlist() {
            movieObjc!.isOnWatchlist = false
            if !movieObjc!.isFavorite {
                context.delete(movieObjc!)
                movieObjc = nil
            }
            try? context.save()
        } else {
            if let movieObjc = movieObjc {
                movieObjc.isOnWatchlist = true
                try? context.save()
            } else {
                let newFavMovie = Movie(context: context)
                newFavMovie.id = Int32(movie.id)
                newFavMovie.isOnWatchlist = true
                newFavMovie.title = movie.title
                newFavMovie.releaseDate = movie.releaseDateForMovie
                newFavMovie.overview = movie.overview
                newFavMovie.genreIds = movie.genreIds
                newFavMovie.poster = poster?.jpegData(compressionQuality: 1)
                newFavMovie.voteCount = Int32(movie.voteCount)
                newFavMovie.voteAverage = movie.voteAverage
                try? context.save()
                movieObjc = newFavMovie
            }
        }
        watchlistButton.isOnWatchlist(isOnWatchlist())
    }
    
    
    // MARK: - Functions
    
    func fetchDataFromDB() {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movie.id)
        fetchRequest.predicate = predicate
        if let results = try? context.fetch(fetchRequest) {
            movieObjc = results.first
        }
        favoriteButton.isFavorite(isFavorite())
        watchlistButton.isOnWatchlist(isOnWatchlist())
    }
    
    func handelGetCreditsResponse(credits: Credits?, error: Error?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        
        let writers = credits!.crew.filter({ $0.job == "Writer" || $0.job == "Screenplay"})
        if !writers.isEmpty {
            let writerView = CrewView(crew: writers, crewType: .Writer)
            self.viewContent.addArrangedSubview(writerView)
        }
        
        let directors = credits!.crew.filter({ $0.job == "Director" })
        if !directors.isEmpty {
            let directorView = CrewView(crew: directors, crewType: .Director)
            self.viewContent.addArrangedSubview(directorView)
        }
        
        let cast = credits!.cast
        if !cast.isEmpty {
            let castView = CastView(cast: cast)
            self.viewContent.addArrangedSubview(castView)
        }
    }
    
    
    //MARK: - Layout
    
    func setUpLayout() {
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -(navigationController?.navigationBar.frame.maxY)!).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        viewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        
        favoriteButton.bottomAnchor.constraint(equalTo: posterView.bottomAnchor, constant: -15).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: -20).isActive = true
        watchlistButton.bottomAnchor.constraint(equalTo: posterView.bottomAnchor, constant: -15).isActive = true
        watchlistButton.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10).isActive = true
    }
    
    
}



