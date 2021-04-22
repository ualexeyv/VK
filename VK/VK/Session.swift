//
//  File.swift
//  VK
//
//  Created by пользовтель on 16.04.2021.
//

import UIKit

class Session {
    static let shared = Session()
    
    private init(){ }
    
    var token: String = ""
    var userId: Int = 7831620
}
