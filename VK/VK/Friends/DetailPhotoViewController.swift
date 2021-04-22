//
//  DetailPhotoViewController.swift
//  VK
//
//  Created by пользовтель on 03.04.2021.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    private let VKServ = VKService()
    var selectedItem: Int = 0
    var photos: [UIImage] = []
    @IBOutlet weak var detailPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailPhoto.image = photos[selectedItem]
        detailPhoto.backgroundColor = view.backgroundColor
        let swipeLeft = UISwipeGestureRecognizer (target: self, action: #selector(swipeLeftAction))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer (target: self, action: #selector(swipeRightAction))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeftAction() {
        guard photos.count > selectedItem + 1 else {return}
        let nextImage = photos [selectedItem + 1]
        let newTempImgView = UIImageView ()
        newTempImgView.backgroundColor = view.backgroundColor
        newTempImgView.contentMode = .scaleAspectFit
        newTempImgView.image = nextImage
        newTempImgView.frame = detailPhoto.frame
        newTempImgView.frame.origin.x += detailPhoto.frame.maxX
        view.addSubview(newTempImgView)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.detailPhoto.transform = CGAffineTransform (scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
                newTempImgView.frame.origin.x = 0
            }
        } completion: { _ in
            self.detailPhoto.image = nextImage
            self.detailPhoto.transform = .identity
            newTempImgView.removeFromSuperview()
            self.selectedItem += 1
        }

    }
    @objc func swipeRightAction() {
        guard selectedItem - 1 >= 0 else {return}
        let nextImage = photos [selectedItem - 1]
        let newTempImgView = UIImageView ()
        newTempImgView.backgroundColor = view.backgroundColor
        newTempImgView.contentMode = .scaleAspectFit
        newTempImgView.image = nextImage
        newTempImgView.frame = detailPhoto.frame
        newTempImgView.transform = CGAffineTransform (scaleX: 0.8, y: 0.8)
        view.addSubview(newTempImgView)
        view.sendSubviewToBack(newTempImgView)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.detailPhoto.transform = CGAffineTransform (translationX: self.view.bounds.width, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                newTempImgView.transform = .identity
            }
        } completion: { _ in
            self.detailPhoto.image = nextImage
            self.detailPhoto.transform = .identity
            newTempImgView.removeFromSuperview()
            self.selectedItem -= 1
        }
    }

}
