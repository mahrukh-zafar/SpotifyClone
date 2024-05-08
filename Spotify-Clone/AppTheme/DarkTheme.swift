//
//  DarkTheme.swift
//  Spotify-Clone
//
//  Created by Dev on 06/05/2024.
//

import UIKit

class DarkTheme : ThemeProtocol{
    var background: UIColor = (UIColor(named: "Background")?.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)))!
    var textColor: UIColor = (UIColor(named: "TextColor")?.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark)))!
    var tint: UIColor = UIColor(named: "Tint")!
    var common: UIColor = UIColor(named: "Common")!
}
