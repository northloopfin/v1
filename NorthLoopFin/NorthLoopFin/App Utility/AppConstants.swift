

import Foundation
//import AppUtility

struct AppConstants{
    
    static let Base_Url = AppUtility.infoForKey("Backend Url")
    
    enum URL: String{
        case CAPSULE_LIST = "capsules"
        case DRAGON_DETAIL = "dragons/%@"
    }
    
    enum ErrorHandlingKeys: String{
        case ERROR_TITLE = "Title"
    }
    
    enum ErrorMessages: String{
        case REQUEST_TIME_OUT = "Request Time Out"
        case PLEASE_CHECK_YOUR_INTERNET_CONNECTION = "Please check your internet connection"
        case SOME_ERROR_OCCURED = "Some error occured"
    }
    
    enum APIRequestHeaders: String{
        case CONTENT_TYPE = "Content-Type"
        case APPLICATION_JSON = "application/json"
    }
}
