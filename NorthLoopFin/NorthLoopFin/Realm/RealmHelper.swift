//
//  RealmHelper.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper{
    
    static func addBasicInfo(info: BasicInfo) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(info)
        }
    }
    
    static func addScanIDInfo(info: ScanIDImages) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(info)
        }
    }
    static func addSelfieInfo(info: SelfieImage) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(info)
        }
    }
    
    static func deleteBasicInfo(info: BasicInfo) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(info)
        }
    }
    static func deleteScanIDInfo(info: ScanIDImages) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(info)
        }
    }
    static func deleteSelfieInfo(info: SelfieImage) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(info)
        }
    }
    
    static func updateBasicInfo(infoToBeUpdated: BasicInfo, newInfo: BasicInfo) {
        let realm = try! Realm()
        try! realm.write() {
            if newInfo.email != ""{
                print("Email updated")
                infoToBeUpdated.email = newInfo.email
            }
            
            if newInfo.firstname != ""{
                print("firstname updated")

                infoToBeUpdated.firstname = newInfo.firstname
            }
            if newInfo.lastname != ""{
                print("lastname updated")

                infoToBeUpdated.lastname = newInfo.lastname
            }
            if newInfo.phone != ""{
                print("phone updated")

                infoToBeUpdated.phone = newInfo.phone
            }
            if newInfo.ssn != ""{
                print("ssn updated")

                infoToBeUpdated.ssn = newInfo.ssn
            }
            if newInfo.citizenShip != ""{
                print("citizenShip updated")

                infoToBeUpdated.citizenShip = newInfo.citizenShip
            }
            if newInfo.passportNumber != ""{
                print("passportNumber updated")

                infoToBeUpdated.passportNumber = newInfo.passportNumber
            }
            if newInfo.DOB != ""{
                print("DOB updated")
                
                infoToBeUpdated.DOB = newInfo.DOB
            }
            if newInfo.university != ""{
                print("university updated")
                
                infoToBeUpdated.university = newInfo.university
            }
            if newInfo.streetAddress != ""{
                print("streetAddress updated")

                infoToBeUpdated.streetAddress = newInfo.streetAddress
            }
            if newInfo.houseNumber != ""{
                print("houseNumber updated")

                infoToBeUpdated.houseNumber = newInfo.houseNumber
            }
            if newInfo.city != ""{
                print("city updated")

                infoToBeUpdated.city = newInfo.city
            }
            if newInfo.state != ""{
                print("state updated")

                infoToBeUpdated.state = newInfo.state
            }
            if newInfo.zip != ""{
                print("zip updated")

                infoToBeUpdated.zip = newInfo.zip
            }
            if newInfo.arrivalDate != ""{
                print("arrival updated")
                
                infoToBeUpdated.arrivalDate = newInfo.arrivalDate
            }
        }
    }
    
    static func retrieveBasicInfo() -> Results<BasicInfo> {
        let realm = try! Realm()
        //return realm.objects(Note).sorted("modificationTime", ascending: false)
        return realm.objects(BasicInfo.self)
    }
    
    static func retrieveImages() -> Results<ScanIDImages> {
        let realm = try! Realm()
        //return realm.objects(Note).sorted("modificationTime", ascending: false)
        return realm.objects(ScanIDImages.self)
    }
    
    static func retrieveSelfieImages() -> Results<SelfieImage> {
        let realm = try! Realm()
        //return realm.objects(Note).sorted("modificationTime", ascending: false)
        return realm.objects(SelfieImage.self)
    }
    
    static func deleteAllFromDatabase()  {
        let realm = try! Realm()
        try! realm.write() {
            realm.deleteAll()
        }
    }
    
    static func deleteAllScanID(){
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(realm.objects(ScanIDImages.self))
        }
    }
    static func deleteAllSelfie(){
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(realm.objects(SelfieImage.self))
        }
    }
    static func deleteAllBasicInfo(){
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(realm.objects(BasicInfo.self))
        }
    }
}
