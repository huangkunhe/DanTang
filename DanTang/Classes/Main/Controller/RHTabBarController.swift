//
//  RHTabBarController.swift
//  DanTang
//
//  Created by river on 2018/1/17.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit

class RHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = RHColor(r: 245, g: 90, b: 93, a: 1/0)
        addChildViewControllers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addChildViewControllers() {
        
        addChildViewController(childController: RHDanTangViewController(), title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController(childController: RHProductViewController(), title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController(childController: RHBaseViewController(), title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController(childController: RHBaseViewController(), title: "我的", imageName: "TabBar_me_boy_23x23_")
        
    }
    
    private func addChildViewController(childController: UIViewController ,title: String ,imageName: String){
        
        childController.tabBarItem.image = UIImage (named: imageName)
        childController.tabBarItem.selectedImage = UIImage (named: imageName+"selected")
        childController.title = title
        let navC = RHNavigationController(rootViewController: childController)
        addChildViewController(navC)
        
    }

}
