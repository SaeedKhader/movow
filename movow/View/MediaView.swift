//
//  MediaView.swift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class MediaView: UIView {
    
    var titleLabel: LargeTitleLable!
    var collectionView: MediaCollectionView!
    
    var errorLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.myBoldSystemFont(ofSize: 11)
        l.textColor = #colorLiteral(red: 1, green: 0.7100760341, blue: 0.7121201754, alpha: 1)
        l.text = "Somthing wrong happend!. Check your internet Connection, and pull down to reload."
        l.numberOfLines = 3
        l.alpha = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var emptyLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.myBoldSystemFont(ofSize: 11)
        l.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        l.text = "The list is empty now, you can add to it."
        l.alpha = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var errorImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "exclamationmark.circle.fill")
        iv.tintColor = #colorLiteral(red: 1, green: 0.4397949576, blue: 0.4357465804, alpha: 1)
        iv.contentMode = .scaleAspectFit
        iv.alpha = 0
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let a = UIActivityIndicatorView()
        a.hidesWhenStopped = true
        a.color = .white
        a.style = .medium
        a.translatesAutoresizingMaskIntoConstraints = false
        return a
    }()
    
    var bottomCollectionConstraint: NSLayoutConstraint!
    var bottomErrorLabelConstraint: NSLayoutConstraint!
    var bottomEmptyLabelConstraint: NSLayoutConstraint!

    init(title: String, mediaType: MediaType) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = LargeTitleLable(title: title)
        collectionView = MediaCollectionView(mediaType: mediaType)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(errorImageView)
        addSubview(activityIndicator)
        addSubview(emptyLabel)
        addSubview(errorLabel)
            
        setUpLayout()
    }
    
    func setSuperVC(superVC: UIViewController) {
        collectionView.superVC = superVC
    }
    
    func setMedia(media: [Media]) {
        collectionView.media = media
        collectionView.reloadData()
        bottomCollectionConstraint.isActive = !media.isEmpty
        bottomErrorLabelConstraint.isActive = false
        bottomEmptyLabelConstraint.isActive = media.isEmpty
        emptyLabel.alpha = media.isEmpty ? 1 : 0
    }
    
    func showError(hasError: Bool) {
        errorImageView.alpha = hasError ? 1 : 0
        errorLabel.alpha = hasError ? 1 : 0
        bottomCollectionConstraint.isActive = !hasError
        bottomErrorLabelConstraint.isActive = hasError
        bottomEmptyLabelConstraint.isActive = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 22.4/34.3).isActive = true
        bottomCollectionConstraint = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomCollectionConstraint.isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        errorImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15).isActive = true
        errorImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        errorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        bottomErrorLabelConstraint = errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        
        emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        emptyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        bottomEmptyLabelConstraint = emptyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    }
}
