import UIKit
import AFNetworking

class ServiceManager: NSObject  {
    
    static let sharedInstance = ServiceManager()
    
    fileprivate(set) var delegate : ApiResponseReceiver?
    fileprivate(set) var globalManager:AFHTTPSessionManager!
    
    
    
    fileprivate func sessionManager() -> AFHTTPSessionManager{
        if globalManager==nil{
            globalManager = AFHTTPSessionManager()
        }
        globalManager.requestSerializer =  AFJSONRequestSerializer()
        globalManager.responseSerializer = AFJSONResponseSerializer()
        globalManager.responseSerializer.acceptableContentTypes = Set([ "application/json"])
        
        return globalManager
    }
    
    
    /**
     This method cancel all the Api calls , currently running
     */
    func cancelAllOperations() ->Void{
        globalManager.operationQueue.cancelAllOperations()
    }
    
    
    /**
     This method cancel Api call specific to url
     - parameter urlString: Url String that is used for Api call
     */
    
    func cancelTaskWithURL(_ urlString:String) ->Void{
        //Iterating all the tasks in Session Manager
        for task in self.globalManager.tasks{
            //Checking task URL if it's matches with URL we cancel that specific task
            if((task.originalRequest!.url?.absoluteString.contains(urlString)) != nil){
                task.cancel()
            }
        }
    }
    
    /**
     This method checks whether API is in Progress or not
     - parameter urlString: Url String that is used for Api call
     - returns: Returning true or false depend whether API is running or not
     */
    
    func isInProgress(_ urlString:String) ->Bool{
        //Iterating all the tasks in Session Manager
        for task in self.globalManager.tasks{
            //Checking task URL if it's matches with URL we cancel that specific task
            if((task.originalRequest!.url?.absoluteString.contains(urlString)) != nil){
                if(task.state == .running){
                    return true
                }
            }
        }
        return false
    }
    
    
    /**
     This method return NSError object in case if internet connection is not available
     - returns: NSError Object
     */
    
    fileprivate func getNetworkError() -> NSError {
        return NSError(domain: "network_error", code: -1009, userInfo:nil)
    }
    
    /**
     Method is used for Get Request Api Call
     - parameter urlString:    URL String that is used for Api call
     - parameter successBlock: return success response
     - parameter failureBlock: return failure response
     */
    func requestGETWithURL<T:Codable>(_ urlString:String , requestHeader:[String:AnyObject], responseCallBack:ApiResponseReceiver, returningClass:T.Type)-> Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        print(ReachabilityManager.shared.isNetworkAvailable)
        //if ReachabilityManager.shared.isNetworkAvailable {

            // Instantiate session manager
            let manager:AFHTTPSessionManager = self.sessionManager()

            //Iterating request header dictionary and adding into API Manager
            for (key, value) in requestHeader {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
            }

            var error:NSError?

            // Creating Immutable Get NSURL Request
            let request:URLRequest = manager.requestSerializer.request(withMethod: "GET", urlString: urlString, parameters: [ : ], error: &error) as URLRequest

            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(request, sessionManager: manager, returningClass:returningClass)
        //}else{

