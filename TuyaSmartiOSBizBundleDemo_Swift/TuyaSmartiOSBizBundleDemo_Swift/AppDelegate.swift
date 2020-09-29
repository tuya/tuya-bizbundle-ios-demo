//
//  AppDelegate.swift
//  TuyaSmartiOSBizBundleDemo_Swift
//
//  Created by Misaka on 2020/9/22.
//  Copyright © 2020 TuyaInc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TYSmartHomeDataProtocol, TYDemoPanelControlProtocol {
    
    var window: UIWindow?
    
    func getCurrentHome() -> TuyaSmartHome! {
        let homeId = TYDemoSmartHomeManager.sharedInstance()?.currentHomeModel.homeId
        return TuyaSmartHome.init(homeId: homeId!)
    }
    
    func gotoPanelControlDevice(_ device: TuyaSmartDeviceModel?, group: TuyaSmartGroupModel?) {
        
        // Case: 设备控制业务包
        let panelImpl = TuyaSmartBizCore.sharedInstance().service(of: TYPanelProtocol.self) as! TYPanelProtocol
        panelImpl.gotoPanelViewController(withDevice: device!, group: group, initialProps: nil, contextProps: nil) { (error) in
            if let e = error {
                print("\(e)")
            }
        }
            
        // Case: 商城业务包
//        let mallImpl = TuyaSmartBizCore.sharedInstance().service(of: TYMallProtocol.self) as! TYMallProtocol
//        mallImpl.checkIfMallEnable { (enable, error) in
//
//        }
        
        // Case: 配网业务包
//        let activatorImpl = TuyaSmartBizCore.sharedInstance().service(of: TYActivatorProtocol.self) as! TYActivatorProtocol
//        activatorImpl.gotoCategoryViewController()
//
//        activatorImpl.activatorCompletion(TYActivatorCompletionNode.normal, customJump: false, completionBlock: { (deviceList) in
//
//        })
        
        // Case: 常见问题与反馈业务包
//        let helpImpl = TuyaSmartBizCore.sharedInstance().service(of: TYHelpCenteProtocol.self) as! TYHelpCenteProtocol
//        helpImpl.gotoHelpCenter?()
        
        // Case: 消息中心业务包
//        let msgImpl = TuyaSmartBizCore.sharedInstance().service(of: TYMessageCenterProtocol.self) as! TYMessageCenterProtocol
//        msgImpl.gotoMessageCenterViewControllerWith(animated: true)
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let config = TYDemoConfigModel.init()
        // 用户记得自行填写自己 Iot 平台上申请的 appkey 和 secretkey 以及在工程中导入加密图片。
        config.appKey = "<#appkey#>"
        config.secretKey = "<#secretKey#>"
        
        // 注册 Demo 设备控制页
        TYDemoConfiguration.sharedInstance().registService(TYDemoPanelControlProtocol.self, withImpl: self)
        
        // 注册获取当前家庭的服务
        TuyaSmartBizCore.sharedInstance().registerService(TYSmartHomeDataProtocol.self, withInstance: self)
        
        // 注册路由监听
        TuyaSmartBizCore.sharedInstance().registerRoute { (url, raw) -> Bool in
            print("\(url)")
            return false
        }
        
        return TYDemoApplicationImpl.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions, config: config)
    }
}
