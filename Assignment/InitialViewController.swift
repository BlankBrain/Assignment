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
  
    let decoder = JSONDecoder()
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
    
    // MARK: email login
    @IBAction func loginBtnClicked(_ sender: Any) {
         if ( Connectivity.isConnectedToInternet() == true ){
            
            if ( Validation.validateEmail(enteredEmail: self.emailTextfield.text ?? "") == true  && Validation.validatPassword(enteredPassword: passwordTextfield.text ?? "") == true  ) {
                
                login()
                
            }else{
                AlartController.showAlart(self, title: "Error", message: "Wrong Credentials!")
            }
            
            
            
         }else{
            AlartController.showAlart(self, title: "Opps!", message: "No internet connection detected !")
        }
        
    }
    
    
    
    //MARK: Fb button
  func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
    self.performSegue(withIdentifier: "loginToHome", sender: self)    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {}
    
    //MARK: login
    func login()
    {
        let loginParams = [
                        "id": self.emailTextfield.text ?? "" ,
                        "password": self.passwordTextfield.text ?? "" ,
                          ] as [String : Any]
           AF.request(API.baseURL + "user/login" , method: .post, parameters: loginParams).responseJSON {
            response in
            
           // print(response)
            do {
                let user = try self.decoder.decode(userModel.self , from: response.data! )
               // print(user)
                if(user.success == true && user.data.first?.email != self.emailTextfield.text ){
                    AlartController.showAlart(self, title: "Opps !", message: "Wrong Password !")
                }
                else if(user.success == true && user.data.first?.email == self.emailTextfield.text  ){
                    UserData.loginFromEmail = true
                    UserData.name = ( (user.data.first?.first_name ?? "") + " " + (user.data.first?.last_name ?? "" ) )
                    UserData.email = user.data.first?.email ?? ""
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                }else{
                    AlartController.showAlart(self, title: "Opps !", message: "Unexpected error !")

                }
                
            } catch { print(error) }
            
        }
        
    }
    

}

