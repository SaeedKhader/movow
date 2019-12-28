//
//  HeadlingLabel.swift
//  movow
//
//  Created by Saeed Khader on 20/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class HeadlineLabel: UILabel {
    init(title: String) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        text = title
        textColor = .white
        font = UIFont.myBoldSystemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
