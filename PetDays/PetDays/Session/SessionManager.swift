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
    }
    
    var user: User? {
        didSet {
            for ot in subscriptions.filter({ $0.observable == .user }) {
                ot.trigger()
            }
        }
    }
    var profile: Profile? {
        didSet {
            for ot in subscriptions.filter({ $0.observable == .profile }) {
                ot.trigger()
            }
        }
    }
    var pet: Pet? {
        didSet {
            for ot in subscriptions.filter({ $0.observable == .pet }) {
                ot.trigger()
            }
        }
    }
    var daycare: Daycare? {
        didSet {
            for ot in subscriptions.filter({ $0.observable == .daycare }) {
                ot.trigger()
            }
        }
    }
    
    //TODO: Check for memory leaks
    private var subscriptions: [ObservableTrigger] = []
}

extension SessionManager {
    func subscribe(toObserserve observable: Observable, completion: @escaping (() -> Void)) {
        subscriptions.append((observable, completion))
    }
}
