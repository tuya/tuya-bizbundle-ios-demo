//
//  TYAppDelegate.m
//  TuyaSmartiOSBizBundleDemo
//
//  Created by lialong on 09/07/2020.
//  Copyright (c) 2020 lialong. All rights reserved.
//

#import "TYAppDelegate.h"
#import <TuyaSmartDemo/TYDemoApplicationImpl.h>
#import <TuyaSmartDeviceKit/TuyaSmartDevice.h>
#import <TYModuleServices/TYCameraProtocol.h>
#import <TuyaSmartDemo/TYDemoConfiguration.h>
#import <TYModuleServices/TYPanelProtocol.h>
#import <TuyaSmartBizCore/TuyaSmartBizCore.h>
#import <TYModuleServices/TYSmartHomeDataProtocol.h>
#import <TYModuleServices/TYModuleServices.h>
#import <TuyaSmartDemo/TYDemoSmartHomeManager.h>
#import "TYModule.h"

@interface TYAppDelegate () <TYDemoPanelControlProtocol,TYSmartHomeDataProtocol>

@end

@implementation TYAppDelegate

- (TuyaSmartHome *)getCurrentHome {
    long long homeId = [TYDemoSmartHomeManager sharedInstance].currentHomeModel.homeId;
    return  [TuyaSmartHome homeWithHomeId:homeId];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    TYDemoConfigModel *config = [[TYDemoConfigModel alloc] init];
    // 用户记得自行填写自己 Iot 平台上申请的 appkey 和 secretkey 以及在工程中导入加密图片。
    config.appKey = @"";
    config.secretKey = @"";

    [[TYDemoConfiguration sharedInstance] registService:@protocol(TYDemoPanelControlProtocol) withImpl:self];
    [[TuyaSmartBizCore sharedInstance] registerService:@protocol(TYSmartHomeDataProtocol) withInstance:self];
    
    [[TuyaSmartBizCore sharedInstance] registerRouteWithHandler:^BOOL(NSString * _Nonnull url, NSDictionary * _Nonnull raw) {
        NSLog(@"%@", url);
        return NO;
    }];
    
    return [[TYDemoApplicationImpl sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions config:config];
    
    return YES;
}

- (void)gotoPanelControlDevice:(TuyaSmartDeviceModel *)device group:(TuyaSmartGroupModel *)group {
    // 简单验证 panel 页面包的协议
    id <TYPanelProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYPanelProtocol)];
    [impl gotoPanelViewControllerWithDevice:device group:group initialProps:nil contextProps:nil completion:nil];

    // 简单验证 跳转到常见问题与反馈页面
//    id<TYHelpCenteProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYHelpCenteProtocol)];

//    [impl gotoHelpCenter];
}

- (void)gotoMessageCenter {
    id <TYMessageCenterProtocol> impl = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYMessageCenterProtocol)];
    [impl gotoMessageCenterViewControllerWithAnimated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
