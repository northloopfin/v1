//
//  IP+Extension.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 24/07/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import Foundation


extension UIDevice {
    
    private struct InterfaceNames {
        static let wifi = ["en0"]
        static let wired = ["en2", "en3", "en4"]
        static let cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
        static let supported = wifi + wired + cellular
    }
    
    func ipAddress() -> String {
        var ipAddress: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else { return "127.0.0.1" }
        guard let firstAddr = ifaddr else { return "127.0.0.1" }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    ipAddress = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
//        if getifaddrs(&ifaddr) == 0 {
//            var pointer = ifaddr
//
//            while pointer != nil {
//                defer { pointer = pointer?.pointee.ifa_next }
//
//                guard
//                    let interface = pointer?.pointee,
//                    interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) || interface.ifa_addr.pointee.sa_family == UInt8(AF_INET6),
//                    let interfaceName = interface.ifa_name,
//                    let interfaceNameFormatted = String(cString: interfaceName, encoding: .utf8),
//                    InterfaceNames.supported.contains(interfaceNameFormatted)
//                    else { continue }
//
//                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//
//                getnameinfo(interface.ifa_addr,
//                            socklen_t(interface.ifa_addr.pointee.sa_len),
//                            &hostname,
//                            socklen_t(hostname.count),
//                            nil,
//                            socklen_t(0),
//                            NI_NUMERICHOST)
//
//                guard let formattedIpAddress = String(cString: hostname, encoding: .utf8), !formattedIpAddress.isEmpty
//                    else { continue }
//
//                ipAddress = formattedIpAddress
//                break
//            }
//
//            freeifaddrs(ifaddr)
//        }        
        return ipAddress == nil ? "127.0.0.1" : ipAddress!
    }
    
}

