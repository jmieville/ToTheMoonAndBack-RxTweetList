//
//  Tweet+.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import RxDataSources

extension Tweet: IdentifiableType {
    typealias Identity = Int64
    public var identity: Int64 { return id }
}
