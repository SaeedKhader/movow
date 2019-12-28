//
//  MoviesCollectionView.swift
//  movow
//
//  Created by Saeed Khader on 19/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class MediaCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var mediaType: MediaType!
    var media = [Media]()
    var superVC: UIViewController!
    
    init(mediaType: MediaType) {
        self.mediaType = mediaType
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 15
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        backgroundColor = UIColor.clear
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCell.identifier, for: indexPath) as! MediaCell
        cell.activityIndicator.startAnimating()
        if mediaType == .movie {
            cell.title.text = media[indexPath.row].title
        } else {
            cell.title.text = media[indexPath.row].name
        }
        cell.poster.image = #imageLiteral(resourceName: "prePoster")
        if let poster = media[indexPath.row].poster {
            cell.poster.image = UIImage(data: poster)
            cell.activityIndicator.stopAnimating()
        } else if let posterPath = media[indexPath.row].posterPath {
            TMDBClient.downloadPosterImage(posterPath: posterPath) { (data, error) in
                guard let data = data else {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MediaCell
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = 12.3/22.4 * height
        return CGSize(width: width, height: height)
    }
}
