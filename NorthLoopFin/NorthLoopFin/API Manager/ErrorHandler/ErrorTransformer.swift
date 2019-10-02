
//Notes:- This class will be used as error transformers

import Foundation

class ErrorTransformer {
    
    class func getErrorModel(fromErrorObject errorObject:AnyObject?,errorResponse: NSError ,errorResolver:ErrorResolver) -> ErrorModel {

        let errorModel : ErrorModel = ErrorModel()
        if let errorDict : Dictionary<String,Any>  = errorObject as? Dictionary<String,Any> {
            //Prepare custom error object here....
            //for Twilio 
            if let mes = errorDict["message"] {
                errorModel.setErrorMessage(mes as! String)
            } else {
                print("API ERROR: "  + errorResponse.debugDescription)
                errorModel.setErrorMessage(AppConstants.ErrorMessages.GENERIC_ERROR_MESSAGE.rawValue)
            }
        }else{

            if ErrorTransformer.errorMessageForUnknownError(errorResponse.code) != ""{
               errorModel.setErrorMessage(self.errorMessageForUnknownError(errorResponse.code))
            }
            else{
                print("API ERROR: "  + errorResponse.debugDescription)
                errorModel.setErrorMessage(AppConstants.ErrorMessages.GENERIC_ERROR_MESSAGE.rawValue)
            }
            errorModel.setErrorTitle(AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue)
        }
        return errorModel
    }
    
    class func getStatusErrorModel(response:URLResponse) -> ErrorModel {
        let errorModel : ErrorModel = ErrorModel()
        errorModel.setErrorMessage(AppConstants.ErrorMessages.GENERIC_ERROR_MESSAGE.rawValue)
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            errorModel.setStatusCode(httpResponse.statusCode)
        }

        return errorModel
    }
    
    class func errorMessageForUnknownError(_ errorResponseCode : Int)->String
    {
        switch errorResponseCode {
        case -1001:
            return AppConstants.ErrorMessages.REQUEST_TIME_OUT.rawValue
        case -1005: fallthrough
        case -1009:
            return AppConstants.ErrorMessages.PLEASE_CHECK_YOUR_INTERNET_CONNECTION.rawValue
        default:
            return ""
            
        }
    
    }
}
