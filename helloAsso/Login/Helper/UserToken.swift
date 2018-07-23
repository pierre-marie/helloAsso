//
//  UserToken.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/23/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import SpotifyLogin

class UserToken: NSObject {
    
    private var userToken = ""
    static let sharedInstance = UserToken()
    
    func setToken() {
        SpotifyLogin.shared.getAccessToken { (accessToken, error) in
            self.userToken = accessToken!
        }
    }
    
    func getToken() -> String {
        return userToken
    }
}
