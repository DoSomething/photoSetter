//
//  PHSSettingsViewController.h
//  photoSetter
//
//  Created by Tong Xiang on 7/7/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHSImageViewController.h"

@interface PHSSettingsViewController : UIViewController <PHSImageViewControllerDelegate>
- (IBAction)addPhoto:(id)sender;
- (IBAction)uploadPhoto:(id)sender;
- (IBAction)logout:(id)sender;
@end