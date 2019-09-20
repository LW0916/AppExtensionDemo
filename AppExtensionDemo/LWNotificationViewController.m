//
//  LWNotificationViewController.m
//  AppExtensionDemo
//
//  Created by linwei on 2019/9/11.
//  Copyright © 2019 linwei. All rights reserved.
//


#import "LWNotificationViewController.h"
#import "LWUserNotification.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

#define LocalNotiReqIdentifer    @"LocalNotiReqIdentifer"

@interface LWNotificationViewController ()

@end

@implementation LWNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Notification"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGSize size = self.view.frame.size;
    CGFloat offset = 150;
    NSArray *titles = @[@"发送一个本地通知", @"移除一个本地通知"];
    for (int i=0; i<titles.count; i++) {
        NSString *title = [titles objectAtIndex:i];
        UIButton *btn = [self createCustomButton:title];
        btn.tag = i;
        [self.view addSubview:btn];
        btn.center = CGPointMake(size.width/2, offset);
        offset += btn.frame.size.height+10;
    }
}

- (UIButton *)createCustomButton:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, self.view.frame.size.width-30, 45);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setBorderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor];
    [btn.layer setBorderWidth:1.0];
    [btn.layer setCornerRadius:5.0];
    [btn.layer setMasksToBounds:YES];
    return btn;
}

- (void)btnClicked:(UIButton *)button {
    if (button.tag == 0) {
        [[LWUserNotification sharedNotification] addNotificationWithAttachmentType:AttachmentTypeAudio];
        
    } else if (button.tag == 1) {
        [[LWUserNotification sharedNotification] cancelLocalNotificaitons];
    }
}


@end
