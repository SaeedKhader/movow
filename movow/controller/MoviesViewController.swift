//
//  MoviesViewController.swift
//  MovoW
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    //MARK: - Properties
    
    var isSearchOn = false
    
    
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
        
    let popularMoviesView = MediaView(title: "Popular", mediaType: .movie)
    let playingNowMoviesView = MediaView(title: "Playing Now", mediaType: .movie)
    let topRatedMoviesView = MediaView(title: "Top Rated", mediaType: .movie)
    let upComingMoviesView = MediaView(title: "Up Coming", mediaType: .movie)
    
    let searchView = SearchView(mediaType: .movie)
    var searchBtn: UIBarButtonItem!
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        navigationItem.titleView = LogoImageView()
        
        
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.tintColor = .white
        scrollView.refreshControl?.addTarget(self, action:
                                           #selector(handleRefreshControl),
                                             for: .valueChanged)
              
        setUpSearchView()
        
        popularMoviesView.setSuperVC(superVC: self)
        playingNowMoviesView.setSuperVC(superVC: self)
        topRatedMoviesView.setSuperVC(superVC: self)
        upComingMoviesView.setSuperVC(superVC: self)
        
        view.addSubview(scrollView)
        view.addSubview(searchView)
        scrollView.addSubview(viewContent)
        viewContent.addArrangedSubview(popularMoviesView)
        viewContent.addArrangedSubview(playingNowMoviesView)
        viewContent.addArrangedSubview(topRatedMoviesView)
        viewContent.addArrangedSubview(upComingMoviesView)
        
        setUpLayout()
        
        checkInternetConnection()
        retrieveDataFromURL()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.navigationBar.isTranslucent = false
    }
    
    
    //MARK: - Actions
    
    @objc func searchTapped() {
        isSearchOn.toggle()
        UIView.animate(withDuration: 0.2) {
            self.searchView.alpha = self.isSearchOn ? 1 : 0
        }
        if isSearchOn {
            let cancelImg = UIImage(systemName: "xmark.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            searchBtn.image = cancelImg
            searchView.searchBar.becomeFirstResponder()
        } else {
            let searchImg = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            searchBtn.image = searchImg
            searchView.clearSearch()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    func retrieveDataFromURL() {
        if Reachability.isConnectedToNetwork() {
            retriveMediaFromURL(toView: popularMoviesView, sorting: .popular)
            retriveMediaFromURL(toView: playingNowMoviesView, sorting: .playingNow)
            retriveMediaFromURL(toView: topRatedMoviesView, sorting: .topRated)
            retriveMediaFromURL(toView: upComingMoviesView, sorting: .upComing)
        } else {
            popularMoviesView.showError(hasError: true)
            playingNowMoviesView.showError(hasError: true)
            topRatedMoviesView.showError(hasError: true)
            upComingMoviesView.showError(hasError: true)
        }
    }
    
    func retriveMediaFromURL(toView view: MediaView, sorting: Sorting) {
        view.activityIndicator.startAnimating()
        view.showError(hasError: false)
        TMDBClient.getMedia(mediaType: .movie, sorting: sorting) { (movies, error) in
            guard error == nil else {
                view.activityIndicator.stopAnimating()
                view.showError(hasError: true)
                return
            }
            view.activityIndicator.stopAnimating()
            view.setMedia(media: movies)
        }
    }
    
    @objc func handleRefreshControl() {
        retrieveDataFromURL()
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.checkInternetConnection()
            }
        }
        
    }
    
    
    //MARK: - Functions
    
    fileprivate func setUpSearchView() {
        searchView.mediaTableView.superVC = self
        searchView.mediaTableView.backgroundColor = .clear
        searchView.mediaTableView.separatorStyle = .none
        
        let searchImg = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        searchBtn = UIBarButtonItem(image: searchImg, style: .done, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem = searchBtn
    }
    
    func checkInternetConnection() {
        if !Reachability.isConnectedToNetwork(){
            self.showAlert(title: "No Connection", message: "Internet Connection not Available!\nCheck your connection and pull down to reload.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
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
        
        searchView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
