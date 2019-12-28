//
//  FavoriteButton.swift
//  movow
//
//  Created by Saeed Khader on 26/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class FavoriteButton: UIButton {
    
    let isFavoriteImg = UIImage(systemName: "suit.heart.fill")?.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)
    
    let isNotFavoriteImg = UIImage(systemName: "heart")?.withTintColor(UIColor.systemRed, renderingMode: .alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFit

        imageView?.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        imageView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isFavorite(_ isFavorite: Bool) {
        if isFavorite {
            self.setImage(isFavoriteImg, for: .normal)
        } else {
            self.setImage(isNotFavoriteImg, for: .normal)
        }
    }
}
