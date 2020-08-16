//
//  SignupViewController.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 14/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import Alamofire  

class SignupViewController: UIViewController {

    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var countryCode: RoundButton!
    
    
    
    override func viewDidLoad() {
          super.viewDidLoad()

      }
    
    
    //MARK: dropdown for country codes
    let tableview = UITableView()
    let transparentView = UIView()
    
    func addTransparentView(frames: CGRect){
           let window = UIApplication.shared.keyWindow
           transparentView.frame = window?.frame ?? self.view.frame
           self.view.addSubview(transparentView)
        tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y , width: frames.width, height: 0)
        
        self.view.addSubview(tableview)
        tableview.layer.cornerRadius = 5
           transparentView.backgroundColor = UIColor.lightGray
           let tap = UITapGestureRecognizer(target: self, action: #selector( removeTransparentView))
           transparentView.addGestureRecognizer(tap)
           transparentView.alpha = 0
           UIView.animate(withDuration: 0.4, delay: 0 , options: .curveEaseOut, animations: {
           self.transparentView.alpha = 0.5
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y , width: frames.width, height: 200)
           }, completion: nil)
            
       }
       
       @objc func removeTransparentView(frames: CGRect){
        UIView.animate(withDuration: 0.4, delay: 0 , options: .curveEaseOut, animations: {
        self.transparentView.alpha = 0 }, completion: nil)
        self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y , width: frames.width, height: 0)

       }
       
    
  
    
  //MARK: functions
    
    @IBAction func countryCodeSelected(_ sender: Any) {
        addTransparentView(frames: countryCode.frame )
        
    }
    

    @IBAction func signupBtnClicked(_ sender: Any) {
        if( Validation.validate(text: first_name.text ?? "" ) == true && Validation.validate(text: last_name.text ?? ""  ) == true && Validation.validateEmail(enteredEmail: email.text ?? "") ==  true && Validation.validate(text: address.text ?? "" ) == true && phone.text?.count == 11 && password.text?.count ?? 1 > 5 && password.text == confirmPassword.text)
        {
            //MARK: signup code
            
            
            
        }else{
            AlartController.showAlart(self, title: "Error !", message: "Signup form isn't filled correctly!")
        }
        
        
        
    }
    
    
    
    
   
}
