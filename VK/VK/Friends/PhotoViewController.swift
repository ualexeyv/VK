//
//  PhotoViewController.swift
//  VK
//
//  Created by пользовтель on 10.03.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    private let VKServ = VKService()
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    var photoArray = [UIImage]()
    var selectedItem: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            [weak self] in self?.VKServ.loadUserData(data: "users.get", userId: "219043724")
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            [weak self] in self?.VKServ.loadPhotoData(userId: "219043724")
        }
    }
    
}
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photoArray[indexPath.item]
        cell.image.image = photo
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = .zero
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = UIScreen.main.bounds.width
            let itemSize = (screenWidth / 3) - 10

            return CGSize(width: itemSize, height: itemSize)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.item
        self.performSegue(withIdentifier: "detailPhoto", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPhoto",
           let dest = segue.destination as? DetailPhotoViewController {
            dest.selectedItem = selectedItem
            dest.photos = photoArray
        }
    }
}
