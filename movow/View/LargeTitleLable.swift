//
//  LargeTitleLable.swift
//  movow
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import UIKit

class LargeTitleLable: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        text = title
        textColor = .white
        font = UIFont.myBlackSystemFont(ofSize: 25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
