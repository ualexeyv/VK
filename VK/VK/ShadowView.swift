//
//  ShadowView.swift
//  VK
//
//  Created by пользовтель on 16.03.2021.
//

import UIKit

@IBDesignable class shadowView: UIView {
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
        animation.toValue = 0.7
            animation.stiffness = 200
            animation.mass = 2
            animation.duration = 0.2
            animation.beginTime = CACurrentMediaTime()
            animation.fillMode = CAMediaTimingFillMode.backwards
            
        self.layer.add(animation, forKey: nil)

    }
}
