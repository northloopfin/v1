//
//  Validations.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 26/12/18.
//  Copyright © 2018 NorthLoop. All rights reserved.
//

import Foundation
class Validations {
    //function validate text to be valid email address
   class func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    //Function validate text as valid password. Minimum 8 character length
   class func isValidPassword(password:String) -> Bool {
        let passwordRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{8,20}"
        let passwordTest = NSPredicate(format:"SELF MATCHES[c] %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    class func matchTwoStrings(string1:String,string2:String)->Bool{
        if (string1==string2){
            return true
        }
        return false
    }
    
    class func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "^[0-9]{10,10}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }

}
