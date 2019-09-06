//
//  CheckAddressPresenter.swift
//  NorthLoopFin
//
//  Created by Vineet on 11/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class CheckAddressPresenter {
    
    private weak var delegate          : CheckAddressDelegate?
    private lazy var logic         : ChangeAddressBusinessModel = ChangeAddressBusinessModel()
    
    init(delegate responseDelegate:CheckAddressDelegate){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func sendCheckAddressRequest(requestDic:[String:String]) {
        self.delegate?.showLoader()
        var components = URLComponents(string: Endpoints.APISmartyStreetsEndpoints.US_Street_Address.rawValue)!
        components.queryItems = requestDic.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, err in
            self.delegate?.hideLoader()
            guard let dataAddress = data, err == nil else {
                print(err?.localizedDescription ?? "No data")
                self.servicesManagerError()
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: dataAddress, options: [])
                self.servicesManagerSuccessResponse(jsonData)
            } catch {
                print(error.localizedDescription)
                self.servicesManagerError()
            }
        }
        
        task.resume()
    }
    
    func servicesManagerSuccessResponse(_ response: Any) {
        DispatchQueue.main.async {
            self.delegate?.hideLoader()
            self.delegate?.didVerifyAddress(VerifiedAddress.init(data: response))
        }
    }
    
    func servicesManagerError() {
        DispatchQueue.main.async {
            self.delegate?.hideLoader()
            self.delegate?.showErrorAlert(AppConstants.ErrorHandlingKeys.ERROR_TITLE.rawValue, alertMessage: "Address not found. Please try again")
        }
    }
}
