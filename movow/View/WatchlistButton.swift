//
//  WatchlistButton.swift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class WatchlistButton: UIButton {
    
    let isOnWatchlistImg = UIImage(systemName: "checkmark.seal.fill")?.withTintColor(UIColor.systemGreen, renderingMode: .alwaysOriginal)
    
    let isNotOnWatchlistImg = UIImage(systemName: "plus")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
    
    var widthConstaint: NSLayoutConstraint!
    
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

        imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        widthConstaint = imageView?.widthAnchor.constraint(equalToConstant: 30)
        widthConstaint.isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isOnWatchlist(_ isOnWatchlist: Bool) {
        if isOnWatchlist {
            self.setImage(isOnWatchlistImg, for: .normal)
            widthConstaint.constant = 30
        } else {
            self.setImage(isNotOnWatchlistImg, for: .normal)
            widthConstaint.constant = 20
        }
    }
}
