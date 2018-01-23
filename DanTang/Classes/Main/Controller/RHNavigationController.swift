//
//  RHNavigationController.swift
//  DanTang
//
//  Created by river on 2018/1/17.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit

class RHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = RHGlobalRedColor()
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(navigationBackClick))
        }
        super.pushViewController(viewController, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func navigationBackClick() {
        
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        popViewController(animated: true)
    }


}
