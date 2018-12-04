

import Foundation

struct AppConstants{
    
    enum URL: String{
        case BASE_URL = "https://api.spacexdata.com/v3/"
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
