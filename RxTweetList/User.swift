//
//  User.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class User: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var id: Int64 = 0
    dynamic var name = ""
    dynamic var username = ""
    dynamic var about = ""
    dynamic var url = ""
    dynamic var imageUrl = ""
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Init with Unboxer
    convenience required init(unboxer: Unboxer) throws {
        self.init()
        
        id = try unboxer.unbox(key: "id")
        name = try unboxer.unbox(key: "name")
        username = try unboxer.unbox(key: "screen_name")
        about = try unboxer.unbox(key: "description")
        url = try unboxer.unbox(key: "url")
        imageUrl = try unboxer.unbox(key: "profile_image_url_https")
    }
}
