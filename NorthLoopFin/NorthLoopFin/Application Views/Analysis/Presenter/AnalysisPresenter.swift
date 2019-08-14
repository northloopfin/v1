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
    func didFetchAnalysisTotalSpent(_ totalSpent:AnalysisTotalSpent)
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
        self.businessLogic.performFetchAnalysisCategories(withRequestModel:requestModel, returningClass: AnalysisOptions.self, presenterDelegate:self)
    }
    
    func fetchAnalysisTotalSpent(month:String, year:String) {
        self.delegate?.showLoader()
        let currentUser:User = UserInformationUtility.sharedInstance.getCurrentUser()!
        let requestModel = AnalysisAPIRequestModel.Builder().build()
        requestModel.setEndPointTotalSpent(userID: currentUser.userID, year: year, month: month)
        self.businessLogic.performFetchAnalysisCategories(withRequestModel:requestModel, returningClass: AnalysisTotalData.self, presenterDelegate:self)
    }
    
    //    MARK: Response Delegates
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        self.delegate?.hideLoader()
        if let response = responseObject as? AnalysisOptions {
            var categories:[UserAnalysisCategory] = []
            for option in response.data {
                categories.append(UserAnalysisCategory.init(option))
            }
            self.delegate?.didFetchAnalysisCategories(categories)
        }else if let response = responseObject as? AnalysisTotalData {
            if response.data.count > 0{
                self.delegate?.didFetchAnalysisTotalSpent(response.data[0])
            }
        }
    }
    
    func servicesManagerError(error: ErrorModel) {
        // show error to user
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage:  error.getErrorMessage())
    }
}
