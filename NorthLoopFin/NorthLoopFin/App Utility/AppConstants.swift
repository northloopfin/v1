

import Foundation
//import AppUtility

struct AppConstants{
    static let contentLayerName = "contentLayer"
    static let Base_Url = AppUtility.infoForKey("Backend Url")
    static let AuthorisationRequestHeader = "API-Key "+AppUtility.infoForKey("API Key")!
    static let GoogleMapAPIKey = AppUtility.infoForKey("Google Map Key")
    static let TwilioAPIKey = AppUtility.infoForKey("Twilio Key")

    enum URL: String{
        case TWILIO_BASE_URL = "https://api.authy.com/protected/json/"
        case TRANSACTION_LIST = "/v1/customer/transactions"
        case TWILIO_PHONE_VERIFICATION_ENDPOINT = "phones/verification/start"
    }
    
    enum ErrorHandlingKeys: String{
        case ERROR_TITLE = "Uh oh!"
        case SUCESS_TITLE = "Sucess"
    }
    
    enum ErrorMessages: String{
        case REQUEST_TIME_OUT = "Request Time Out"
        case PLEASE_CHECK_YOUR_INTERNET_CONNECTION = "Please check your internet connection"
        case SOME_ERROR_OCCURED = "Some error occured"
        case EMAIL_NOT_VALID = "Please enter a valid email address"
        case PASSWORD_NOT_VALID = "Password should be minimum 8 characters, one uppercase letter, one number or special character and maximum 20 characters"
        case ALL_FIELDS_MANDAORY = "All fields are mandatory"
        case PASSWORD_DONOT_MATCH = "Password and Confirm Password do not match"
        case PHONE_NOT_VALID = "Please enter a valid Phone Number"
    }
    
    enum TwilioPhoneVerificationRequestParamKeys:String {
        case API_Key = "api_key"
        case VIA = "via"
        case COUNTRY_CODE = "country_code"
        case PHONE_NUMBER = "phone_number"
        case LOCALE = "locale"
        case VERIFICATION_CODE = "verification_code"
    }
    
    enum APIRequestHeaders: String{
        case CONTENT_TYPE = "Content-Type"
        case APPLICATION_JSON = "application/json"
        case ACCEPT = "Accept"
        case AUTHORIZATION = "Authorization"
        case TWILIO_AUTHORIZATION_KEY =  "X-Authy-API-Key"
        
    }
}
