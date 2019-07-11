//
//  Environment.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

struct Env
{
    
    private static let staging : Bool = {
        #if STAGING
        print("STAGING")
        return true
        #elseif PRODUCTION
        print("PRODUCTION")
        return false
        #else
        print("RELEASE")
        return false
        #endif
    }()
    private static let production : Bool = {
        #if STAGING
        print("STAGING")
        return false
        #elseif PRODUCTION
        print("PRODUCTION")
        return true
        #else
        print("RELEASE")
        return false
        #endif
    }()
    
    static func isStaging () -> Bool {
        return self.staging
    }
    static func isProduction () -> Bool {
        return self.production
    }
    
}
