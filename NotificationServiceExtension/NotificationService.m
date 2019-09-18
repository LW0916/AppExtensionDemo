//
//  NotificationService.m
//  NotificationServiceExtension
//
//  Created by linwei on 2019/9/11.
//  Copyright © 2019 linwei. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService
// 系统接到通知后，有最多30秒在这里重写通知内容（如下载附件并更新通知）
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    // 设置categoryIdentifier
    self.bestAttemptContent.categoryIdentifier = @"LWNotificationCategory";
    
    self.contentHandler(self.bestAttemptContent);
}
// 处理过程超时，则收到的通知直接展示出来
- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
