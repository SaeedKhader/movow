//
//  Mediaswift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class MediaMainInfoView: UIView {
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.myBoldSystemFont(ofSize: 20)
        l.textColor = .white
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    var votesView: VotesView!
    
    let genresCollectionView = GenresCollectionView()
    
    var genreCVHeightConstraint: NSLayoutConstraint?
    
    init(media: Media, mediaType: MediaType) {
        super.init(frame: .zero)
        
        let title = mediaType == .movie ? media.title : media.name
        let year = mediaType == .movie ? media.releaseYearForMovie : media.releaseYearForTV
        titleLabel.attributedText = getAttributedStringTitle(title: title!, year: year)
        
        votesView = VotesView(voteAverage: media.voteAverage, voteCount: media.voteCount)
        genresCollectionView.genreIds = media.genreIds
        genresCollectionView.reloadData()
        
        
        addSubview(titleLabel)
        addSubview(genresCollectionView)
        addSubview(votesView)
        
        setUpLayout()
        genresCollectionView.heightConstrint = genreCVHeightConstraint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAttributedStringTitle(title: String, year: String) -> NSMutableAttributedString {
        let titleAttr: [NSAttributedString.Key: Any] = [.font:UIFont.myBoldSystemFont(ofSize: 20),
                                                        .foregroundColor: UIColor.white]
        let yearAttr: [NSAttributedString.Key: Any] = [.font:UIFont.myBoldSystemFont(ofSize: 18),
                                                       .foregroundColor: #colorLiteral(red: 0.5835636258, green: 0.6289651394, blue: 1, alpha: 0.6000642123) ]
        
        let titleAndYear = NSMutableAttributedString(string: "\(title)", attributes: titleAttr)
        titleAndYear.append(NSMutableAttributedString(string: " (\(year))", attributes: yearAttr))
        return titleAndYear
    }
    
    func setUpLayout() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: votesView.leadingAnchor, constant: -25).isActive = true
        
        votesView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        votesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        votesView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        
        genresCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        genresCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        genresCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        genresCollectionView.trailingAnchor.constraint(equalTo: votesView.leadingAnchor, constant: -25).isActive = true
        genreCVHeightConstraint = genresCollectionView.heightAnchor.constraint(equalToConstant: 20)
        genreCVHeightConstraint?.isActive = true
    }
}
