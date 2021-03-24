//
//  RoundedPhoto.swift
//  VK
//
//  Created by пользовтель on 16.03.2021.
//

import UIKit

@IBDesignable class roundedImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
        }
        
    }
}
