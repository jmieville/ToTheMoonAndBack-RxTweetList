//
//  Tweet.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Tweet: Object, Unboxable {
    // MARK: - Properties
    dynamic var id: Int64 = 0
    dynamic var text = ""
    dynamic var name = ""
    dynamic var created: Date?
    dynamic var imageUrl = ""
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Init with Unboxer
    convenience required init(unboxer: Unboxer) throws {
        self.init()
        
        id = try unboxer.unbox(key: "id")
        text = try unboxer.unbox(key: "text")
        name = try unboxer.unbox(keyPath: "user.name")
        created = unboxer.unbox(key: "created_at", formatter: DateFormatter.twitter)
        imageUrl = try unboxer.unbox(keyPath: "user.profile_image_url_https")
    }
    
    static func unboxMany(tweets: [JSONObject]) -> [Tweet] {
        return (try? unbox(dictionaries: tweets, allowInvalidElements: true) as [Tweet]) ?? []
    }
}
