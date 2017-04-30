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
import RxRealmDataSources

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
        title = "@\(viewModel.list.username)/\(viewModel.list.slug)"
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action:
                nil)
        bindUI()
        navigationItem.rightBarButtonItem!.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.navigator.show(segue: .listPeople(this.viewModel.account,
                                                       this.viewModel.list), sender: this)
            })
            .addDisposableTo(bag)
        let dataSource = RxTableViewRealmDataSource<Tweet>(cellIdentifier:
        "TweetCellView", cellType: TweetCellView.self) { cell, _, tweet in
            cell.update(with: tweet)
        }
        viewModel.tweets
            .bindTo(tableView.rx.realmChanges(dataSource))
            .addDisposableTo(bag)
        viewModel.loggedIn
            .drive(messageView.rx.isHidden)
            .addDisposableTo(bag)
    }
    
    func bindUI() {
        //bind button to the people view controller
        //show tweets in table view
        //show message when no account available
    }
}
