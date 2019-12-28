//
//  MoviesTableView.swift
//  movow
//
//  Created by Saeed Khader on 21/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class MediaTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var mediaType: MediaType!
    var media = [Media]()
    var superVC: UIViewController!
    
    init(mediaType: MediaType) {
        super.init(frame: .zero, style: .plain)
        self.mediaType = mediaType
        delegate = self
        dataSource = self
        separatorStyle = .none
        separatorColor = .blue
        backgroundColor = .red
        register(MovieTCell.self, forCellReuseIdentifier: "movieTCell")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTCell", for: indexPath) as! MovieTCell
        cell.poster.image = #imageLiteral(resourceName: "prePoster")
        cell.activityIndicator.startAnimating()
        if mediaType == .tv {
            cell.year.text = "(\(media[indexPath.row].releaseYearForTV))"
            cell.title.text = media[indexPath.row].name
        } else {
            cell.year.text = "(\(media[indexPath.row].releaseYearForMovie))"
            cell.title.text = media[indexPath.row].title
        }
        cell.overview.text = media[indexPath.row].overview
        if let posterPath = media[indexPath.row].posterPath {
            TMDBClient.downloadPosterImage(posterPath: posterPath) { (data, error) in
                guard let data = data else {
                    print(error!.localizedDescription)
                    return
                }
                cell.poster.image = UIImage(data: data)
                cell.activityIndicator.stopAnimating()
            }
        } else {
            cell.poster.image = #imageLiteral(resourceName: "noPoster")
            cell.activityIndicator.stopAnimating()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieTCell
        if mediaType == .movie {
            let detailsVC = MovieDetailsViewController()
            detailsVC.movie = media[indexPath.row]
            detailsVC.poster = cell.poster.image
            superVC.navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            let detailsVC = TVShowDetailsViewController()
            detailsVC.tvShow = media[indexPath.row]
            detailsVC.poster = cell.poster.image
            superVC.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    
}

class MovieTCell: UITableViewCell {
    let poster: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    let title : UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.textAlignment = .left
        l.font = UIFont.myBoldSystemFont(ofSize: 20)
        l.adjustsFontSizeToFitWidth = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let year: UILabel = {
        let l = UILabel()
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3508936216)
        l.font = UIFont.myBoldSystemFont(ofSize: 15)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    } ()
    
    let overview: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = UIFont.mySystemFont(ofSize: 13)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 3
        return l
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView()
        a.hidesWhenStopped = true
        a.color = .white
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(poster)
        addSubview(title)
        addSubview(year)
        addSubview(overview)
        addSubview(activityIndicator)
        
        poster.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        poster.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        poster.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 80).isActive = true
        poster.heightAnchor.constraint(equalTo: poster.widthAnchor, multiplier: 1.4).isActive = true
        
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 13).isActive = true
        title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        year.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2).isActive = true
        year.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 20).isActive = true
        year.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        overview.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 8).isActive = true
        overview.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 20).isActive = true
        overview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: poster.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: poster.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
