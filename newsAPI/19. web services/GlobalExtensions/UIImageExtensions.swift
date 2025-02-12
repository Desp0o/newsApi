//
//  UiImageExtensions.swift
//  19. web services
//
//  Created by Despo on 30.10.24.
//

import UIKit
import Foundation

extension UIImageView {
    func configureImgBasicSettings() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.contentMode = .scaleAspectFill
    }
}

extension UIImageView{
  func imageFrom(url:URL){
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url){
        if let image = UIImage(data:data){
          DispatchQueue.main.async{
            self?.image = image
          }
        }
      }
    }
  }
}

