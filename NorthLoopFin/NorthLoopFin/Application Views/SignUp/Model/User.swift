//
//  User.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 01/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var userEmail: String!
    var accessToken:String!
    var username: String!
    
    override init() {
        super.init()
    }
    
    init(username:String,email:String,accesstoken:String){
        super.init()
        self.username = username
        self.userEmail = email
        self.accessToken = accesstoken
    }
    
   
    required init(coder aDecoder: NSCoder) {
        if let email = aDecoder.decodeObject(forKey: "Email") as? String {
            self.userEmail = email
        }
        if let username = aDecoder.decodeObject(forKey: "Username") as? String {
            self.username = username
        }
        if let token = aDecoder.decodeObject(forKey: "AccessToken") as? String {
            self.accessToken = token
        }
    }
    func encode(with aCoder: NSCoder) {
        
        if let emailEncoded = self.userEmail {
            aCoder.encode(emailEncoded, forKey: "Email")
        }
        if let usernameEncoded = self.username {
            aCoder.encode(usernameEncoded, forKey: "Username")
        }
        if let accessTokenEncoded = self.accessToken {
            aCoder.encode(accessTokenEncoded, forKey: "AccessToken")
        }
    }
}
