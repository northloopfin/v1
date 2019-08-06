//
//  AnalysisPresenter.swift
//  Test
//
//  Created by Admin on 7/31/19.
//  Copyright © 2019 itworksinua. All rights reserved.
//

import UIKit

protocol AnalysisPresenterDelegate:BaseViewProtocol {
    func didFetchAnalysisCategories(_ categories:[UserAnalysisCategory])
}

class AnalysisPresenter:ResponseCallback {
    
    private weak var delegate:AnalysisPresenterDelegate?
    private lazy var businessLogic:AnalysisBusinessModel = AnalysisBusinessModel()
    
    //    Constructor
    init(delegate responseDelegate:AnalysisPresenterDelegate){
        self.delegate = responseDelegate
    }
   
    func fetchAnalysisCategories(month:String, year:String) {
        self.delegate?.showLoader()
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = AnalysisAPIRequestModel.Builder().build()
        requestModel.setEndPoint(userID: currentUser.userID, year: year, month: month)
        self.businessLogic.performFetchAnalysisCategories(withRequestModel:requestModel, presenterDelegate:self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        var categories:[UserAnalysisCategory] = []
        if let response = responseObject as? AnalysisOptions {
            for option in response.data {
                categories.append(UserAnalysisCategory.init(option))
            }
        }
        self.delegate?.didFetchAnalysisCategories(categories)
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
