//
//  UserTableViewCell.swift
//  VK
//
//  Created by пользовтель on 07.03.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
    }
    
    
    func setImg (img: UIImage) {
        
    }
}
