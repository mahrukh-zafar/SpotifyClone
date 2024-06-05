//
//  ButtonColor.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import UIKit

extension UIButton{
    
    func applyThemeToFilledButton(){
        backgroundColor = Theme.current.tint
        tintColor = Theme.current.common
        layer.cornerRadius  = frame.size.height/2
        
    }
    
    func applyThemeToButton(){
        tintColor = Theme.current.textColor
        imageView?.tintColor = Theme.current.textColor
    }
}

extension UILabel{
    func applyThemeToLable(){
        textColor = Theme.current.textColor
        
    }
    func applyThemeToErrorLabel(){
        textColor = Theme.current.error
    }
    
    
}

extension UICollectionView{
    
    func applyThemeToCollectionView(){
        backgroundColor = Theme.current.background
    }
}

extension UINavigationBar{
    func applyThemeToNavBar(){
        tintColor = Theme.current.textColor
    }
}

extension UITableView{
    
    func applyThemeToTableView(){
        backgroundColor = Theme.current.background
    }
}
extension String{
    
    func capitalizingFirstLetter() -> String {
            return prefix(1).uppercased() + dropFirst()
        }
    mutating func capitalizeFirstLetter() {
            self = self.capitalizingFirstLetter()
        }
}