            // Generating common network error
         //   self.delegate?.onError(getNetworkError() , errorObject: nil)
       //}
    }
    
    
    /**
     Method is used for Get Request Api Call with parameter
     
     - parameter urlString:         URL String that is used for Api call
     - parameter requestDictionary: dictionary used as a parameter
     - parameter successBlock:      return success response
     - parameter failureBlock:      return failure response
     */
    
    func requestGETWithParameter<T:Codable>(_ urlString:String , andRequestDictionary requestDictionary:[String : AnyObject] , requestHeader:[String:AnyObject] , responseCallBack:ApiResponseReceiver , returningClass:T.Type)-> Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {

            // Instantiate session manager Object
            let manager:AFHTTPSessionManager = self.sessionManager()

            //Iterating request header dictionary and adding into API Manager
            for (key, value) in requestHeader {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
            }

            var error:NSError?

            // Creating Immutable Get NSURL Request
            let request:URLRequest = manager.requestSerializer.request(withMethod: "GET", urlString: urlString, parameters: requestDictionary, error: &error) as URLRequest

            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(request, sessionManager: manager, returningClass:returningClass)
        }else{

            // Generating common network error
            self.delegate?.onError(getNetworkError() , errorObject: nil)
        }
    }
    
    /**
     Method is used for Post Request Api Call with parameter
     
     - parameter urlString:         URL String that is used for Api call
     - parameter requestDictionary: dictionary used as a parameter
     - parameter successBlock:      return success response
     - parameter failureBlock:      return failure response
     */
    
    func requestPOSTWithURL<T:Codable>(_ urlString:String , andRequestDictionary requestDictionary:[String : AnyObject],requestHeader:[String:AnyObject] , responseCallBack:ApiResponseReceiver , returningClass:T.Type) ->Void{
        
        self.delegate = responseCallBack
        
        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {
            
            // Instantiate session manager Object
            let manager:AFHTTPSessionManager = self.sessionManager()
            
            //Iterating request header dictionary and adding into API Manager
            for (key, value) in requestHeader {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
            }
            
            var error:NSError?
            
            // Creating Immutable POST NSURL Request
            let request:URLRequest = manager.requestSerializer.request(withMethod: "POST", urlString: urlString , parameters: requestDictionary, error: &error) as URLRequest
            
            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(request, sessionManager: manager , returningClass:returningClass)
        }else{
            
            // Generating common network error
            self.delegate?.onError(getNetworkError() , errorObject: nil)
        }
    }
    
    /**
     Method is used for Put Request Api Call with parameter
     
     - parameter urlString:         URL String that is used for Api call
     - parameter requestDictionary: dictionary used as a parameter
     - parameter successBlock:      return success response
     - parameter failureBlock:      return failure response
     */
    
    func requestPUTWithURL<T:Codable>(_ urlString:String, andRequestDictionary requestDictionary:[String : AnyObject], requestHeader:[String:AnyObject], responseCallBack:ApiResponseReceiver , returningClass:T.Type) -> Void{

        self.delegate = responseCallBack

        // Checking the rechability of Network
        if ReachabilityManager.shared.isNetworkAvailable {

            // Instantiate session manager Object
            let manager:AFHTTPSessionManager = self.sessionManager()

            //Iterating request header dictionary and adding into API Manager
            for (key, value) in requestHeader {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key)
            }

            var error:NSError?

            // Creating Immutable PUT NSURL Request
            let request:URLRequest = manager.requestSerializer.request(withMethod: "PUT", urlString: urlString, parameters: requestDictionary, error: &error) as URLRequest

            // Calling Api with NSURLRequest and session Manager and fetching Response from server
            self.dataTaskWithRequestAndSessionManager(request, sessionManager: manager, returningClass:returningClass)
        }else{

            // Generating common network error
            self.delegate?.onError(self.getNetworkError() , errorObject: nil)
        }
    }
    
    
    /**
     Calling Api with NSURLRequest and session Manager and fetching Response from server
     
     - parameter request:        NSURLRequest request used for interacting with server
     - parameter sessionManager: AFHTTPSessionManager that contains API Header and Content Type
     */
    fileprivate func dataTaskWithRequestAndSessionManager<T:Codable>(_ request:URLRequest, sessionManager:AFHTTPSessionManager, returningClass: T.Type) -> Void {
        
        sessionManager.dataTask(with: request, uploadProgress: nil, downloadProgress: nil) { (response, responseObject, error) in
            
            // Checking whether API Response contains Success response or Error Response
            if( (error == nil) && (responseObject != nil)){
                print(responseObject)

                if let jsonData = self.getJsonStringFor(dictionary: responseObject!).data(using: .utf8)
                {
                    do {
                        let decoder = JSONDecoder()
                        if let result = try? decoder.decode(T.self, from: jsonData){
                            self.delegate?.onSuccess(result)
                        }else{
                            let result =  try decoder.decode([T].self, from: jsonData)
                            self.delegate?.onSuccess(result)
                        }
                    }
                    catch let err {
                        print("Err", err)
                    }
                }
            }else {
                self.delegate?.onError(error! as NSError , errorObject: responseObject as AnyObject?)
            }
            }.resume()
    }

    
    private func getJsonStringFor(dictionary:Any) -> String {
        
        do {
            let data = try JSONSerialization.data(withJSONObject:dictionary, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            return dataString
            
        } catch {
            
        }
        return ""
    }
    

}

