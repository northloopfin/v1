//
//  BasicInfo.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 28/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

import RealmSwift

class BasicInfo: Object {
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    @objc dynamic var confirmPassword = ""
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var phone = ""
    @objc dynamic var streetAddress = ""
    @objc dynamic var country = ""
    @objc dynamic var phoneSecondary = ""
    @objc dynamic var countryCode = ""
    @objc dynamic var city = ""
    @objc dynamic var zip = ""
    @objc dynamic var otp1 = ""
    @objc dynamic var otp2 = ""
    @objc dynamic var otp3 = ""
    @objc dynamic var otp4 = ""


}
