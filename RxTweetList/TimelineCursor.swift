//
//  TimelineCursor.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation

// this is a structure to accomodate for Twitter notion of
// a timeline cursor that minimizes re-fetching tweets
struct TimelineCursor {
    let maxId: Int64
    let sinceId: Int64
    
    init(max: Int64, since: Int64) {
        maxId = max
        sinceId = since
    }
    
    static var none: TimelineCursor { return TimelineCursor(max: Int64.max, since: 0) }
}

extension TimelineCursor: CustomStringConvertible {
    var description: String { return "[max: \(maxId), since: \(sinceId)]" }
}

extension TimelineCursor: Equatable {
    static func ==(lhs: TimelineCursor, rhs: TimelineCursor) -> Bool {
        return lhs.maxId==rhs.maxId && lhs.sinceId==rhs.sinceId
    }
}
