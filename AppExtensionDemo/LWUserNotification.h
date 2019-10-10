//
//  LWUserNotification.h
//  AppExtensionDemo
//
//  Created by linwei on 2019/9/20.
//  Copyright © 2019 linwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"


typedef NS_ENUM(NSUInteger, AttachmentType) {
    AttachmentTypeImage,
    AttachmentTypeImageGif,
    AttachmentTypeAudio,
    AttachmentTypeMovie
};


NS_ASSUME_NONNULL_BEGIN

@interface LWUserNotification : NSObject

MInterfaceSharedInstance(sharedNotification)

- (void)registerNotificationWithOptions:(NSDictionary *)launchOptions;
- (void)cancelLocalNotificaitons;

#pragma mark - 本地-附件

- (void)addNotificationWithAttachmentType:(AttachmentType)type;


#pragma mark - AppDelegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

@end

NS_ASSUME_NONNULL_END
