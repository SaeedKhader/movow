//
//  GoBackBarButtonItem.swift
//  movow
//
//  Created by Saeed Khader on 28/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class GoBackBarButtonItem: UIBarButtonItem {
    
    let backImg = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
    let backBtn = UIButton()
    var superVC: UIViewController!
    
    init(superVC: UIViewController) {
        super.init()
        self.superVC = superVC
        backBtn.setImage(backImg, for: .normal)
        backBtn.layer.opacity = 0.6
        backBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        customView = backBtn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goBack() {
        superVC.navigationController?.popViewController(animated: true)
    }
}
