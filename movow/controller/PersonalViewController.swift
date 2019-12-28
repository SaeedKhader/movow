//
//  PersonalViewController.swift
//  movow
//
//  Created by Saeed Khader on 26/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PersonalViewController: UIViewController {
    
    //MARK: - Properties
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
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
        s.spacing = 40
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    let favoriteMoviesView = MediaView(title: "Favorite Movies", mediaType: .movie)
    let moviesOnWatchlistView = MediaView(title: "Movies On Watchlist", mediaType: .movie)
    let favoriteTVShowsView = MediaView(title: "Favorite TV Shows", mediaType: .tv)
    let tvShowsOnWatchlistView = MediaView(title: "TV Shows On Watchlist", mediaType: .tv)
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = LogoImageView()
        
        favoriteMoviesView.setSuperVC(superVC: self)
        moviesOnWatchlistView.setSuperVC(superVC: self)
        favoriteTVShowsView.setSuperVC(superVC: self)
        tvShowsOnWatchlistView.setSuperVC(superVC: self)
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewContent)
        viewContent.addArrangedSubview(favoriteMoviesView)
        viewContent.addArrangedSubview(moviesOnWatchlistView)
        viewContent.addArrangedSubview(favoriteTVShowsView)
        viewContent.addArrangedSubview(tvShowsOnWatchlistView)
        
        setUpLayout()
        
        retrieveDataFromDB()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.isTranslucent = false
        retrieveDataFromDB()
    }
    
    
    //MARK: - Core Data
    
    
    func retrieveDataFromDB() {
        retriveMoviesFromDB(toView: favoriteMoviesView, sorting: .isFavorite)
        retriveMoviesFromDB(toView: moviesOnWatchlistView, sorting: .isOnWatchlist)
        retriveTVShowsFromDB(toView: favoriteTVShowsView, sorting: .isFavorite)
        retriveTVShowsFromDB(toView: tvShowsOnWatchlistView, sorting: .isOnWatchlist)
    }
    
    enum sorting: String {
        case isFavorite
        case isOnWatchlist
    }
    
    func retriveMoviesFromDB(toView view: MediaView, sorting: sorting) {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "\(sorting.rawValue) == true")
        let sortDescriptor = NSSortDescriptor(key: "addedAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        if let results = try? context.fetch(fetchRequest) {
            var movies = [Media]()
            for movie in results {
                let favM = Media(posterPath: nil, poster: movie.poster, overview: movie.overview!, releaseDateForMovie: movie.releaseDate, firstAirDateForTV: nil, genreIds: movie.genreIds!, id: Int(movie.id), title: movie.title!, name: nil, voteCount: Int(movie.voteCount), voteAverage: movie.voteAverage)
                movies.append(favM)
            }
            view.setMedia(media: movies)
        }
    }
    
    func retriveTVShowsFromDB(toView view: MediaView, sorting: sorting) {
        let fetchRequest: NSFetchRequest<TVShow> = TVShow.fetchRequest()
        let predicate = NSPredicate(format: "\(sorting.rawValue) == true")
        let sortDescriptor = NSSortDescriptor(key: "addedAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        if let results = try? context.fetch(fetchRequest) {
            var tvShows = [Media]()
            for tvShow in results {
                let favT = Media(posterPath: nil, poster: tvShow.poster, overview: tvShow.overview!, releaseDateForMovie: nil, firstAirDateForTV: tvShow.releaseDate, genreIds: tvShow.genreIds!, id: Int(tvShow.id), title: nil, name: tvShow.name, voteCount: Int(tvShow.voteCount), voteAverage: tvShow.voteAverage)
                tvShows.append(favT)
            }
            view.setMedia(media: tvShows)
        }
    }

    
    //MARK: - Layout
    
    func setUpLayout() {
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        viewContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

    }

}

