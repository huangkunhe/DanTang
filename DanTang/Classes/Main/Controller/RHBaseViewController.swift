//
//  RHBaseViewController.swift
//  DanTang
//
//  Created by river on 2018/1/17.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

class RHBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.title!)
        view.backgroundColor = RHGlobalColor()
        navigationController?.fd_prefersNavigationBarHidden = true
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.white)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}
