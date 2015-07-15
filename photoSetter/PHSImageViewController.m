//
//  PHSImageViewController.m
//  photoSetter
//
//  Created by Tong Xiang on 7/14/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import "PHSImageViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface PHSImageViewController ()

@end

@implementation PHSImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)useCamera:(id)sender {
    // Checks that the device on which the app is running has a camera.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // Creates a UIImagePickerController instance
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        // Assigns the cameraViewController as the delegate for the object
        imagePicker.delegate = self;
        // Defines the media source as the camera
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        // Only images are supported media types, not videos.
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        // Displays camera interfaces
        [self presentViewController:imagePicker animated:YES completion:nil];
        // Indicates that the image is new and not an existing image from the camera roll
        _newMedia = YES;
    }
}

- (IBAction)useCameraRoll:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        // Indicates that image is already in the library and we don't need to save it again.
        _newMedia = NO;
    }
}

#pragma mark - 
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // identifies the type of media passed from the image picker controller
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    // dismisses the image picker view
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // If it's an image, it's displayed on the view image object of the user interface.
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        _imageView.image = image;
        
        // If it's a new image it's saved to the camera roll.
        if (_newMedia) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        // Code here to support video if enabled
    }
}

// Called when the save operation is complete.
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // If an error occurred it's reported to the user with an alert box.
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

// Tells the delegate that the user cancelled the pick operation, and dismisses the picker view.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
