import Foundation
import UIKit


struct AppTheme{
    let backgroundColor: UIColor
        let textColor: UIColor
        let buttonColor: UIColor
}

let lightTheme = AppTheme(backgroundColor: .systemPink, textColor: .black, buttonColor: .blue)
let darkTheme = AppTheme(backgroundColor: .black, textColor: .white, buttonColor: .orange)

class ThemeManager{
  
    static let shared = ThemeManager()
    static var currentTheme: AppTheme = lightTheme{
        didSet{
            applyTheme()
            NotificationCenter.default.post(name: .themeChangedNotification, object: nil)
        }
    }
    
    
    static func applyTheme(){
        
        let sharedApplication = UIApplication.shared
        
        sharedApplication.delegate?.window??.backgroundColor = currentTheme.backgroundColor
        sharedApplication.delegate?.window??.tintColor = currentTheme.buttonColor
        
        //NotificationCenter.default.post(name: Notification.Name("ThemeChanged"), object: nil)
    }
    
    static func setTheme(_ theme: AppTheme) {
            currentTheme = theme
        }
    
}
extension Notification.Name {
    static let themeChangedNotification = Notification.Name("ThemeChangedNotification")
}
