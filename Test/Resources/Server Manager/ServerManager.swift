//
//  ServerManager.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias ServerSuccessCallBack = (_ json:JSON)->Void
typealias ServerFailureCallBack=(_ error:Error?)->Void
typealias NetworkFailureCallBack=(_ error:String?)->Void

class ServerManager: NSObject {

    //Shared Instance
    class var shared:ServerManager{
        struct  Singlton{
            static let instance = ServerManager()
        }
        return Singlton.instance
    }
    
    func httpget(url: String, successHandler:ServerSuccessCallBack?, failureHandler:ServerFailureCallBack?, networkHandler:NetworkFailureCallBack?) {
        if AppManager.sharedInstance.isConnectedToNetwork(){
            Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                switch response.result{
                case .success:
                    let json = JSON.init(response.result.value!)
                    if (successHandler != nil){
                        if ((json.null) == nil){
                            successHandler!(json)
                        }
                    }
                case .failure:
                    failureHandler!(response.error)
                }
            }
        }else{
            networkHandler!("No Network Connection")
        }
        
    }
    func httpPost(url: String, param:[String:Any], successHandler:ServerSuccessCallBack?, failureHandler:ServerFailureCallBack?, networkHandler:NetworkFailureCallBack?) {
        if AppManager.sharedInstance.isConnectedToNetwork(){
            Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                switch response.result{
                case .success:
                    let json = JSON.init(response.result.value!)
                    if (successHandler != nil){
                        if ((json.null) == nil){
                            successHandler!(json)
                        }
                    }
                case .failure:
                    failureHandler!(response.error)
                }
            }
        }else{
            networkHandler!("No Network Connection")
        }
        
    }
}
