//
//  Storyboard+.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
    
    extension UIStoryboard {
        func instantiateViewController<T>(ofType type: T.Type) -> T {
            return instantiateViewController(withIdentifier: String(describing: type)) as! T
        }
    }
#elseif os(OSX)
    import Cocoa
    
    extension NSStoryboard {
        func instantiateViewController<T>(ofType type: T.Type) -> T {
            return instantiateController(withIdentifier: String(describing: type)) as! T
        }
    }
#endif
