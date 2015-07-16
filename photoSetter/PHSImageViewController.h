//
//  PHSImageViewController.h
//  photoSetter
//
//  Created by Tong Xiang on 7/14/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import <UIKit/UIKit.h>

// 1. Forward declaration of PHSImageViewControllerDelegate - this declares that a ChildViewControllerDelegate
// type exists so we can use it later.
@protocol PHSImageViewControllerDelegate;

// 2. Declaration of the view controller class
@interface PHSImageViewController : UIViewController

// indicates that we're implementing instances of the image picker controller delegate protocol as well as the navigation bar delegate protocol.
<UIImagePickerControllerDelegate, UINavigationBarDelegate>

// Delegate properties should always be weak references
// See http://stackoverflow.com/a/4796131/263871 for the rationale
@property (nonatomic, weak) id<PHSImageViewControllerDelegate> delegate;

@property BOOL newMedia; // what is this?

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;

@end

@protocol PHSImageViewControllerDelegate <NSObject>

- (void)PHSImageViewController:(PHSImageViewController*)viewController
                didChooseImage:(UIImage*)image;

@end