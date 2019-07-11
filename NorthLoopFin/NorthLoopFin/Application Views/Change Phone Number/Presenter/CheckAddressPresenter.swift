//
//  CheckAddressPresenter.swift
//  NorthLoopFin
//
//  Created by Vineet on 11/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class CheckAddressPresenter:ResponseCallback{
    
    private weak var delegate          : CheckAddressDelegate?
    private lazy var logic         : ChangeAddressBusinessModel = ChangeAddressBusinessModel()
    
    init(delegate responseDelegate:CheckAddressDelegate){
        self.delegate = responseDelegate
    }
    //MARK:- Methods to make decision and call  Api.
    
    func checkAddressWithLobAPI(addressData:[String: Any] ){
         self.delegate?.showLoader()
        var request = URLRequest(url: URL.init(string: Endpoints.APIEndpoints.CHECKADDRESS.rawValue)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: addressData, options: .prettyPrinted)
            let str = String.init(data: jsonData, encoding: .utf8)
            request.httpBody = str?.data(using: .utf8)
        }
        catch{
            print("Error while adding body to request")
        }
        
        let authStr = "live_pub_c3edd6cdec6446299fece43678d8932:"
        let authData = authStr.data(using: .ascii)
        let authValue = String(format: "Basic %@", authData?.base64EncodedString() ?? "")
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                let status:String = responseJSON["deliverability"] as! String
                if status == "deliverable" {
                    self.delegate?.didVerifyAddress()
                }else{
                     self.delegate?.showErrorAlert("", alertMessage: "Incorrect address please check and try again")
                }
                // print(responseJSON)
//                self.delegate.sendForNextAPI(response: responseJSON)
            }else{
                self.delegate?.showErrorAlert("", alertMessage: "Incorrect address please check and try again")
            }
        }
        
        task.resume()
    }
    
    
    
    func servicesManagerSuccessResponse<T>(responseObject: T) where T : Decodable, T : Encodable {
        // let response = responseObject as! SetPinResponse
        self.delegate?.hideLoader()
        self.delegate?.didVerifyAddress()
    }
    
    func servicesManagerError(error: ErrorModel) {
        self.delegate?.hideLoader()
        self.delegate?.showErrorAlert(error.getErrorTitle(), alertMessage: error.getErrorMessage())
    }
}
