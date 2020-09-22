//
//  AppDelegate.m
//  TuyaSmartiOSBizBundleDemo_OC
//
//  Created by Misaka on 2020/9/22.
//  Copyright © 2020 TuyaInc. All rights reserved.
//

#import "AppDelegate.h"
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import <TuyaSmartBizCore/TuyaSmartBizCore.h>
#import <TYModuleServices/TYMallProtocol.h>
#import <TYModuleServices/TYActivatorProtocol.h>
#import <TYModuleServices/TYPanelProtocol.h>
#import <TYModuleServices/TYSmartSceneProtocol.h>
#import <TYModuleServices/TYHelpCenteProtocol.h>
#import <TYModuleServices/TYMessageCenterProtocol.h>
#import <TYModuleServices/TYSmartHomeDataProtocol.h>
#import <TuyaSmartDemo/TYDemoConfiguration.h>
#import <TuyaSmartDemo/TYDemoApplicationImpl.h>
#import <TuyaSmartDemo/TYDemoSmartHomeManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - TYSmartHomeDataProtocol

- (TuyaSmartHome *)getCurrentHome {
    long long homeId = [TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId;
    return  [TuyaSmartHome homeWithHomeId:homeId];
}


#pragma mark - TYDemoPanelControlProtocol

- (void)gotoPanelControlDevice:(TuyaSmartDeviceModel *)device group:(TuyaSmartGroupModel *)group {
    
    // Case: 设备控制业务包
    {
        id <TYPanelProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYPanelProtocol)];
        [impl gotoPanelViewControllerWithDevice:device group:group initialProps:nil contextProps:nil completion:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Load error: %@", error);
            }
        }];
    }

    // Case: 商城业务包
    {
//        id<TYMallProtocol> mallImpl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYMallProtocol)];
//        [mallImpl checkIfMallEnableForCurrentUser:^(BOOL enable, NSError *error) {
//          if (error) {
//            // 查询失败时返回 error
//            NSLog(@"%@",error);
//          } else {
//            // enable 为 true 则商城可用，否则不可用
//            NSLog(@"%@",@(enable));
//          }
//        }];
    }

    // Case: 配网业务包
    {
//        id<TYActivatorProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYActivatorProtocol)];
//        [impl gotoCategoryViewController];
//
//        // 获取配网结果
//        [impl activatorCompletion:TYActivatorCompletionNodeNormal customJump:NO completionBlock:^(NSArray * _Nullable deviceList) {
//            NSLog(@"deviceList: %@",deviceList);
//        }];
    }

    // Case: 场景业务包
    {
//        id<TYSmartSceneProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYSmartSceneProtocol)];
//        [impl addAutoScene:^(TuyaSmartSceneModel *secneModel, BOOL addSuccess) {
//
//        }];
    }

    // Case: 常见问题与反馈业务包
    {
//        id<TYHelpCenteProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYHelpCenteProtocol)];
//        [impl gotoHelpCenter];
    }

    // Case: 消息中心业务包
    {
//        id<TYMessageCenterProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYMessageCenterProtocol)];
//        [impl gotoMessageCenterViewControllerWithAnimated:true];
    }
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    TYDemoConfigModel *config = [[TYDemoConfigModel alloc] init];
    // 用户记得自行填写自己 Iot 平台上申请的 appkey 和 secretkey 以及在工程中导入加密图片。
    config.appKey = @"<#content#>";
    config.secretKey = @"<#content#>";
    
    // 注册 Demo 设备控制页
    [[TYDemoConfiguration sharedInstance] registService:@protocol(TYDemoPanelControlProtocol) withImpl:self];
    // 注册获取当前家庭的服务
    [[TuyaSmartBizCore sharedInstance] registerService:@protocol(TYSmartHomeDataProtocol) withInstance:self];
    
    // 注册路由监听
    [[TuyaSmartBizCore sharedInstance] registerRouteWithHandler:^BOOL(NSString * _Nonnull url, NSDictionary * _Nonnull raw) {
        NSLog(@"%@", url);
        return NO;
    }];
    
    return [[TYDemoApplicationImpl sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions config:config];
}

@end
