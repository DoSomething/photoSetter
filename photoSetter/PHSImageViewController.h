//
//  PHSImageViewController.h
//  photoSetter
//
//  Created by Tong Xiang on 7/14/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHSImageViewController : UIViewController

// indicates that we're implementing instances of the image picker controller delegate protocol as well as the navigation bar delegate protocol.
<UIImagePickerControllerDelegate, UINavigationBarDelegate>

@property BOOL newMedia; // what is this?

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;

@end
