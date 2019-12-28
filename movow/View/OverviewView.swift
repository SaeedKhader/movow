//
//  OverviewView.swift
//  movow
//
//  Created by Saeed Khader on 27/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class OverviewView: UIView {
    
    let overviewTitleLabel = HeadlineLabel(title: "Overview")
    
    let overviewContentLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.mySystemFont(ofSize: 15)
        l.textColor = .white
        l.numberOfLines = 10
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    init(overview: String) {
        super.init(frame: .zero)
        
        overviewContentLabel.text = overview
        
        addSubview(overviewTitleLabel)
        addSubview(overviewContentLabel)
        
        
        overviewTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overviewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        overviewContentLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 5).isActive = true
        overviewContentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        overviewContentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        overviewContentLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
