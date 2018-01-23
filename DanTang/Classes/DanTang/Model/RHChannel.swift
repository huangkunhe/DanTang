//
//  RHChannel.swift
//  DanTang
//
//  Created by river on 2018/1/19.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit

class RHChannel: NSObject {
    
    var editable: Bool?
    var id: Int?
    var name: String?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }

}
