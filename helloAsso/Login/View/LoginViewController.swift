//
//  LoginViewController.swift
//  helloAsso
//
//  Created by pierre-marie de jaureguiberry on 7/20/18.
//  Copyright © 2018 pierrot. All rights reserved.
//

import UIKit
import SpotifyLogin

class LogInViewController: UIViewController {
    
    var loginButton: UIButton?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let button = SpotifyLoginButton(viewController: self,
                                        scopes: [.streaming,
                                                 .userReadTop,
                                                 .playlistReadPrivate,
                                                 .userLibraryRead])
        self.view.addSubview(button)
        self.loginButton = button
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginSuccessful),
                                               name: .SpotifyLoginSuccessful,
                                               object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        loginButton?.center = self.view.center
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func loginSuccessful() {
        UserToken.sharedInstance.setToken()
        performSegue(withIdentifier: "goSearch", sender: self)
    }
}
