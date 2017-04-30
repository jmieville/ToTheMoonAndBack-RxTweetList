//
//  TwitterAccount.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import Foundation
import Accounts
import RxSwift
import RxCocoa

struct TwitterAccount {
    // logged or not
    enum AccountStatus {
        case unavailable
        case authorized(ACAccount)
    }
    
    enum Errors: Error {
        case unableToAccessAccountType
    }
    
    // MARK: - Properties
    private let accountStore = ACAccountStore()
    
    // MARK: - Getting the current twitter account
    var `default`: Driver<AccountStatus> {
        return Observable.create({ observer in
            guard let type = self.accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter) else {
                observer.onError(Errors.unableToAccessAccountType)
                return Disposables.create()
            }
            
            // emit on any change
            let notifications = NotificationCenter.default.rx.notification(Notification.Name.ACAccountStoreDidChange)
                .map { _ in self.account(in: self.accountStore, for: type)}
                .subscribe(observer)
            
            self.accountStore.requestAccessToAccounts(with: type, options: nil, completion: { success, error in
                if success {
                    observer.onNext(self.account(in: self.accountStore, for: type))
                } else if let error = error {
                    observer.onError(error)
                }
            })
            
            return Disposables.create {
                notifications.dispose()
            }
        })
            .asDriver(onErrorJustReturn: .unavailable)
    }
    
    private func account(in accountStore: ACAccountStore, for type: ACAccountType) -> AccountStatus {
        guard let currentAccount = accountStore.accounts(with: type)?.first as? ACAccount else {
            return AccountStatus.unavailable
        }
        return AccountStatus.authorized(currentAccount)
    }
}
