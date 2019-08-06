//
//  AnalysisAPIRequestModel.swift
//  NorthLoopFin
//
//  Created by Admin on 8/6/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class AnalysisAPIRequestModel {
    
    //Note :- Property Name must be same as key used in request API
    var requestBody: [String:AnyObject]!
    var requestHeader: [String:AnyObject]!
    var requestQueryParams: [String:AnyObject]!
    var apiUrl:String!
    init(builderObject builder:Builder) {
        //Instantiating service Request model Properties with Builder Object property
        self.requestBody = builder.requestBody
        self.requestHeader = builder.requestHeader
        self.requestQueryParams = builder.requestQueryParams
    }
    
    // This inner class is used for setting upper class properties
    internal class Builder {
        //MARK:- Builder class Properties
        //Note :- Property Name must be same as key used in request API
        var requestBody: [String:AnyObject] = [String:AnyObject]()
        var requestHeader: [String:AnyObject] = [String:AnyObject]()
        var requestQueryParams: [String:AnyObject] =  [String:AnyObject]()
        
        /**
         This method is used for adding request Header
         
         - parameter key:   Key of a Header
         - parameter value: Value corresponding to header
         
         - returns: returning Builder object
         */
        func addRequestHeader(key:String , value:String) -> Builder {
            self.requestHeader[key] = value as AnyObject?
            return self
        }
        
        /**
         This method is used for adding request params
         
         - parameter key:   Key of a Header
         - parameter value: Value corresponding to header
         
         - returns: returning Builder object
         */
        func addRequestQueryParams(key:String , value:AnyObject) -> Builder {
            self.requestQueryParams[key] = value
            return self
        }
        
        /**
         This method is used to set properties in upper class of CapsuleListRequestModel
         and provide CapsuleListForm1ViewViewRequestModel object.
         
         -returns : HomeLedgerRequestModel
         */
        func build()->AnalysisAPIRequestModel {
            return AnalysisAPIRequestModel(builderObject: self)
        }
    }
    
    /**
     This method is used for getting CapsuleList end point
     
     -returns: String containg end point
     */
    
    var apiRequestUrl:String!
    
    func setEndPoint(userID:String, year:String, month:String) {
        let testUserID = "5d37c889b942fe1de4005938"
        apiRequestUrl = Endpoints.APIEndpoints.ANALYSISOPTIONS.rawValue + testUserID + "/" + year + "/" + month
    }
    
    func getEndPoint() -> String {
        return apiRequestUrl
    }
}

