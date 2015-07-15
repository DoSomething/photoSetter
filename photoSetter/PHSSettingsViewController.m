//
//  PHSSettingsViewController.m
//  photoSetter
//
//  Created by Tong Xiang on 7/7/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import "PHSSettingsViewController.h"
#import "PHSImageViewController.h"

@interface PHSSettingsViewController ()

@end

@implementation PHSSettingsViewController

- (IBAction)addPhoto:(id)sender {
    NSLog(@"add photo pressed!");
    PHSImageViewController *imageViewController = [[PHSImageViewController alloc] init];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (IBAction)uploadPhoto:(id)sender {
}

- (IBAction)logout:(id)sender {
}
@end
