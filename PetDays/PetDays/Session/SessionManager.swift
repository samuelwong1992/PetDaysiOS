//
//  SessionManager.swift
//  PetDays
//
//  Created by Samuel Wong on 15/6/2022.
//

import Foundation

fileprivate var _sessionManager: SessionManager = SessionManager()

typealias ObservableTrigger = (observable: SessionManager.Observable, trigger: () -> Void)

class SessionManager {
    static var current: SessionManager {
        get {
            return _sessionManager
        }
    }
    
    static func resetSessionManager() {
        _sessionManager = SessionManager()
    }
    
    enum Observable {
        case user
        case profile
        case pet
        case daycare
        case posts
    }
    
    var user: User? {
        didSet {
            hitSubsscription(forOservableType: .user)
        }
    }
    
    var profile: Profile? {
        didSet {
            hitSubsscription(forOservableType: .profile)
        }
    }
    
    var pet: Pet? {
        didSet {
            hitSubsscription(forOservableType: .pet)
        }
    }
    
    var daycare: Daycare? {
        didSet {
            hitSubsscription(forOservableType: .daycare)
        }
    }
    
    var posts: [Post] = [] {
        didSet {
            hitSubsscription(forOservableType: .posts)
        }
    }
    
    //TODO: Check for memory leaks
    private var subscriptions: [ObservableTrigger] = []
    private func hitSubsscription(forOservableType ot: Observable) {
        DispatchQueue.main.async {
            for ot in self.subscriptions.filter({ $0.observable == ot }) {
                ot.trigger()
            }
        }
    }
}

extension SessionManager {
    func subscribe(toObserserve observable: Observable, completion: @escaping (() -> Void)) {
        subscriptions.append((observable, completion))
    }
}
