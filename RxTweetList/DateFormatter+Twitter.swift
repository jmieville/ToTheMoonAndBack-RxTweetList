//
//  DateFormatter+Twitter.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation

extension DateFormatter {
    // provide formatter suitable to parse tweet dates
    static let twitter = DateFormatter(dateFormat: "EEE MMM dd HH:mm:ss Z yyyy")
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

