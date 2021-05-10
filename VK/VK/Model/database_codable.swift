//
//  database_codable.swift
//  VK
//
//  Created by пользовтель on 26.04.2021.
//

import UIKit
//import RealmSwift

class FriendResponse: Decodable {
    var response: Friends
}
class Friends: Decodable {
    var items: [Friend]
}
class Friend: Decodable {
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
        case id
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.id = try values.decode(Int.self, forKey: .id)
        self.avatar = try values.decode(String.self, forKey: .avatar)
    }
}
class PhotoResponse: Decodable {
    var response: Photos
}
class Photos: Decodable {
    var items: [Photo]
}
class Photo: Decodable {
    var id: Int = 0
    var url: String = ""
    
    enum CodingKeys: String, CodingKey {
        case sizes
        case id
    }
    enum SizesKeys: String, CodingKey {
        case url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        var sizesValues = try values.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizeValue = try sizesValues.nestedContainer(keyedBy: SizesKeys.self)
        self.url = try firstSizeValue.decode(String.self, forKey: .url)
    }

}

class GroupResponse: Decodable {
    var response: Groups
}
class Groups: Decodable {
    var items: [Group]
}
class Group: Decodable {
    var name: String = ""
    var avatar: String = ""
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case avatar = "photo_50"
        case id
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.id = try values.decode(Int.self, forKey: .id)
        self.avatar = try values.decode(String.self, forKey: .avatar)
    }
}
