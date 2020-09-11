//
//  TYAddDeviceViewController.m
//  TuyaSmartBizBundleDemo_Example
//
//  Created by huangjj on 2020/9/10.
//  Copyright © 2020 lal603743923. All rights reserved.
//

#import "TYAddDeviceViewController.h"
#import "TYDemoConfiguration.h"
#import "TYDemoRouteManager.h"
#import "TYModuleServices.h"
#import "TuyaSmartBizCore.h"
#import "Masonry.h"
#import "TYDemoTheme.h"

@interface TYAddDeviceViewController () <TYTabBarVCProtocol>
@property (nonatomic, strong) UIButton *button;
@end

@implementation TYAddDeviceViewController
@dynamic barTitle;
@dynamic barImage;
@dynamic barSelectedImage;
@dynamic needNavigation;
@dynamic isMain;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [TYDemoTheme theme].primary_button_bg_color;
    [self.button setTitle:@"activator biz bundle" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(200);
    }];


}

- (void)buttonAction {
    // 跳转配网业务包
    id<TYActivatorProtocol> impl1 = [[TuyaSmartBizCore sharedInstance] serviceOfProtocol:@protocol(TYActivatorProtocol)];
    [impl1 gotoCategoryViewController];

    [impl1 activatorCompletion:TYActivatorCompletionNodeNormal customJump:NO completionBlock:^(NSArray * _Nullable deviceList) {
      NSLog(@"🐬🐬🐬🐬deviceList: %@",deviceList);
    }];
}

#pragma mark - config
TY_EXPORT_TABBAR(self)

- (NSString *)barTitle {
    return NSLocalizedString(@"Activate", @"");
}

- (UIImage *)barImage {
    return [UIImage imageNamed:@"ty_mainbt_add"];
}

- (UIImage *)barSelectedImage {
    return [UIImage imageNamed:@"ty_mainbt_add_active"];
}

- (BOOL)needNavigation {
    return YES;
}

- (BOOL)isMain {
    return NO;
}

@end
