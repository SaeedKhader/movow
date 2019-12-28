//
//  TabBar.swift
//  movow
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.clear.cgColor
        clipsToBounds = true
    }


}
