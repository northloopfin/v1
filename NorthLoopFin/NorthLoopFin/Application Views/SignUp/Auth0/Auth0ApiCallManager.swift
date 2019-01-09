//
//  Auth0ApiCallManager.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 07/01/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import Auth0

class Auth0ApiCallManager: NSObject {
    private weak var auth0Delegate          : Auth0Delegates?
    private var profile: UserInfo!

    
    init(delegate auth0Delegate:Auth0Delegates){
        self.auth0Delegate = auth0Delegate
        profile = SessionManager.shared.profile
    }
    /// Will initiate Auth0 Signup and store access token in Session Manager
    func auth0SignUp(){
        self.auth0Delegate?.showLoader()
        guard let clientInfo = plistValues(bundle: Bundle.main) else { return }
        SessionManager.shared.patchMode = true
        Auth0
            .webAuth()
            .scope("openid profile offline_access read:current_user update:current_user_metadata")
            .audience("https://" + clientInfo.domain + "/api/v2/")
            .start {
                switch $0 {
                case .failure(let error):
                    self.auth0Delegate?.hideLoader()
                    self.auth0Delegate?.didFailed(err: error)
                    print("Error: \(error)")
                case .success(let credentials):
                    if(!SessionManager.shared.store(credentials: credentials)) {
                        print("Failed to store credentials")
                    } else {
                        SessionManager.shared.retrieveProfile { error in
                            DispatchQueue.main.async {
                                guard error == nil else {
                                    print("Failed to retrieve profile: \(String(describing: error))")
                                    return
                                }
                                self.auth0Delegate?.hideLoader()
                                self.auth0Delegate?.didLoggedIn()
                            }
                        }
                    }
                }
        }
    }
    
    /// Will get user Profile and save in Session Manager
    func auth0RetreiveProfile(){
        guard let accessToken = SessionManager.shared.credentials?.accessToken else {
            return print("Failed to retrieve access token")
        }
        Auth0
            .users(token: accessToken)
            .get(self.profile.sub, fields: ["user_metadata"])
            .start { result in
                switch(result) {
                case .success(let profile):
                    self.auth0Delegate?.didRetreivedProfile()
                     print(profile)
                case .failure(let error):
                    self.auth0Delegate?.didFailed(err: error)
                    print("Failed to retrieve profile: \(String(describing: error))")
                }
        }
    }
    
    /// Will Update user with given data
    ///
    /// - Parameters:
    ///   - firstName: String
    ///   - lastName: String
    ///   - phone: String
    func auth0UpdateUserMetadata(firstName:String, lastName:String, phone:String){
        self.auth0Delegate?.showLoader()
        guard let accessToken = SessionManager.shared.credentials?.accessToken else {
            return print("Failed to retrieve access token")
        }
        print(self.profile.sub)
        Auth0
            .users(token: accessToken)
            .patch(self.profile.sub, userMetadata: ["first_name": firstName,"last_name":lastName,"phone_number":phone])
            .start { result in
                switch(result) {
                case .success(_):
                    print("Success")
                    self.auth0Delegate?.didUpdatedProfile()
                    self.auth0Delegate?.hideLoader()
                case .failure(let error):
                    self.auth0Delegate?.didFailed(err: error)
                    self.auth0Delegate?.hideLoader()
                    print("Failed to retrieve profile: \(String(describing: error))")
                }
        }
    }
    
    /// Get values for Auth0 signup from plist
    ///
    /// - Parameter bundle: Main Bundle
    /// - Returns: clientId,domain
    
    func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
        guard
            let path = bundle.path(forResource: "Auth0", ofType: "plist"),
            let values = NSDictionary(contentsOfFile: path) as? [String: Any]
            else {
                print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
                return nil
        }
        
        guard
            let clientId = values["ClientId"] as? String,
            let domain = values["Domain"] as? String
            else {
                print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
                print("File currently has the following entries: \(values)")
                return nil
        }
        return (clientId: clientId, domain: domain)
    }

}
