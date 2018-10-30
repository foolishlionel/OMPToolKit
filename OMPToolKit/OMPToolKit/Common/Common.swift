//
//  Common.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.height

/// 适配iPhoneX
let isIPhoneX = (kScreenWidth == 375.0 && kScreenHeight == 812.0)
let kNaviBarHeight: CGFloat = isIPhoneX ? 88.0 : 64.0
let kTabBarHeight: CGFloat = isIPhoneX ? 49.0 + 34.0 : 49.0
let kStatusBarHeight: CGFloat = isIPhoneX ? 44.0 : 20.0
let iPhoneXBottomHeight: CGFloat = 34.0
let iPhoneXTopHeight: CGFloat = 24.0

/// MARK: - 颜色方法
func kRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.9, alpha: a)
}

let kThemeWhiteColor = UIColor(hex: 0xFFFFFF)
let kThemeWhiteSmokeColor = UIColor(hex: 0xF5F5F5)
let kThemeMistyRoseColor = UIColor(hex: 0xFFE4E1)  // 薄雾玫瑰
let kThemeGainsboroColor = UIColor(hex: 0xF3F4F5)  // 亮灰色
let kThemeOrangeRedColor = UIColor(hex: 0xFF4500)  // 橙红色
let kThemeLimeGreenColor = UIColor(hex: 0x32CD32)  // 酸橙绿
let kThemeSnowColor = UIColor(hex: 0xFFFAFA)
let kThemeLightGreyColor = UIColor(hex: 0xD3D3D3)
let kThemeGreyColor = UIColor(hex: 0xA9A9A9)
let kThemeTomatoColor = UIColor(hex: 0xF7583B)
let kThemeDimGrayColor = UIColor(hex: 0x696969)
let kThemeBlackColor = UIColor(hex: 0x000000)
let kThemeBackgroundColor = UIColor(hex: 0xF4F4F4)

let kHabitIconPeonyPinkColor = UIColor(hex: 0xeea2a4) // 牡丹粉红
let kHabitIconRosePurpleColor = UIColor(hex: 0xba2f7b) // 玫瑰紫
let kHabitIconLightBluePurpleColor = UIColor(hex: 0xa7a8bd) // 淡蓝紫
let kHabitIconCloudWaterBlueColor = UIColor(hex: 0xbaccd9) // 云水蓝
let kHabitIconLightBlueGrayColor = UIColor(hex: 0x5e7987) // 淡蓝灰
let kHabitIconMoonShadowWhiteColor = UIColor(hex: 0xc0c4c3) // 月影白
let kHabitIconCuprumGreenColor = UIColor(hex: 0x2bae85) // 铜绿
let kHabitIconRapeFlowerYellowColor = UIColor(hex: 0xfbda41) // 油菜花黄
let kHabitIconPheasantBrownColor = UIColor(hex: 0x986524) // 山鸡褐


/// MARK: - 自定义打印方法
func ompLog<T>(_ message: T,
               file: String = #file,
               functionName: String = #function,
               lineNumber: Int = #line) {
    #if DEBUG
    let filename = (file as NSString).lastPathComponent
    print("\(filename):\(lineNumber)-\(message)")
    #endif
}

