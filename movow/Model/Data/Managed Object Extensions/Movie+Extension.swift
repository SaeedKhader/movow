//
//  Movie+Extension.swift
//  movow
//
//  Created by Saeed Khader on 26/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation

extension Movie {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        addedAt = Date()
        isFavorite = false
        isOnWatchlist = false
    }
}
