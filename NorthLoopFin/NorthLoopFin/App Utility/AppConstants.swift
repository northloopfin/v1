

import Foundation
import UIKit

let StoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

struct AppConstants{
    static let contentLayerName = "contentLayer"
    static let Base_Url = AppUtility.infoForKey("Backend Url")
    static let AuthorisationRequestHeader = "API-Key "+AppUtility.infoForKey("API Key")!
    static let GoogleMapAPIKey = AppUtility.infoForKey("Google Map Key")
    static let TwilioAPIKey = AppUtility.infoForKey("Twilio Key")
    static let AmplitudeAPIKey = AppUtility.infoForKey("Amplitude API Key")
    static let UserDefaultKeyForUser = "UserInformation"
    static let UserDefaultKeyForCard = "CardInformation"
    static let UserDefaultKeyForScreen = "Screen"
    static let UserDefaultKeyForEmail = "Email"
    static let UserDefaultKeyForAccessToken = "AccessToken"
    static let UserDefaultKeyForCrash = "Crash"
    static let UserDefaultKeyForDeviceToken = "DeviceToken"
    static let UserDefaultKeyForFirstTimeLandOnHome = "LandedOnHome"
    static let KeyChainKeyForPassword = "NorthLoopPassword"
    static let KeyChainKeyForEmail = "NorthLoopEmail"
    static let UserDefaultKeyForFreshInstall = "FreshInstall"
    static let SS_Auth_ID = AppUtility.infoForKey("SmartyStreets Auth ID")
    static let SS_Auth_Token = AppUtility.infoForKey("SmartyStreets Auth Token")

    static let PageLimit:Int = 20
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String


    static let CountryExceptionURL = "https://northloop.zendesk.com/hc/en-us/articles/360027983032"
    static let FAQURL = "https://northloop.zendesk.com/hc/en-us/"
    static let AppStoreUrl = "itms://itunes.apple.com/app/1470578407"

    enum URL: String{
        case TWILIO_BASE_URL = "https://api.authy.com/protected/json/"
        case TRANSACTION_LIST = "/v1/customer/transactions"
        case TWILIO_PHONE_VERIFICATION_START_ENDPOINT = "phones/verification/start"
        case TWILIO_PHONE_VERIFICATION_CHECK_ENDPOINT = "phones/verification/check"
    }
    
    enum ErrorHandlingKeys: String{
        case ERROR_TITLE = "Uh oh!"
        case SUCESS_TITLE = "Success"
        case CONFIRM_TITLE = "Confirm"
    }
    
    enum ErrorMessages: String{
        case REQUEST_TIME_OUT = "Request Time Out"
        case PLEASE_CHECK_YOUR_INTERNET_CONNECTION = "Can't connect to the internet! Please check your connection and try again"
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
        case COMPLETE_DOCUMENT_UPLOAD = "Please complete document upload of selected ID Type"
        case SELECT_ID_TYPE = "Please select ID type"
        case RESET_EMAIL_SENT = "We've just sent you an email to reset your password"
        case CONFIRM_MESSAGE_TO_LOCK_CARD = "Are you sure you want to lock this card?"
        case CONFIRM_MESSAGE_SPEND_ABROAD = "Are you sure you want to change Spend Abroad status of this card?"
        case DOB_NOT_VALID = "Person could not be younger than 18 years"
        case ROUTING_NUMBER_NOT_VALID = "Please enter a valid Routing Number"
        case CARD_NOT_ACTIVE_YET = "Card Isn't Activated Yet"
        case CONFIRM_MESSAGE_TO_CHANGE_PHONE = "Are you sure you want to change your phone number?"
        case CONFIRM_MESSAGE_TO_CHANGE_PASSWORD = "Are you sure you want to change your password?"
        case CONFIRM_MESSAGE_TO_CHANGE_ADDRESS = "Are you sure you want to change your registered address?"
        case FIRST_TIME_LAND_HOME_MESSAGE = "Welcome to North Loop. Enter an email below if you want to send your account details to someone"
        case ACCOUNT_DETAIL_SAHRED_SUCCESSFULLY = "Shared successfully"
        case INSUFFICIENT_BALANCE = "Insufficient Balance"
        case NEWER_VERSION_AVAILABLE = "A newer version of this app is available. Do you want to update?"
        case APP_IS_UPTO_DATE = "You have the most recent version of North Loop"
        case PROMOCODE_NOT_VALID = "Promocode not valid"
        case SSN_NOT_VALID = "Please enter a valid SSN Number"
        case MAXIMUM_NODES_ADDED = "You already have 2 accounts linked. Please remove one before adding another"
        case ACTIVATE_YOUR_CARD = "Please activate your card"
    }
    
