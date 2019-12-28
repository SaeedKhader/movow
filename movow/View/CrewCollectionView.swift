//
//  CrewCollectionView.swift
//  movow
//
//  Created by Saeed Khader on 20/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class CrewCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var crew = [Crew]()
    
    var heightConstrint: NSLayoutConstraint?
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        delegate = self
        dataSource = self
        register(CrewCell.self, forCellWithReuseIdentifier: "crewCell")
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        crew.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "crewCell", for: indexPath) as! CrewCell
        setUpNameCell(index: indexPath.row, cell: cell)
        heightConstrint?.constant = collectionView.contentSize.height
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = CrewCell()
        cell.nameLabel.text = crew[indexPath.row].name + ( indexPath.row != crew.count - 1 ? "," : "")
        return cell.nameLabel.intrinsicContentSize
    }
    
    private func setUpNameCell(index: Int, cell: CrewCell) {
        let nameAttr: [NSAttributedString.Key: Any] = [ .foregroundColor: #colorLiteral(red: 0.3939759731, green: 0.7512745261, blue: 1, alpha: 1) ]
        let commaAttr: [NSAttributedString.Key: Any] = [ .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        let name = NSMutableAttributedString(string: crew[index].name, attributes: nameAttr)
        if ( index != crew.count - 1 ) {
            name.append(NSMutableAttributedString(string: ",", attributes: commaAttr))
        }
        cell.nameLabel.attributedText = name
    }
}

class CrewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.myBoldSystemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
