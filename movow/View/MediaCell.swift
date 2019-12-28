//
//  MovieCell.swift
//  movow
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import UIKit

class MediaCell: UICollectionViewCell {
    
    static let identifier = "mediaCell"
    
    let poster: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let title: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.myBoldSystemFont(ofSize: 12)
        l.textColor = .white
        l.numberOfLines = 2
        l.textAlignment = .center
        return l
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView()
        a.hidesWhenStopped = true
        a.color = .white
        a.style = .medium
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor.black.cgColor
        clipsToBounds = true
        
        contentView.addSubview(poster)
        contentView.addSubview(title)
        contentView.addSubview(activityIndicator)
  
        poster.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        poster.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        poster.heightAnchor.constraint(equalTo: poster.widthAnchor, multiplier: 18.5/12.3).isActive = true
        
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: poster.bottomAnchor).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: poster.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: poster.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
