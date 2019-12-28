//
//  CrewView.swift
//  movow
//
//  Created by Saeed Khader on 27/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class CrewView: UIView {
    
    enum CrewType: String {
        case Writer
        case Director
        case Creator
    }
    
    var crewTitleLabel: HeadlineLabel!
    let crewCollectionView = CrewCollectionView()

    var crewCVHeightConstraint: NSLayoutConstraint?

    init(crew: [Crew], crewType: CrewType) {
        super.init(frame: .zero)
        
        crewTitleLabel = HeadlineLabel(title: "\(crewType.rawValue)\(crew.count > 1 ? "s" : "")")
        crewCollectionView.crew = crew
        crewCollectionView.reloadData()
        
        addSubview(crewTitleLabel)
        addSubview(crewCollectionView)
        
        
        crewTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        crewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        crewCollectionView.topAnchor.constraint(equalTo: crewTitleLabel.bottomAnchor, constant: 5).isActive = true
        crewCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        crewCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        crewCVHeightConstraint = crewCollectionView.heightAnchor.constraint(equalToConstant: 18)
        crewCVHeightConstraint?.isActive = true
        crewCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        crewCollectionView.heightConstrint = crewCVHeightConstraint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