    enum TwilioPhoneVerificationRequestParamKeys:String {
        case API_Key = "api_key"
        case VIA = "via"
        case COUNTRY_CODE = "country_code"
        case PHONE_NUMBER = "phone_number"
        case LOCALE = "locale"
        case VERIFICATION_CODE = "verification_code"
    }
    
//    enum APIRequestHeaders: String{
//        case CONTENT_TYPE = "Content-Type"
//        case APPLICATION_JSON = "application/json"
//        case ACCEPT = "Accept"
//        case AUTHORIZATION = "Authorization"
//        case TWILIO_AUTHORIZATION_KEY =  "X-Authy-API-Key"
//        
//    }
    
    enum Screens:String{
        case PASSWORD = "Password"
        case USERDETAIL = "UserDetail"
        case OTP = "OTP"
        case SCANID = "ScanID"
        case SELFIETIME = "SelfieTime"
        case VERIFYADDRESS = "VerifyAddress"
        case HOME = "Home"
        case SETPIN = "Set Pin"
        case CHANGEPHONE = "ChangePhone"
        case CHANGEADDRESS = "ChangeAddress"
        case ChangePASSWORD = "ChangePassword"
        case CHAT = "Chat"

    }
    
    enum SideMenuOptions:String {
        case MYCARD = "My Card"
        case TRANSFER = "Transfer & Pay"
        case MYACCOUNT = "My Account"
        case UPGRADE = "Upgrade"
        case EXPENSES = "Expenses"
        case HELP = "Help"
        case FEEDBACK = "Feedback"
        case SETTINGS = "Settings"
        case PREMIUM = "Premium"
        case REFER = "Refer & Earn"
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
    
    enum LegalTCOptions:String{
        case DEPOSITAGREEMENT = "Deposit Account Agreement"
        case TERMSOFSERVICE = "Terms of Service"
        case PRIVACYPOLICY = "Privacy Policy"
        case CARDHOLDERAGREEMENT = "Cardholder Agreement"
    }
    
    enum SettingsOptions:String {
        case NOTIFICATIONSETTINGS = "Notification Settings"
        case LOWBALANCEALERT = "Low Balance Alert ($100)"
        case TRANSACTIONALERT = "Transaction Alert"
        case DEALSOFFERS = "Deals & Offers"
        case CHECKFORUPDATE = "Check for Update"
        case TIPHINT = "Tip Hint for Restaurants"        
    }
    
    enum ProfileOptions:String{
        case APPSETTINGS = "App Settings"
        case CHANGEADDRESS = "Change Address"
        case CHANGEPASSWORD = "Change Password"
        case CHANGEPHONENUMBER = "Change Phone Number"
        case LOGOUT = "Logout"
        case ACCOUNTDETAIL = "Account Details"
    }
    
    enum NotificationSettigsOptions:String{
        case INDIVIDUALEXPENSES = "Individual Expenses"
        case TRANSFERS = "Transfers"
        case LOWBALANCEALERT = "Low Balance Alert"
        case WEEKLYSPENDSUMMARY = "Weekly Spend Summary"
    }
    
    enum SelectIDTYPES:String{
        case PASSPORT="Passport"
        case I20="I-20 (3 pages)"
        case USIDTYPE = "US ID Type"
        case F1VISA = "F-1 Visa"
        case ADDRESSPROOF = "Address Proof"
        case STATEID = "ID"
        case DRIVERLICENSE = "Driver's License"
        case OTHER = "Other"
    }
    enum AGREEMENTTYPE:String{
        case ACCOUNT = "Account"
        case DEPOSIT = "Deposit"
        case CARD = "Card"
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
    
    enum CarouselItem: Int,CaseIterable {
        case First, Second, Third, Foruth
        
        init?(id: Int) {
            switch id {
            case 1:
                self = .First
            case 2:
                self = .Second
            case 3:
                self = .Third
            case 4:
                self = .Foruth
            default:
                return nil
            }
        }
        
        func id() -> Int {
            switch self {
            case .First:
                return 1
            case .Second:
                return 2
            case .Third:
                return 3
            case .Foruth:
                return 4
            }
        }
        
        func title() -> String? {
            switch self {
            case .First:
                return "Unlimited Currency Protect"
            case .Second:
                return nil
            case .Third:
                return nil
            case .Foruth:
                return nil
            }
        }
        
        func description() -> String {
            switch self {
            case .First:
                return "FX Insurance. Get up to $500 refunded\nwith every wire transfer. Never worry\nabout FX volatility again."
            case .Second:
                return "Even more cashback.\nEarn up to 5% back with North Loop Premium.\nGet one year of Amazon Prime\nStudent ($78) free."
            case .Third:
                return "Need a co-signer for your lease?\nWe got your back. Instant Wire Transfers?\nThey're free."
            case .Foruth:
                return "Upgrade Now\nMonthly: $9.99\nAnnual: $99.99"
            }
        }
        
        func image() -> UIImage? {
            switch self {
            case .First:
                return UIImage (named: "carousel1")
            case .Second:
                return UIImage (named: "carousel2")
            case .Third:
                return UIImage (named: "carousel3")
            case .Foruth:
                return UIImage (named: "carousel4")
            }
        }
    }

}


