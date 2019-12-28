//
//  CastCollectionView.swift
//  movow
//
//  Created by Saeed Khader on 20/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class CastCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cast = [Cast]()
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        delegate = self
        dataSource = self
        register(CastCell.self, forCellWithReuseIdentifier: "castCell")
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCell
        cell.activityIndicator.startAnimating()
        cell.name.text = cast[indexPath.row].name
        cell.profile.image = #imageLiteral(resourceName: "prePhoto")
        if let profilePath = cast[indexPath.row].profilePath {
            TMDBClient.downloadPosterImage(posterPath: profilePath) { (data, error) in
                guard let data = data else {
                    print(error!.localizedDescription)
                    return
                }
                cell.activityIndicator.stopAnimating()
                cell.profile.image = UIImage(data: data)
            }
        } else {
            cell.profile.image = #imageLiteral(resourceName: "noPhoto")
            cell.activityIndicator.stopAnimating()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 138)
    }
}
