//
//  BioMetricHelper.swift
//  NorthLoopFin
//
//  Created by daffolapmac-48 on 24/06/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit
import LocalAuthentication

enum BioMetricSupported:String
{
    case touchId = "Touch ID"
    case faceId = "Face ID"
    case none = "none"
}

public struct BioMetricHelper
{
    
    typealias AuthSuccessBlock =  (_ bool: Bool  , _ errorMessage:String?) -> Void
    
    static func isDeviceSupportedforAuth () -> Bool
    {
        let  context = LAContext()
        var policy: LAPolicy?
        policy = .deviceOwnerAuthentication
        var err: NSError?
        guard context.canEvaluatePolicy(policy!, error: &err) else
        {
            return false
        }
        return true
        
    }
    
    @available(iOS 11.0, *)
    static func supportedBiometricType () -> BioMetricSupported
    {
        let context = LAContext()
        context.touchIDAuthenticationAllowableReuseDuration = 10;
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            
            if (context.biometryType == LABiometryType.faceID)
            {
                return BioMetricSupported.faceId
            }
            else if context.biometryType == LABiometryType.touchID
            {
                return BioMetricSupported.touchId
                
            }
            
        }
        return BioMetricSupported.none
    }
    
    static func isValidUer(reasonString:String , Success: @escaping AuthSuccessBlock = { _,_  in })
    {
        var policy: LAPolicy?
        let  context = LAContext()
        if #available(iOS 9.0, *)
        {
            /*
             
             deviceOwnerAuthenticationWithBiometrics can be used when you want to authenticate user solely based on
             bioMetric without reverting to PassCode if bioMetric fail
             
             simple :- biometricfail == policy Fail
             
             deviceOwnerAuthentication can be used when you want to authenticate based on bioMetric but also have
             a option to enter passcode if fail
             
             simple :- biometricfail = switch to passcode
             passcode_Also_fail = policy fail
             
             */
            policy = .deviceOwnerAuthentication
        }
        context.evaluatePolicy(policy!, localizedReason: reasonString, reply: { (successAuth, error) in
            DispatchQueue.main.async {
                
                if successAuth
                {
                    Success(true  , nil)
                }
                else
                {
                    guard let error = error else {
                        Success(false  , "UnknownError")
                        return
                    }
                    if #available(iOS 11.0, *) {
                        switch (error)
                        {
                        case LAError.authenticationFailed:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.userCancel:
                            //Success(false  , error.localizedDescription)
                            break
                        case LAError.userFallback:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.systemCancel:
                            //Success(false  , error.localizedDescription)
                            break
                        case LAError.passcodeNotSet:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.biometryNotAvailable:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.biometryNotEnrolled:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.biometryLockout:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.appCancel:
                            //Success(false  , error.localizedDescription)
                            break
                        case LAError.invalidContext:
                            Success(false  , error.localizedDescription)
                            break
                        default:
                            break
                        }
                    } else {
                        // Fallback on earlier versions
                        switch (error)
                        {
                        case LAError.authenticationFailed:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.userCancel:
                            //Success(false  , error.localizedDescription)
                            break
                        case LAError.userFallback:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.systemCancel:
                            //Success(false  , error.localizedDescription)
                            break
                        case LAError.passcodeNotSet:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.touchIDNotAvailable:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.touchIDNotEnrolled:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.touchIDLockout:
                            Success(false  , error.localizedDescription)
                            break
                        case LAError.appCancel:
                            //Success(false  , error.localizedDescription)
                            break
                        case LAError.invalidContext:
                            Success(false  , error.localizedDescription)
                            break
                        default:
                            break
                        }
                    }
                    return
                }
            }
        })
    }
}




