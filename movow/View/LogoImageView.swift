//
//  LogoImageView.swift
//  movow
//
//  Created by Saeed Khader on 21/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class LogoImageView: UIImageView {
    init() {
        super.init(image: #imageLiteral(resourceName: "movowLogo"))
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        
        widthAnchor.constraint(equalToConstant: 100).isActive = true
        heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
