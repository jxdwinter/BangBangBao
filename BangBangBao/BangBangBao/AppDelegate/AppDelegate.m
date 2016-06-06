//
//  AppDelegate.m
//  BangBangBao
//
//  Created by Xiaodong Jiang on 6/3/16.
//  Copyright © 2016 PAYBAO INTERNATIONAL LIMITED. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RecordViewController.h"
#import "SettingViewController.h"
#import "BaseNavigationController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Flurry.h>
#import <JPFPSStatus.h>
#import <GBVersionTracking.h>
#import <YTKNetworkConfig.h>
#import <JDStatusBarNotification.h>

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, strong) BaseNavigationController *yunbaoNavController;
@property (nonatomic, strong) BaseNavigationController *recordNavController;
@property (nonatomic, strong) BaseNavigationController *settingNavController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self config];
    [self configUI];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    NSLog(@"stringToken:%@",pushToken);
    if (pushToken && pushToken.length) {
        
    }else{
        pushToken = @"0";
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // 处理推送消息
    NSLog(@"error:%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
    NSLog(@"userinfo:%@",userInfo);
}

/*
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
 return  YES;
 }
 
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
 return YES;
 }
 */

#pragma mark - APP Config
#pragma mark -

- (void) config{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //跟踪版本
    [GBVersionTracking track];
    
    //注册网络改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkreachabilitystatuschanged:)
                                                 name:@"NETWORKREACHABILITYSTATUSCHANGED" object:nil];
    
    //监控网络
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREACHABILITYSTATUSCHANGED" object:[NSNumber numberWithInteger:status]];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 开始推送通知
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
#ifdef __IPHONE_8_0
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound |
                                                                                               UIUserNotificationTypeAlert |
                                                                                               UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    /*!
     *  设置图片缓存默认大小200M,图片缓存时间为7天
     */
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache setMaxCacheSize:1024*1024*200];
    
    
    /**
     *  初始化数据库
     */
    /*
    SharedDatabaseHelper *sharedDatabaseHelper = [SharedDatabaseHelper sharedDatabaseHelper];
    NSLog(@"%@",[sharedDatabaseHelper description]);
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = BASEURL;
    */
    
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    [Fabric with:@[CrashlyticsKit]];
    [Flurry startSession:@"KVQKB3QRRCZ4D98WCNV6"];
}


#pragma mark - UI Config
#pragma mark -

- (void)configUI{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor] } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor] } forState:UIControlStateNormal];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.translucent = NO;
    
    self.yunbaoNavController = [[BaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.recordNavController = [[BaseNavigationController alloc] initWithRootViewController:[[RecordViewController alloc] init]];
    self.settingNavController = [[BaseNavigationController alloc] initWithRootViewController:[[SettingViewController alloc] init]];
    
    NSArray* controllers = @[self.yunbaoNavController,self.recordNavController,self.settingNavController];
    self.tabBarController.viewControllers = controllers;
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];

    //tabBarItem0.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
    tabBarItem0.image = [[UIImage imageNamed:@"tabbar_yuanbao"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem0.selectedImage = [[UIImage imageNamed:@"tabbar_yuanbao_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem0.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //tabBarItem1.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
    tabBarItem1.image = [[UIImage imageNamed:@"tabbar_record"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"tabbar_record_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //tabBarItem2.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
    tabBarItem2.image = [[UIImage imageNamed:@"tabbar_setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"tabbar_setting_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    self.tabBarController.selectedIndex = 0;
    [self launchRootViewController];
    [self.window makeKeyAndVisible];
}

- (void)setupRootViewController {
    
    self.window.rootViewController = self.tabBarController;
//    /**
//     *  如果当前用户已经登录
//     */
//    if ([[AccountManager sharedAccountManager] getCurrentUser]) {
//        /**
//         *  如果当前用户登录并且已经完善信息
//         */
//        if ([[[[AccountManager sharedAccountManager] getCurrentUser] realName] length]) {
//            self.window.rootViewController = self.tabBarController;
//        }else{
//            self.window.rootViewController = [[BaseNavigationController alloc]
//                                              initWithRootViewController:[[CompleteViewController alloc] init]];
//        }
//    }else{
//        self.window.rootViewController = [[BaseNavigationController alloc]
//                                          initWithRootViewController:[[LoginViewController alloc] init]];
//    }
}

/**
 *  第一次启动客户端或者是某一个版本的第一次启动
 */
- (void)launchRootViewController{
    [self setupRootViewController];
    /*
    if ([GBVersionTracking isFirstLaunchEver] || [GBVersionTracking isFirstLaunchForVersion]) {
        self.window.rootViewController = [[IntroViewController alloc] init];
    }else{
        [self setupRootViewController];
    }
     */
}

//网络情况改变通知
- (void)networkreachabilitystatuschanged:(NSNotification*)aNotification{
    AFNetworkReachabilityStatus status = [(NSNumber *)aNotification.object integerValue];
    NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            break;
        case AFNetworkReachabilityStatusNotReachable:
            [JDStatusBarNotification showWithStatus:@"無網絡連接" dismissAfter:2.0 styleName:JDStatusBarStyleWarning];
            break;
        default:
            break;
    }
}

@end
