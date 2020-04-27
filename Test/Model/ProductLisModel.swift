//
//  ProductLisModel.swift
//  Test
//
//  Created by apple on 19/04/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class ProductLisModel: NSObject {
    var id : Int?
    var name : String?
    var price : Int?
    var image : String?
    var stock_status : String?
    var Description : String?

    init(data: JSON) {
        id = data["id"].intValue
        name = data["name"].stringValue
        price = data["price"].intValue
        image = data["image"].stringValue
        stock_status = data["stock_status"].stringValue
        Description = data["description"].stringValue
    }

}
