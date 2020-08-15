//
//  InitialViewController.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 14/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit


class InitialViewController: UIViewController, LoginButtonDelegate {
  

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current,!token.isExpired {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
        else{
            
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            view.addSubview(loginButton)
            loginButton.delegate = self
            loginButton.permissions = ["email , public_profile"]
        }
       

    }
    
    
    
    
    //MARK: Fb button
  func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
    self.performSegue(withIdentifier: "loginToHome", sender: self)    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {}
    

}
