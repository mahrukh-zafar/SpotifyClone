//
//  CustomButton.swift
//  Readings
//
//  Created by Dev on 27/04/2024.
//

import UIKit
class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
   
    
    private func setupButton() {
        
        tintColor = Theme.current.textColor
        layer.cornerRadius  = frame.size.height/2
        backgroundColor = .clear
        layer.borderWidth = 1
       layer.borderColor = UIColor.white.cgColor

    }
}

