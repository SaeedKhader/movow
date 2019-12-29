//
//  ScrollingStackView.swift
//  movow
//
//  Created by Saeed Khader on 29/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation
import UIKit

class ScrollingStackView: UIScrollView {
    
    let viewContent: UIStackView = {
        let s = UIStackView()
        s.alignment = .fill
        s.axis = .vertical
        s.distribution = .fill
        s.spacing = 40
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    var topConstant: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        addSubview(viewContent)
        
        topConstant = viewContent.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        topConstant.isActive = true
        viewContent.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        viewContent.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewContent.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrangedSubview(_ view: UIView) {
        viewContent.addArrangedSubview(view)
    }
    
    func spacing(_ value: CGFloat) {
        viewContent.spacing = value
        topConstant.constant = 0
    }
    
    func setUpLayout(topConstant: CGFloat) {
        if let superview = superview {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: topConstant).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        }
    }
}
