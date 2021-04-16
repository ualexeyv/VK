//
//  File.swift
//  VK
//
//  Created by пользовтель on 16.04.2021.
//

import Foundation

class Session {
    static let shared = Session()
    
    private init(){}
    
    var token: String
    var userId: Int
}
