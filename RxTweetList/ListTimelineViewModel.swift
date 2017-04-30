//
//  ListTimelineViewModel.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import RxCocoa

class ListTimelineViewModel {
    private let bag = DisposeBag()
    private let fetcher: TimelineFetcher
    
    let list: ListIdentifier
    let account: Driver<TwitterAccount.AccountStatus>
    
    // MARK: - Input
    var paused: Bool = false {
        didSet {
            fetcher.paused.value = paused
        }
    }
    // MARK: - Output
    private(set) var tweets: Observable<(AnyRealmCollection<Tweet>,
    RealmChangeset?)>!
    private(set) var loggedIn: Driver<Bool>!
    // MARK: - Init
    init(account: Driver<TwitterAccount.AccountStatus>,
         list: ListIdentifier,
         apiType: TwitterAPIProtocol.Type = TwitterAPI.self) {
        
        self.account = account
        self.list = list
        
        // fetch and store tweets
        fetcher = TimelineFetcher(account: account, list: list, apiType: apiType)
        
        bindOutput()
        fetcher.timeline
            .subscribe(Realm.rx.add(update: true))
            .addDisposableTo(bag)
    }
    
    // MARK: - Methods
    private func bindOutput() {
        //bind tweets
        //bind if an account is available
        guard let realm = try? Realm() else {
            return
        }
        tweets = Observable.changesetFrom(realm.objects(Tweet.self))
        loggedIn = account
            .map { status in
                switch status {
                case .unavailable: return false
                case .authorized: return true
                }
            }
            .asDriver(onErrorJustReturn: false)
    }
}

