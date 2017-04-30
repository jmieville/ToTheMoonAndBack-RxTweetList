//
//  ListTimelineViewController.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit
import RxSwift
import Then

class ListTimelineViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageView: UIView!
    
    private let bag = DisposeBag()
    fileprivate var viewModel: ListTimelineViewModel!
    fileprivate var navigator: Navigator!
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: ListTimelineViewModel) -> ListTimelineViewController {
        return storyboard.instantiateViewController(ofType: ListTimelineViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableViewAutomaticDimension
        bindUI()
    }
    
    func bindUI() {
        //bind button to the people view controller
        //show tweets in table view
        //show message when no account available
    }
}
