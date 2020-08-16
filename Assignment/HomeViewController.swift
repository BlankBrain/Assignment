//
//  HomeViewController.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 14/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class HomeViewController: UIViewController, LoginButtonDelegate {
    
    

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var loginBtn: RoundButton!
    
    
    //MARK: viewdidload
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
    if let token = AccessToken.current,!token.isExpired {
    self.loginBtn.isHidden = true
    let token = token.tokenString
    let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                            parameters: ["fields": "email , name"] ,
                                            tokenString: token, version: nil,
                                            httpMethod: .get)
        
    request.start(completionHandler: {  connection , result , error in
               
    let resultNew = result as? [String:Any]
    let email = resultNew!["email"]  as! String
    let name = resultNew!["name"]  as! String
    self.email.text = email
    self.name.text = name       })
        
    }

    let loginButton = FBLoginButton()
    loginButton.center = view.center
    view.addSubview(loginButton)
    loginButton.delegate = self
        
   
    if(UserData.loginFromEmail == true){
        loginButton.isHidden = true
        email.text = UserData.email
        name.text = UserData.name
    }
    }
    
    
    //MARK: fb button
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    self.performSegue(withIdentifier: "logout", sender: self)
    }
    @IBAction func logoutBtnClicked(_ sender: Any) {
        UserData.loginFromEmail = false
        UserData.firstLogin = false
        UserData.email = ""
        UserData.name = ""
        self.performSegue(withIdentifier: "logout", sender: self)

    }
    

   

}
