//
//  SearchView.swift
//  movow
//
//  Created by Saeed Khader on 21/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class SearchView: UIView, UISearchBarDelegate {
        
    var mediaType: MediaType!
    
    let searchBar: UISearchBar = {
        let s = UISearchBar()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.searchBarStyle = .minimal
        s.tintColor = .white
        s.showsCancelButton = false
        s.searchTextField.textColor = .white
        s.searchTextField.font = UIFont.myBoldSystemFont(ofSize: 16)
        s.searchTextField.backgroundColor = #colorLiteral(red: 0.236300379, green: 0.2546732724, blue: 0.4163803756, alpha: 1)
        let icon = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        s.setImage(icon, for: .search, state: .normal)
        return s
    } ()
    
    let activityIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView()
        a.hidesWhenStopped = true
        a.color = .white
        a.style = .medium
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    let resultsLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.mySystemFont(ofSize: 14)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var mediaTableView: MediaTableView!
    
    var currentSearchTask: URLSessionTask?

    init(mediaType: MediaType) {
        super.init(frame: .zero)
        self.mediaType = mediaType
        mediaTableView = MediaTableView(mediaType: mediaType)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.1408713758, green: 0.1505542099, blue: 0.2467504144, alpha: 1)
        alpha = 0
        
        searchBar.delegate = self
                
        addSubview(searchBar)
        addSubview(mediaTableView)
        addSubview(resultsLabel)
        addSubview(activityIndicator)
        
        searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        mediaTableView.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor).isActive = true
        mediaTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        mediaTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        mediaTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1).isActive = true
        
        resultsLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultsLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clearSearch() {
        searchBar.text = ""
        searchBar(searchBar, textDidChange: "")
        resultsLabel.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if Reachability.isConnectedToNetwork() {
            mediaTableView.media = []
            mediaTableView.reloadData()
            resultsLabel.text = ""
            currentSearchTask?.cancel()
            activityIndicator.startAnimating()
            currentSearchTask = TMDBClient.search(mediaType: mediaType,query: searchText) { (media, error) in
                guard error == nil else {
                    if error!.localizedDescription != "cancelled" {
                        self.activityIndicator.stopAnimating()
                        
                    }
                    return
                }
                self.activityIndicator.stopAnimating()
                self.resultsLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self.resultsLabel.text = "\(media.isEmpty ? "No" : String(media.count)) match found for \"\(searchText)\""
                self.mediaTableView.media = media
                self.mediaTableView.reloadData()
                
            }
        } else {
            self.resultsLabel.textColor = #colorLiteral(red: 1, green: 0.7100760341, blue: 0.7121201754, alpha: 1)
            self.resultsLabel.text = "Internet Connection not Available!"
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    


}
