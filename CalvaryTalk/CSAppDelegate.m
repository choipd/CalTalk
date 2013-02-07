//
//  CSAppDelegate.m
//  CalvaryTalk
//
//  Created by Choi Myungjin on 2/6/13.
//  Copyright (c) 2013 Choipd Studios. All rights reserved.
//

#import "CSAppDelegate.h"
#import <baas.io/Baas.h>

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Baasio setApplicationInfo:@"choipd" applicationName:@"calvarytalk"];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    return YES;
}

 -(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"device token is: %@",token);
    BaasioPush* baasio_push = [[BaasioPush alloc] init];
    [baasio_push registerInBackground:token
                                 tags: [NSArray arrayWithObjects:@"man", @"seoul", @"38", nil]
                         successBlock:^{
                             NSLog(@"푸시 등록 성공");
                             
                             BaasioMessage* msg = [[BaasioMessage alloc] init];
                             [msg setTarget:@"all"];
                             [msg setAlert:@"하이"];
                             
                             while (1) {
                                 [baasio_push sendPushInBackground:msg successBlock:^{
                                     NSLog(@"푸시 발송 성공");
                                 } failureBlock:^(NSError *error) {
                                     NSLog(@"푸시 발송 실패: %@", error.localizedDescription);
                                 }];
                             }
                         } failureBlock:^(NSError *error) {
                             NSLog(@"푸시 등록 실패");
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"푸시 등록에 실패하였습니다.\n다시 시도해주세요."
                                                                                 message:error.localizedDescription
                                                                                delegate:nil
                                                                       cancelButtonTitle:@"OK"
                                                                       otherButtonTitles:nil];
                             [alertView show];

                         }];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"received notification");
    //handle the notification here
}

@end
