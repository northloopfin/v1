//
//  CampusPresenter.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 27/05/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class CampusPresenter: ResponseCallback{
    
    private weak var delegate          : CampusDelegate?
    private lazy var businessLogic         : CampusBusinessLogic = CampusBusinessLogic()
    
    //    Constructor
    init(delegate responseDelegate:CampusDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendCampusRequest(name:String){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!

        let requestModel = CampusRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint(uni: name)
        self.businessLogic.performCampus(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    func sendUniversityRequest(){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        
        let requestModel = CampusRequestModel.Builder()
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())//UIDeviceHelper.getIPAddress()!)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPointUniversity()
        self.businessLogic.performCampus(withRequestModel: requestModel, presenterDelegate: self)
    }

    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? CampusData{
            var arrUni:[String] = []
            for obj in response.values{
                if obj.campus == ""{
                    self.delegate?.didFetchCampus(data: response)
                    break
                }else{
                    arrUni.append(obj.campus)
                    if arrUni.count == response.values.count{
                        self.delegate?.didFetchUniversities(data: arrUni)
                    }
                }
            }
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        if error.getStatusCode() == 204 {
            self.delegate?.emptyCampus()
        }else{
            self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
        }
    }
}
