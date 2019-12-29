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
    
    let scrollingStackView = ScrollingStackView()
    
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
        
        view.addSubview(scrollingStackView)
        scrollingStackView.addArrangedSubview(favoriteMoviesView)
        scrollingStackView.addArrangedSubview(moviesOnWatchlistView)
        scrollingStackView.addArrangedSubview(favoriteTVShowsView)
        scrollingStackView.addArrangedSubview(tvShowsOnWatchlistView)
        
        scrollingStackView.setUpLayout(topConstant: 0)
        
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

}

