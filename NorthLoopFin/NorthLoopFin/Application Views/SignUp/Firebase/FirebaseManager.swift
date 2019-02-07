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
    var ref: DatabaseReference!
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
        self.delegate?.showLoader()
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = firstName
        changeRequest?.commitChanges { (error) in
            self.delegate?.hideLoader()
            guard error == nil else{
                print(error!.localizedDescription)
                self.delegate?.didNameUpdated(error: error! as NSError)
                return
            }
            print("Success")
            self.createUserInFirebaseDatabase(firstname: firstName, lastname: lastName, phone: phone)
        }
    }
    
    func createUserInFirebaseDatabase(firstname:String,lastname:String,phone:String){
        //let user:User = User.init(firstname: firstname, lastname: lastname, email: (Auth.auth().currentUser?.email)!, phone: phone)
        
        ref = Database.database().reference()
        let userId = Auth.auth().currentUser?.uid
        ref.child("Users").child(userId!).setValue(["firstname":firstname,"lastname":lastname,"email":Auth.auth().currentUser!.email ?? "","phone":phone]){(error:Error?, ref:DatabaseReference) in
        if let error = error{
                print("Data could not be saved: \(error).")
            }else{
                self.delegate?.didFirebaseDatabaseUpdated()
            }
        }
    }
}
