
//MARK:  ResponseWrapper.swift

import Foundation

protocol ApiResponseReceiver{
    func onSuccess<T: Codable>(_ response:T) -> Void
    func onError(_ errorResponse:NSError , errorObject:AnyObject?) -> Void
}

class ResponseWrapper : ApiResponseReceiver  {

    let delegate         : ResponseCallback!
    let errorResolver    : ErrorResolver?

    init(errorResolver:ErrorResolver , responseCallBack:ResponseCallback){
        self.delegate = responseCallBack
        self.errorResolver = errorResolver
    }

    /**
     This method is used for handling Success response of an API
     
     - parameter response: Response is a kind of Generic Object
     */
    
    func onSuccess<T:Codable>(_ response:T) -> Void {
        self.delegate.servicesManagerSuccessResponse(responseObject: response)
    }
    
    /**
     This method is used for handling Error response of an API
     
     - parameter errorResponse: NSError Object contains error info
     */
    
    func onError(_ errorResponse: NSError , errorObject: AnyObject?) ->Void {
        let errorModel : ErrorModel = ErrorTransformer.getErrorModel(fromErrorObject: errorObject,errorResponse: errorResponse, errorResolver: self.errorResolver!)
        self.delegate.servicesManagerError(error : errorModel)
    }
    
}

