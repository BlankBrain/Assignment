//
//  SignupViewController.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 14/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import UIKit
import Alamofire  

class SignupViewController: UIViewController ,UITextFieldDelegate {
  
    
    let decoder = JSONDecoder()
    var Code = codeModel(success: false)
    var selectedCode:String = "+880"
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var countryCode: RoundButton!
    
    //MARK: viewdidload
    override func viewDidLoad() {
          super.viewDidLoad()
        getCodes()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(cell.self, forCellReuseIdentifier: "cell")

      }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
          self.first_name.delegate = self
          self.last_name.delegate = self
          self.email.delegate = self
          self.phone.delegate = self
          self.address.delegate = self
          self.password.delegate = self
        
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
            self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y + 5 , width: frames.width, height: CGFloat(self.Code.data.count * 30))
           }, completion: nil)
            
       }
       
       @objc func removeTransparentView(){
        let frames = countryCode.frame
        UIView.animate(withDuration: 0.4, delay: 0 , options: .curveEaseOut, animations: {
        self.transparentView.alpha = 0 }, completion: nil)
        self.tableview.frame = CGRect(x: frames.origin.x, y: frames.origin.y , width: frames.width, height: 0)

       }
    
  //MARK: functions
    @IBAction func countryCodeSelected(_ sender: Any) {
        addTransparentView(frames: countryCode.frame )
    }

    //MARK: get country codes
    func getCodes(){
        AF.request(API.baseURL + "code/list" , method: .get).responseJSON { response in
           // print(response)
             do{ let codes = try self.decoder.decode(codeModel.self , from: response.data! )
               // print(codes)
                self.Code = codes
               //print(self.Code)
                }catch{
                print("error parsing json data")  }

              }
    }
    
    @IBAction func signupBtnClicked(_ sender: Any) {
        if( Validation.validate(text: first_name.text ?? "" ) == true && Validation.validate(text: last_name.text ?? ""  ) == true && Validation.validateEmail(enteredEmail: email.text ?? "") ==  true && Validation.validate(text: address.text ?? "" ) == true && phone.text?.count ?? 1 > 7 && password.text?.count ?? 1 > 5 && password.text == confirmPassword.text)
        {
            UserData.email = self.email.text!
            UserData.name = self.first_name.text!
            UserData.loginFromEmail = true

            //MARK: signup code
            if(  signup(textField1: first_name, textField2: last_name, textField3: email, textField4: phone, textField5: address, textField6: password) ){
                
                self.performSegue(withIdentifier: "signupdone", sender: self)
            }else{
                AlartController.showAlart(self, title: "Error!", message: "signup failed!")

            }
            
        }else{
            AlartController.showAlart(self, title: "Error !", message: "Signup form isn't filled correctly!")
        }
        
    }
    
    
    //MARK: Signup function
    
     func signup(textField1: UITextField ,textField2: UITextField ,textField3: UITextField ,textField4: UITextField ,textField5: UITextField ,textField6: UITextField ) -> Bool {
              textField1.resignFirstResponder()
              textField2.resignFirstResponder()
              textField3.resignFirstResponder()
              textField4.resignFirstResponder()
              textField5.resignFirstResponder()
              textField6.resignFirstResponder()
         
              let textToTranslate1 = self.first_name.text ?? "" //first name
              let textToTranslate2 = self.last_name.text ?? "" //last name
              let textToTranslate3 = self.email.text ?? ""  //email
              let textToTranslate4 =  ( (self.selectedCode) + (self.phone.text ?? "" ) )//phone
              let textToTranslate5 = self.address.text ?? "" //address
              let textToTranslate6 = self.password.text ?? ""  //password

                                        
            let newUserParams = [
            "first_name" : textToTranslate1,
            "last_name" : textToTranslate2,
            "email" : textToTranslate3,
            "phone" : textToTranslate4,
            "address" : textToTranslate5 ,
            "password" : textToTranslate6 ] as [String : Any]
        
            AF.request(API.baseURL + "user/signup" , method: .post, parameters: newUserParams).responseJSON {
                response in
               // print(response.debugDescription)
                self.first_name.text = ""
                self.last_name.text = ""
                self.email.text = ""
                self.phone.text = ""
                self.address.text = ""
                self.password.text = ""
                self.confirmPassword.text = ""
        
        }//--------------------
              return true
     }//--------- end
    
   
}
extension SignupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Code.data.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        cell.textLabel?.text = self.Code.data[indexPath.row].code
        return cell
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.countryCode.setTitle(self.Code.data[indexPath.row].code, for: .normal)
        self.selectedCode = self.Code.data[indexPath.row].code ?? "+880"
        //print(self.selectedCode)
        removeTransparentView()
    }
}

class cell: UITableViewCell {
    
}
