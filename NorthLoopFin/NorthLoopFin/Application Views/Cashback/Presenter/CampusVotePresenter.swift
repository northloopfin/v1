//
//  CampusVotePresenter
//  NorthLoopFin
//
//  Created by Milan Mendpara on 21/08/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class CampusVotePresenter: ResponseCallback{
    
    private weak var delegate          : CampusVoteDelegate?
    private lazy var businessLogic         : CampusVoteBusinessModel = CampusVoteBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:CampusVoteDelegate){
        self.delegate = responseDelegate
    }
    
    //    Send Login Request to Business Login
    func sendCampusVoteRequest(placeList:[String],voteList:[String]){
        self.delegate?.showLoader()
        let currentUser:User=UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = CampusVoteRequestModel.Builder()
            .addRequestQueryParams(key: "place_list", value: placeList as AnyObject)
            .addRequestQueryParams(key: "vote_list", value: voteList as AnyObject)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.IP.rawValue, value: UIDevice.current.ipAddress())
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHORIZATION.rawValue, value: currentUser.accessToken)
            .addRequestHeader(key: Endpoints.APIRequestHeaders.AUTHKEY.rawValue, value: currentUser.authKey)
            .build()
        print(requestModel.requestHeader)
        requestModel.apiUrl=requestModel.getEndPoint()
        self.businessLogic.performCampusVote(withRequestModel: requestModel, presenterDelegate: self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        //save this user to local memory of app
        if let response = responseObject as? CampusVote{
            self.delegate?.didCampusVote(data: response)
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
