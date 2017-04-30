//
//  Tableview+.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
    
    extension UITableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
        }
    }
    
#elseif os(OSX)
    import Cocoa
    
    extension NSTableView {
        func dequeueCell<T>(ofType type: T.Type) -> T {
            return make(withIdentifier: String(describing: T.self), owner: self) as! T
        }
    }
    
#endif
