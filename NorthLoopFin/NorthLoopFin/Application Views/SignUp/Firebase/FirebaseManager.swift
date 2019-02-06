//
//  FirebaseManager.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 05/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager: NSObject {
    private weak var delegate          : FirebaseDelegates?
    
    init(delegate firebaseDelegate:FirebaseDelegates){
        self.delegate = firebaseDelegate
    }
    func createUserWithData(_ email:String, _ password:String){
        self.delegate?.showLoader()
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let authResult = authResult, error == nil else {
                print(error!.localizedDescription)
                self.delegate?.didFirebaseUserCreated(authResult: nil, error: error! as NSError)
                self.delegate?.hideLoader()
                return
            }
            self.delegate?.hideLoader()
            self.delegate?.didFirebaseUserCreated(authResult: authResult, error: nil)
            
        }
    }
    func updateUserWithData(firstName:String, lastName:String, phone:String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = firstName
        changeRequest?.commitChanges { (error) in
            
        }
    }
    
    func updatePhoneNumber(phone:String){
        //Auth.auth().updateCurrentUser(<#T##user: User##User#>, completion: <#T##UserUpdateCallback?##UserUpdateCallback?##(Error?) -> Void#>)
    }
    
}
