//
//  GenreCell.swift
//  movow
//
//  Created by Saeed Khader on 25/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class GenreCell: UICollectionViewCell {
    
    static let identifier = "genreCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.myBoldSystemFont(ofSize: 11)
        label.textColor = #colorLiteral(red: 0.1192567423, green: 0.1308124065, blue: 0.2131014168, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(nameLabel)
        
        layer.backgroundColor = #colorLiteral(red: 0.2883426249, green: 0.3080199361, blue: 0.5143914819, alpha: 1)
        layer.cornerRadius = 3
        
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
