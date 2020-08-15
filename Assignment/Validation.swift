//
//  Validation.swift
//  Assignment
//
//  Created by Md. Mehedi Hasan on 15/8/20.
//  Copyright © 2020 Mehedihasan290. All rights reserved.
//

import Foundation
class Validation{
    
    static func validateEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
    
    static func validatPassword(enteredPassword:String ) -> Bool {
        if enteredPassword != "" {
            return true
        }
        else{
            return false
        }
    }
    static func validate(text:String ) -> Bool {
        if text != "" {
            return true
        }
        else{
            return false
        }
    }
}

