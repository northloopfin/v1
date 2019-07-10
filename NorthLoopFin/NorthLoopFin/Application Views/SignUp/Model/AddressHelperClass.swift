//
//  AddressHelperClass.swift
//  NorthLoopFin
//
//  Created by Vineet on 10/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

class AddressHelperClass{
    
    func checkAddress(addressData:[String: Any])->Bool{
    
        var someRequest = URLRequest(url: URL.init(string: "https://api.lob.com/v1/us_verifications")!)
        someRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        someRequest.httpMethod = "POST"
        
//        let jsonBody: [String: Any] = ["primary_line": "157 Linda Lane", "city": "Banning","zip_code": "92220","state": "CA"]
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: addressData, options: .prettyPrinted)
            let str = String.init(data: jsonData, encoding: .utf8)
            someRequest.httpBody = str?.data(using: .utf8)
        }
        catch{
            print("Error while adding body to request")
        }
        
        let authStr = "test_pub_3dcc626a9c6d4bec384a8e8c29f30a0:"
        let authData = authStr.data(using: .ascii)
        let authValue = String(format: "Basic %@", authData?.base64EncodedString() ?? "")
        someRequest.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        print(someRequest)
        let task = URLSession.shared.dataTask(with: someRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
        return false
    }
    
}

