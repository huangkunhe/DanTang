//
//  RHConst.swift
//  DanTang
//
//  Created by river on 2018/1/17.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import Foundation
import UIKit

/// code 码 200 操作成功
let RETURN_OK = 200
/// 服务器地址
let BASE_URL = "http://api.dantangapp.com/"

/// 间距
let kMargin: CGFloat = 10.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 1.0
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 新特性界面图片数量
let kNewFeatureCount = 4
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 动画时长
let kAnimationDuration = 0.25
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height
/// 分类界面 顶部 item 的高
let kitemH: CGFloat = 100
/// 分类界面 顶部 item 的宽
let kitemW: CGFloat = 150
/// 我的界面头部图像的高度
let kYMMineHeaderImageHeight: CGFloat = 200
// 分享按钮背景高度
let kTopViewH: CGFloat = 230

/// RGBA的颜色设置
func RHColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
     return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func RHGlobalColor() -> UIColor {
    return RHColor(r: 240, g: 240, b: 240, a: 1)
}

///红色
func RHGlobalRedColor() -> UIColor  {
     return RHColor(r: 245, g: 80, b: 83, a: 1.0)
}
