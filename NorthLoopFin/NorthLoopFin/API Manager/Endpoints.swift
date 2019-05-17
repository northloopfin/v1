//
//  Endpoints.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 09/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct Endpoints{
    static let Base_Url = AppUtility.infoForKey("Backend Url")

    enum APIEndpoints:String {
        case LOGIN = "auth/login"
        case TRANSACTIONHISTORY = "banking/transactions"
        case ACCOUNTINFO = "banking/account-info?"
        //case TRANSACTIONDETAIL = "banking/transactions"
        case CARDSTATUS = "banking/card-status"
        case SIGNUPAUTH = "auth/sign-up"
        case SIGNUPSYNAPSE = ""
    }
    
    enum APIRequestHeaders: String{
        case CONTENT_TYPE = "Content-Type"
        case APPLICATION_JSON = "application/json"
        case URLENCODED = "application/x-www-form-urlencoded" 
        case ACCEPT = "Accept"
        case AUTHORIZATION = "Authorization"
        case TWILIO_AUTHORIZATION_KEY =  "X-Authy-API-Key"
        
    }
}
