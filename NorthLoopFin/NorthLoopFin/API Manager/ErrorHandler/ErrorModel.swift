
//Notes:- This class is used as a model for error transformer.

class ErrorModel {
    
    fileprivate var message             : String = ""
    fileprivate var title               : String = ""
    fileprivate var statusCode               : Int = 200
    fileprivate var errorPayload        : [String:Any] = [:]
    
    func setErrorTitle(_ title: String)
    {
        self.title = title
    }
    
    func setErrorMessage(_ message: String)
    {
        self.message = message
    }
    
    func setStatusCode(_ statusCode: Int)
    {
        self.statusCode = statusCode
    }
    
    func setErrorPayloadInfo(_ errorPayload: [String:Any])
    {
        self.errorPayload = errorPayload
    }
    
    
    func getErrorTitle() -> String
    {
        return self.title
    }
    
    func getErrorMessage() -> String
    {
         return self.message
    }
    
    func getStatusCode() -> Int
    {
        return self.statusCode
    }
    
    func getErrorPayloadInfo() -> [String:Any]
    {
        return self.errorPayload
    }
}
