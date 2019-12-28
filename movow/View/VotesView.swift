//
//  VotesView.swift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class VotesView: UIView {
    
    let starImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star.circle.fill")
        iv.tintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let voteAverageLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.myBoldSystemFont(ofSize: 14)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let voteCountLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.myBoldSystemFont(ofSize: 12)
        l.textColor = #colorLiteral(red: 0.5835636258, green: 0.6289651394, blue: 1, alpha: 0.6000642123)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    init(voteAverage: Double, voteCount: Int) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let voteAvgAttr: [NSAttributedString.Key: Any] = [.font:UIFont.myBoldSystemFont(ofSize: 14),
        .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        let voteOfAttr: [NSAttributedString.Key: Any] = [.font:UIFont.myBoldSystemFont(ofSize: 13),
        .foregroundColor: #colorLiteral(red: 0.5835636258, green: 0.6289651394, blue: 1, alpha: 0.4111194349) ]
        let fullVote = NSMutableAttributedString(string: "\(voteAverage)", attributes: voteAvgAttr)
        fullVote.append(NSMutableAttributedString(string: "/10", attributes: voteOfAttr))
        voteAverageLabel.attributedText = fullVote
        voteCountLabel.text = String(voteCount)
        
        addSubview(starImageView)
        addSubview(voteAverageLabel)
        addSubview(voteCountLabel)
        
        starImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        starImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        voteAverageLabel.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 2).isActive = true
        voteAverageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        voteCountLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor).isActive = true
        voteCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
