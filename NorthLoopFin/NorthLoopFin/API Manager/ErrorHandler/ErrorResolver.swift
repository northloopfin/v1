
/// Error Resolver class is used for resolving Error Issue

class ErrorResolver {

    fileprivate var errorDict: [String: String] = [String: String]()

    /**
     This method is used for registering error code for specific APIs
     - parameter errorCode: Code of Error
     - parameter message:   Message string corresponding to error
     */

    func registerErrorCode(_ errorCode: ErrorCodes, message: String){
        
        //Mapping messages corresponding to specific code
        self.errorDict[errorCode.rawValue] = message
    }
    
     /**
     This method is used for sending specific error message corresponding to error code
     - parameter errorCode: Error Code corresponding to specific error
     - returns: Returning Error Message
     */
    
    func getErrorObjectForCode(_ errorCode: String) -> String
    {
        //This line check whether error is resolvable or not
        if isErrorResolvable(errorCode){
            return errorDict[errorCode]!
        }
        else{
            return "Remove";
           //return AppConstants.ErrorMessages.SOME_ERROR_OCCURED.rawValue
        }
    }
    
    /**
     This method is used for checking whether error is already added or not in Error Dictionary
     - parameter code: Error Code
     - returns: Returning True or false
     */
    
    fileprivate func isErrorResolvable(_ code: String) -> Bool
    {
        guard let _ = errorDict[code] else {
            return false
        }
        return true
    }
    /**
     This method is used for adding set of Predefined Error coming from server
     */
    class func registerErrorsForApiRequests() ->ErrorResolver{
        
        let errorResolver:ErrorResolver = ErrorResolver()
        //Register
        return errorResolver
        
    }

}
