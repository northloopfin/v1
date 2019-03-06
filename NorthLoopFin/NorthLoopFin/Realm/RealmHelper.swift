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
    
    static func updateNote(infoToBeUpdated: BasicInfo, newInfo: BasicInfo) {
        let realm = try! Realm()
        try! realm.write() {
            if newInfo.email != ""{
                infoToBeUpdated.email = newInfo.email
            }
            if newInfo.password != ""{
                infoToBeUpdated.password = newInfo.password
            }
            if newInfo.confirmPassword != ""{
                infoToBeUpdated.confirmPassword = newInfo.confirmPassword
            }
            if newInfo.firstname != ""{
                infoToBeUpdated.firstname = newInfo.firstname
            }
            if newInfo.lastname != ""{
                infoToBeUpdated.lastname = newInfo.lastname
            }
            if newInfo.phone != ""{
                infoToBeUpdated.phone = newInfo.phone
            }
            if newInfo.otp1 != ""{
                infoToBeUpdated.otp1 = newInfo.otp1
            }
            if newInfo.otp2 != ""{
                infoToBeUpdated.otp2 = newInfo.otp2
            }
            if newInfo.otp3 != ""{
                infoToBeUpdated.otp3 = newInfo.otp3
            }
            if newInfo.otp4 != ""{
                infoToBeUpdated.otp4 = newInfo.otp4
            }
            if newInfo.streetAddress != ""{
                infoToBeUpdated.streetAddress = newInfo.streetAddress
            }
            if newInfo.country != ""{
                infoToBeUpdated.country = newInfo.country
            }
            if newInfo.city != ""{
                infoToBeUpdated.city = newInfo.city
            }
            if newInfo.phoneSecondary != ""{
                infoToBeUpdated.phoneSecondary = newInfo.phoneSecondary
            }
            if newInfo.countryCode != ""{
                infoToBeUpdated.countryCode = newInfo.countryCode
            }
            if newInfo.zip != ""{
                infoToBeUpdated.zip = newInfo.zip
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
}
