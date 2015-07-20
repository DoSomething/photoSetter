//
//  AppDelegate.h
//  photoSetter
//
//  Created by Tong Xiang on 7/2/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, retain) NSMutableString *sessionId;

@property(nonatomic, retain) NSMutableString *userId;

@end