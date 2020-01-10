//
//  UserManager.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 08.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import UIKit

@propertyWrapper
struct UserDefaultSettings<T> {
    private let key: String
    private let value: T
    private let defaults: UserDefaults

    init(_ key: String, value: T, for defaults: UserDefaults = .standard) {
        self.key = key
        self.value = value
        self.defaults = defaults
    }

    var wrappedValue: T {
        get {
            return defaults.object(forKey: key) as? T ?? value
        }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
}

final class UserManager {
    private static let isAuthorizedKey = "isAuthorized"
    private static let currentAuthTokenKey = "currentAuthToken"

    static let shared = UserManager()
    
    private init() {}
    
    @UserDefaultSettings(isAuthorizedKey, value: true)
    var isAuthorized: Bool
    
    @UserDefaultSettings(currentAuthTokenKey, value: "")
    var currentAuthToken: String
    
}
