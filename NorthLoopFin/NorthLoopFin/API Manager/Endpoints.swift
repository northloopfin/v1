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
    static let Card_Info_Url = AppUtility.infoForKey("Card Url")

    enum APIEndpoints:String {
        case LOGIN = "auth/login"
        case TRANSACTIONHISTORY = "banking/transactions"
        case TRANSACTIONLIST = "banking/transactions?"
        case ACCOUNTINFO = "banking/account-info?"
        case CARDSTATUS = "banking/card"
        case CARDUPDATE = "banking/card?"
        case CARDPIN = "banking/card/pin?"
        case SIGNUPAUTH = "auth/sign-up"
        case SIGNUPSYNAPSE = "banking/synapse-user"
        case RESETPASSWORD = "auth/reset-password"
        case LINKACH = "banking/link-ach"
        case ZENDESK = "auth/helpdesk-token"
        case ATMFINDER = "banking/atm?"
        case USERTRANSFERDETAIL = "banking/transfer-details"
        case TWOFA = "banking/2fa/false"
        case TWOFAVERIFY = "banking/2fa/"
        case TWOFAMOBILE = "banking/2fa"
        case UPGRADEPREMIUM = "banking/transactions/upgrade"
        case UNIVERSITYLIST = "banking/schools"
        case SAHREACCOUNTDETAILS = "banking/account"
        case GETAPPSETTINGS = "banking/preferences"
        case CHECKUPDATE = "banking/app-version-updates"
        case CHECKADDRESS = "https://api.lob.com/v1/us_verifications"
    }
    
    enum APIRequestHeaders: String{
        case CONTENT_TYPE = "Content-Type"
        case APPLICATION_JSON = "application/json"
        case URLENCODED = "application/x-www-form-urlencoded" 
        case ACCEPT = "Accept"
        case AUTHORIZATION = "Authorization"
        case TWILIO_AUTHORIZATION_KEY =  "X-Authy-API-Key"
        case AUTHKEY = "auth"
        case IP = "ip"
        case USERID = "user_id"
    }
}
