//
//  UiLabelExtensions.swift
//  19. web services
//
//  Created by Despo on 30.10.24.
//

import UIKit

extension UILabel {
    func configureScreenTitle(text: String, size: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.text = text
        self.textColor = UIColor.black
        self.font = UIFont(name: "Anek-bold", size: size)
    }
    
    func configureNunitoLabels(text: String, fontName: String, color: UIColor, size: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.text = text
        self.textColor = color
        self.font = UIFont(name: fontName, size: size)
    }
}
