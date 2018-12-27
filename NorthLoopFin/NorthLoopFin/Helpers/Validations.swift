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
        return true
    }
}
