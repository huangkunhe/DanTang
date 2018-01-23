//
//  RHDanTangViewController.swift
//  DanTang
//
//  Created by river on 2018/1/19.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit

class RHDanTangViewController: RHBaseViewController, UIScrollViewDelegate {

    var channel = [RHChannel]()
 
    weak var titlesView = UIView()
    
    weak var indicatorView = UIView()
    
    weak var contentView = UIScrollView()

    weak var selectedButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        weak var weakSelf = self
        // 获取首页顶部选择数据
        RHNetworkTool.shareNetworkTool.loadHomeTopData { (ym_channels) in
            for channel in ym_channels {
                let vc = RHTopicViewController()
                vc.title = channel.name!
                vc.type = channel.id!
                weakSelf!.addChildViewController(vc)
            }
            //设置顶部标签栏
            weakSelf!.setupTitlesView()
            // 底部的scrollview
            weakSelf!.setupContentView()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupNav(){
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(dantangRightBBClick))
    }
    
    @objc func dantangRightBBClick() {
//        let searchBarVC = YMSearchViewController()
//        navigationController?.pushViewController(searchBarVC, animated: true)
    }
    
    func setupTitlesView() {
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: kTitlesViewY, width: SCREENW, height: kTitlesViewH)
        view.addSubview(bgView)
        
        let titlesView = UIView()
        titlesView.frame = CGRect(x: 0, y: 0, width: SCREENW-kTitlesViewH, height: kTitlesViewH)
        titlesView.backgroundColor = RHGlobalColor()
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        
        let arrowButton = UIButton()
        arrowButton.frame = CGRect(x: SCREENW-kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowButton.backgroundColor = RHGlobalColor()
        arrowButton.setImage(UIImage (named: "arrow_index_down_8x4_"), for: .normal)
        arrowButton.addTarget(self, action: #selector(arrowButtonClick), for: .touchUpInside)
        bgView.addSubview(arrowButton)
        
        //底部红色指示器
        let indicatorView = UIView()
        indicatorView.backgroundColor = RHGlobalRedColor()
        indicatorView.height = kIndicatorViewH
        indicatorView.y = kTitlesViewH - kIndicatorViewH
        indicatorView.tag = -1
        self.indicatorView = indicatorView
        
        let count = childViewControllers.count
        let width = titlesView.width / CGFloat(count)
        let height = titlesView.height
        for index in 0..<count {
            let button = UIButton()
            button.width = width
            button.height = height
            button.x = CGFloat(index) * width
            button.tag = index
            
            let vc = childViewControllers[index]
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(vc.title!, for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.setTitleColor(RHGlobalRedColor(), for: .disabled)
            button.addTarget(self, action: #selector(titlesClick), for: .touchUpInside)
            titlesView.addSubview(button)
            //默认点击了第一个按钮
            if index == 0 {
                button.isEnabled = false
                selectedButton = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indicatorView.width = button.titleLabel!.width
                indicatorView.centerX = button.centerX
            }
        }
        //底部红色指示器
        titlesView.addSubview(indicatorView)
    }
    
    func setupContentView(){
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        
        let contenView = UIScrollView()
        contenView.delegate = self
        contenView.frame = view.bounds;
        contenView.contentSize = CGSize(width: contenView.width * (CGFloat)(childViewControllers.count), height: 0)
        contenView.isPagingEnabled = true
        view .insertSubview(contenView, at: 0)
        self.contentView = contenView
        //添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contenView)
    }
    
    
    /// 箭头按钮点击
    @objc func arrowButtonClick(button: UIButton) {
        UIView.animate(withDuration: kAnimationDuration) {
            button.imageView?.transform = button.imageView!.transform.rotated(by:.pi)
        }
    }

    /// 标签上的按钮点击
   @objc func titlesClick(button: UIButton) {
        // 修改按钮状态
        selectedButton!.isEnabled = true
        button.isEnabled = false
        selectedButton = button
        // 让标签执行动画
        UIView.animate(withDuration: kAnimationDuration) {
            self.indicatorView!.width = self.selectedButton!.titleLabel!.width
            self.indicatorView!.centerX = self.selectedButton!.centerX
        }
//        //滚动,切换子控制器
        var offset = contentView!.contentOffset
        offset.x = CGFloat(button.tag) * contentView!.width
        contentView!.setContentOffset(offset, animated: true)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        scrollViewDidEndScrollingAnimation(scrollView)
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 点击 Button
        let button = titlesView!.subviews[index] as! UIButton
        titlesClick(button: button)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
         print("scrollViewDidEndScrollingAnimation")
        // 添加子控制器的 view
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 取出子控制器
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0 // 设置控制器的y值为0(默认为20)
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
}
