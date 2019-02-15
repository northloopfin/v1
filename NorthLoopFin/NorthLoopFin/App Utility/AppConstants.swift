

import Foundation
import UIKit

let StoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

struct AppConstants{
    static let contentLayerName = "contentLayer"
    static let Base_Url = AppUtility.infoForKey("Backend Url")
    static let AuthorisationRequestHeader = "API-Key "+AppUtility.infoForKey("API Key")!
    static let GoogleMapAPIKey = AppUtility.infoForKey("Google Map Key")
    static let TwilioAPIKey = AppUtility.infoForKey("Twilio Key")
    static let UserDefaultKeyForUser = "UserInformation"
    static let UserDefaultKeyForScreen = "Screen"


    enum URL: String{
        case TWILIO_BASE_URL = "https://api.authy.com/protected/json/"
        case TRANSACTION_LIST = "/v1/customer/transactions"
        case TWILIO_PHONE_VERIFICATION_START_ENDPOINT = "phones/verification/start"
        case TWILIO_PHONE_VERIFICATION_CHECK_ENDPOINT = "phones/verification/check"
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
        case PASSWORD_NOT_VALID = "Password should be minimum 8 characters, one uppercase letter, one number and one special character and maximum 20 characters"
        case ALL_FIELDS_MANDAORY = "All fields are mandatory"
        case PASSWORD_DONOT_MATCH = "Passwords do not match"
        case PHONE_NOT_VALID = "Please enter a valid Phone Number"
        case NAME_NOT_VALID = "Name should not contain special character and space"
        case ZIP_NOT_VALID = "Please enter a valid ZIP Code"
        case COMING_SOON = "Coming Soon"
        case FORGET_PASSWORD_MESSAGE = "Please check your inbox for Password Reset Link"
        case USER_REACHED_MAX_ATTEMPTS = "You reached maximum attempts. Please try again after 10 minutes"
        case USER_ABOUT_TO_REACH_MAX_ATTEMPTS = "You are left with one more login attempt"
        case USER_ACCOUNT_BLOCKED = "Your Account has been block. Check inbox to reset password"
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
    
    enum Screens:String{
        case PASSWORD = "Password"
        case USERDETAIL = "UserDetail"
        case OTP = "OTP"
        case SCANID = "ScanID"
        case SELFIETIME = "SelfieTime"
        case VERIFYADDRESS = "VerifyAddress"
        case HOME = "Home"
    }
    
    enum SideMenuOptions:String {
        case MYCARD = "My Card"
        case TRANSFER = "Transfer & Pay"
        case MYACCOUNT = "My Profile"
        case GOALS = "Goals"
        case EXPENSES = "Expenses"
        case HELP = "Help"
        case SETTINGS = "Settings"
    }
    
    enum HelpOptions:String{
        case FAQ = "FAQ"
        case LEGALSTUFF = "Legal T&C"
        case CHATWITHUS = "Chat With Us"
        case ATMFINDER = "ATM Finder"
    }
    
    enum FAQOptions:String {
        case TERMSANDPOLICY = "Terms & Policy"
        case PRIVACY = "Privacy"
        case OTHERSTUFF = "Other Stuff"
    }
    
    enum SettingsOptions:String {
        case NOTIFICATIONSETTINGS = "Notification Settings"
        case PRIVACYPREFERENCES = "Privacy Preferences"
        case MARKETINGPREFERENCES = "Marketing Preferences"
        
    }
    
    enum ProfileOptions:String{
        case APPSETTINGS = "App Settings"
        case CHANGEADDRESS = "Change Address"
        case CHANGEPASSWORD = "Change Password"
        case CHANGEPHONENUMBER = "Change Phone Number"
        case LOGOUT = "Logout"
    }
    
    enum NotificationSettigsOptions:String{
        case INDIVIDUALEXPENSES = "Individual Expenses"
        case TRANSFERS = "Transfers"
        case LOWBALANCEALERT = "Low Balance Alert"
        case WEEKLYSPENDSUMMARY = "Weekly Spend Summary"
    }
    
    enum States:String {
        case Alabama = "AL"
        case Alaska = "AK"
        case Arizona = "AZ"
        case Arkansas = "AR"
        case California = "CA"
        case Colorado = "CO"
        case Connecticut = "CT"
        case Delaware = "DE"
        case Georgia = "GA"
        case Hawaii = "HI"
        case Idaho = "ID"
        case Illinois = "IL"
        case Indiana = "IN"
        case Iowa = "IA"
        case Kansas = "KS"
        case Kentucky = "KY"
        case Louisiana = "LA"
        case Maine = "ME"
        case Maryland = "MD"
        case Massachusetts = "MA"
        case Michigan = "MI"
        case Minnesota = "MN"
        case Mississippi = "MS"
        case Missouri = "MO"
        case Montana = "MT"
        case Nebraska = "NE"
        case Nevada = "NV"
        case NewHampshire = "NH"
        case NewJersey = "NJ"
        case NewMexico = "NM"
        case NewYork = "NY"
        case NorthCarolina = "NC"
        case NorthDakota = "ND"
        case Ohio = "OH"
        case Oklahoma = "OK"
        case Pennsylvania = "PA"
        case RhodeIsland = "RI"
        case SouthCarolina = "SC"
        case SouthDakota = "SD"
        case WestVirginia = "WV"
        case Texas = "TX"
        case Utah = "UT"
        case Vermont = "VT"
        case Virginia = "VA"
        case Washington = "WA"
        case Wisconsin = "WI"
        case Wyoming = "WY"
        case AmericanSamoa = "AS"
        case DistrictofColumbia = "DC"
        case FederatedStatesofMicronesia = "FM"
        case Guam = "GU"
        case MarshallIslands = "MH"
        case NorthernMarianaIslands = "MP"
        case Palau = "PW"
        case PuertoRico = "PR"
        case VirginIslands = "VI"
    }
}


