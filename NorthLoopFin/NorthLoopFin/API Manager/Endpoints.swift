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
        case LOGIN = "login"
        case TRANSACTIONHISTORY = "transactions"
        case ACCOUNTINFO = "account-info?"
    }
    
    enum APIRequestHeaders: String{
        case CONTENT_TYPE = "Content-Type"
        case APPLICATION_JSON = "application/json"
        case ACCEPT = "Accept"
        case AUTHORIZATION = "Authorization"
        case TWILIO_AUTHORIZATION_KEY =  "X-Authy-API-Key"
        
    }
}
