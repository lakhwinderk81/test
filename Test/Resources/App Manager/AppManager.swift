//
//  AppManager.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SystemConfiguration

class AppManager: NSObject {

    //SharedInstance
    class var sharedInstance: AppManager
    {
        struct Static
        {
            static let instance : AppManager = AppManager()
        }
        return Static.instance
    }
    
    //Checking ios version
    func isLowerThen_IOS13() -> Bool {
        if #available(iOS 13.0, *) {return false}else{return true}
    }
    
    //fetching current window as per ios version
    func appWindow() -> UIWindow{
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) else{
                return UIWindow()
            }
            return sd.window!
        } else {
            return AppDelegate.sharedAppDelegate().window!
        }
        
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection) ? true : false
    }
}
