//
//  CustomPushAnimator.swift
//  VK
//
//  Created by пользовтель on 13.04.2021.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else {return}
        guard let destination = transitionContext.viewController(forKey: .to) else {return}
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
    //    destination.view.transform = CGAffineTransform (translationX: 0, y: -source.view.frame.height)
        let translation = CGAffineTransform (translationX: -source.view.frame.height, y: source.view.frame.width)
        let rotate = CGAffineTransform (rotationAngle: CGFloat.pi/2)
        
        destination.view.transform = translation.concatenating(rotate)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8, animations:  {
                let translation = CGAffineTransform (translationX: 0, y: destination.view.frame.width - source.view.frame.height)
                let rotate = CGAffineTransform (rotationAngle: 0)
                destination.view.transform = translation.concatenating(rotate)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                destination.view.transform = .identity
            }
        
        } completion: { (finished) in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
        

    }
    
    
}
