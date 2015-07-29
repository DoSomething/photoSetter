//
//  PHSImageViewController.h
//  photoSetter
//
//  Created by Tong Xiang on 7/14/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning You also have constraint errors in your PHSImageViewController.xib file

#warning Below is incorrect

// 1. Forward declaration of PHSImageViewControllerDelegate - this declares that a ChildViewControllerDelegate
// type exists so we can use it later.

@protocol PHSImageViewControllerDelegate;

// This forward declaration of PHSImageViewControllerDelegate exists so that you can reference it in its
//delegate property declaration below:

/* @property (nonatomic, weak) id<PHSImageViewControllerDelegate> delegate;
 This is saying that the delegate is an 'id'--an object without a type--but that it conforms to the
 'PHSImageViewControllerDelegate' protocol you declare with the forward declaration above. Without that, you
 wouldn't be able to reference it in the delegate property declaration
 */

// 2. Declaration of the view controller class
@interface PHSImageViewController : UIViewController

// indicates that we're implementing instances of the image picker controller delegate protocol as well as the navigation bar delegate protocol.
<UIImagePickerControllerDelegate, UINavigationBarDelegate>

#warning This should be typed thus (on one line):

// @interface PHSImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate>

// Another way to say it (and possibly easier to understand) is that your PHSImageViewController conforms to the
// UIImagePickerControllerDelegate and UINavigationBarDelegate protocols

#warning You're also missing the UINavigationControllerDelegate protocol
// ...which is why you're getting the error in your implementation file (not sure if you meant to have it conform
// to the UINavigationControllerDelegate protocol and not the UINavigationBarDelegate. Change your interface
// declaration to:

// @interface PHSImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>

// and it will go away.

// Delegate properties should always be weak references
// See http://stackoverflow.com/a/4796131/263871 for the rationale
@property (nonatomic, weak) id<PHSImageViewControllerDelegate> delegate;

#warning This is a flag to determine if it's been taken by the camera or not
// If it has been taken by the camera, this project is set up to save it to the camera roll; if it hasn't (i.e.,
// if self.newMedia == NO) then it doesn't save it to the camera roll. You can see how it gets set in the
// useCamera: and useCameraRoll: methods in the implementation file
@property BOOL newMedia; // what is this?

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)useCamera:(id)sender;
- (IBAction)useCameraRoll:(id)sender;

@end

#warning PHSImageViewControllerDelegate protocol declaration

// These are the methods that an object that conforms to your PHSImageViewControllerDelegate protocol must adopt
@protocol PHSImageViewControllerDelegate <NSObject>

- (void)PHSImageViewController:(PHSImageViewController*)viewController
                didChooseImage:(UIImage*)image;

@end