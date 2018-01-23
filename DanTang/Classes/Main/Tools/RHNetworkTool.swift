//
//  RHNetworkTool.swift
//  DanTang
//
//  Created by river on 2018/1/18.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class RHNetworkTool: NSObject {
    
    static let shareNetworkTool = RHNetworkTool()
    
    /// 获取首页顶部选择数据
    func loadHomeTopData(finished:@escaping (_ ym_channels: [RHChannel]) -> ()) {
        
        let url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    SVProgressHUD.dismiss()
                    let data = dict["data"].dictionary
                    if let channels = data!["channels"]?.arrayObject {
                        var ym_channels = [RHChannel]()
                        for channel in channels {
                            let ym_channel = RHChannel(dict: channel as! [String: AnyObject])
                            ym_channels.append(ym_channel)
                        }
                        finished(ym_channels)
                    }
                }
        }
    }
    /// 获取首页数据
    func loadHomeInfo(id: Int, finished:@escaping (_ homeItems: [RHHomeItem]) -> ()) {
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(url, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    let data = dict["data"].dictionary
                    //  字典转成模型
                    if let items = data!["items"]?.arrayObject {
                        var homeItems = [RHHomeItem]()
                        for item in items {
                            let homeItem = RHHomeItem(dict: item as! [String: AnyObject])
                            homeItems.append(homeItem)
                        }
                        finished(homeItems)
                    }
                }
        }
    }
    
    ///获取单品数据
    func loadProductData(finished:@escaping(_ products: [RHProduct] )->()) {
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire
            .request(url, method: .get, parameters: params)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showError(withStatus: "加载失败...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue
                    guard code == RETURN_OK else {
                        SVProgressHUD.showInfo(withStatus: message)
                        return
                    }
                    if let data = dict["data"].dictionary {
                        if let items = data["items"]?.arrayObject {
                            var products = [RHProduct]()
                            for item in items {
                                let itemDict = item as! [String : AnyObject]
                                if let itemData = itemDict["data"] {
                                    let product = RHProduct(dict: itemData as! [String: AnyObject])
                                    products.append(product)
                                }
                            }
                            finished(products)
                        }
                    }
                }
        }
    }

}
