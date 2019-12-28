//
//  BigPosterView.swift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class BigPosterView: UIView {
    
    let posterImageView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    init(poster: UIImage) {
        super.init(frame: .zero)
        
        posterImageView.image = poster
        
        addSubview(posterImageView)
        
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 18.5/12.3).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
