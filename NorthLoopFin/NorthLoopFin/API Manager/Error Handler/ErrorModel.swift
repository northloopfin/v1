
//Notes:- This class is used as a model for error transformer.

class ErrorModel {
    
    fileprivate var message             : String = ""
    fileprivate var title               : String = ""
    fileprivate var errorPayload        : [String:Any] = [:]
    
    func setErrorTitle(_ title: String)
    {
        self.title = title
    }
    
    func setErrorMessage(_ message: String)
    {
        self.message = message
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
    
    func getErrorPayloadInfo() -> [String:Any]
    {
        return self.errorPayload
    }
}
