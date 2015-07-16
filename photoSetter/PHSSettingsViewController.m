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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PHSSettingsViewController

- (IBAction)addPhoto:(id)sender {
    NSLog(@"add photo pressed!");
    PHSImageViewController *imageViewController = [[PHSImageViewController alloc] init];
    
    // Assign self as the delegate for the child view controller
    imageViewController.delegate = self;
    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (IBAction)uploadPhoto:(id)sender {
}

- (IBAction)logout:(id)sender {
}

- (void)PHSImageViewController:(PHSImageViewController *)viewController didChooseImage:(UIImage *)image {
    
    // local variable which comes imageView property from the class extension in the implementation.
    _imageView.image = image;
    
    // Dismisses child view controller
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end