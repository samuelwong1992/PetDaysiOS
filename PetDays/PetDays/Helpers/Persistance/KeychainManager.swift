//
//  KeychainManager.swift
//  PetDays
//
//  Created by Samuel Wong on 19/6/2022.
//

import Foundation

final class KeychainManager: PersistanceManager {
    private var cachedAPIToken: String? {
        get {
            if let _cachedAPIToken = _cachedAPIToken {
                return String.isNilOrEmpty(_cachedAPIToken) ? nil : _cachedAPIToken
            }
            return nil
        }
        set {
            _cachedAPIToken = newValue
        }
    }
    private var _cachedAPIToken: String?
    
    enum KeychainService {
        case APIAccessToken
        
        private var service: String {
            switch self {
            case .APIAccessToken : return "access_token"
            }
        }
        
        private var account: String {
            switch self {
            case .APIAccessToken : return "API"
            }
        }
        
        var query: [CFString:Any] {
            return [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: self.service,
                kSecAttrAccount: self.account,
            ]
        }
    }
}

extension KeychainManager {
    func getAPIToken() -> String? {
        if let cachedAPIToken = cachedAPIToken {
            return cachedAPIToken
        }
        
        self.cachedAPIToken = self.read(service: .APIAccessToken)
        return cachedAPIToken
    }
    
    func saveAPIToken(token: String) {
        self.save(token, service: .APIAccessToken)
        self.cachedAPIToken = token
    }
    
    func clearAPIToken() {
        self.delete(service: .APIAccessToken)
        self.cachedAPIToken = nil
    }
}

extension KeychainManager {
    private func save(_ data: String, service: KeychainService) {
        let token = Data(data.utf8)
        
        let data: [CFString:Any] = [
            kSecValueData: token,
        ]
        
        let addAttributes = service.query.merging(data) { (current, _) in current }
        let status = SecItemAdd(addAttributes as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            SecItemUpdate(service.query as CFDictionary, data as CFDictionary)
        } else if status != errSecSuccess {
            print("Error: \(status)")
        }
    }

    private func read(service: KeychainService) -> String? {
        let readAttributes = service.query.merging([kSecReturnData: true]) { (current, _) in current }
        
        var result: AnyObject?
        SecItemCopyMatching(readAttributes as CFDictionary, &result)
        
        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }

    private func delete(service: KeychainService) {
        SecItemDelete(service.query as CFDictionary)
    }
}
