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
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
    @objc dynamic var ssn = ""
    @objc dynamic var citizenShip = ""
    @objc dynamic var phone = ""
    
    @objc dynamic var passportNumber = ""
    @objc dynamic var DOB = ""
    @objc dynamic var university = ""

    @objc dynamic var streetAddress = ""
    @objc dynamic var houseNumber = ""
    @objc dynamic var state = ""
    @objc dynamic var city = ""
    @objc dynamic var zip = ""

}
