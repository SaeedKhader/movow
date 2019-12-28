//
//  CastView.swift
//  movow
//
//  Created by Saeed Khader on 27/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class CastView: UIView {
    
    var castTitleLabel = HeadlineLabel(title: "Cast")

    var castCollectionView = CastCollectionView()
    
    init(cast: [Cast]) {
        super.init(frame: .zero)
        
        castCollectionView.cast = cast
        castCollectionView.reloadData()
        
        addSubview(castTitleLabel)
        addSubview(castCollectionView)
        
        castTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        castTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        castCollectionView.topAnchor.constraint(equalTo: castTitleLabel.bottomAnchor, constant: 5).isActive = true
        castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        castCollectionView.heightAnchor.constraint(equalToConstant: 138).isActive = true
        castCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
