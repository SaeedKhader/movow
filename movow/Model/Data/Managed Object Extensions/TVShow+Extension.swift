//
//  TVShow+Extension.swift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation

extension TVShow {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        addedAt = Date()
        isFavorite = false
        isOnWatchlist = false
    }
}
