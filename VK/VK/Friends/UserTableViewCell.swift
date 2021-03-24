//
//  UserTableViewCell.swift
//  VK
//
//  Created by пользовтель on 07.03.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

   
    @IBOutlet weak var nameLabl: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabl.text = ""
    }
    
    
    func setImg (img: UIImage) {
        
    }
}
