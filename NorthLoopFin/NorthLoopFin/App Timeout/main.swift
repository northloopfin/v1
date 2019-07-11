//
//  main.swift
//  NorthLoopFin
//
//  Created by Daffolapmac-19 on 04/02/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation

//UIApplicationMain(
//    CommandLine.argc,
//    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
//        .bindMemory(
//            to: UnsafeMutablePointer<Int8>.self,
//            capacity: Int(CommandLine.argc)),
//    NSStringFromClass(TouchTimer.self),
//    NSStringFromClass(AppDelegate.self)
//)

UIApplicationMain(
    CommandLine.argc, CommandLine.unsafeArgv,
    NSStringFromClass(TouchTimer.self), NSStringFromClass(AppDelegate.self)
)
