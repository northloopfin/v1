//
//  User.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 01/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var isLoggedIn: Bool!
    var userEmail: String!
    
    override init() {
        super.init()
    }
    
    init(loggedInStatus:Bool,email:String) {
        super.init()
        self.isLoggedIn=loggedInStatus
        self.userEmail=email
    }
    required init(coder aDecoder: NSCoder) {
        if let loggedInStatus = aDecoder.decodeObject(forKey: "Status") as? Bool {
            self.isLoggedIn = loggedInStatus
        }
        if let email = aDecoder.decodeObject(forKey: "Email") as? String {
            self.userEmail = email
        }
    }
    func encode(with aCoder: NSCoder) {
        if let loggedInStatusEncoded = self.isLoggedIn {
            aCoder.encode(loggedInStatusEncoded, forKey: "Status")
        }
        if let emailEncoded = self.userEmail {
            aCoder.encode(emailEncoded, forKey: "Email")
        }
    }
}
