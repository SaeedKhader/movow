//
//  CastCell.swift
//  movow
//
//  Created by Saeed Khader on 20/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    let profile: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        return iv
    }()
      
    let name: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.myBoldSystemFont(ofSize: 11)
        l.textColor = #colorLiteral(red: 0.3939759731, green: 0.7512745261, blue: 1, alpha: 1)
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



        contentView.addSubview(profile)
        contentView.addSubview(name)
        contentView.addSubview(activityIndicator)

        profile.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        profile.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        profile.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        profile.heightAnchor.constraint(equalTo: profile.widthAnchor, multiplier: 1.2).isActive = true

        name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        name.topAnchor.constraint(equalTo: profile.bottomAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: profile.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: profile.centerYAnchor).isActive = true
        

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
