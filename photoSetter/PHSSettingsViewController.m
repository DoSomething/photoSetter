//
//  PHSSettingsViewController.m
//  photoSetter
//
//  Created by Tong Xiang on 7/7/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import "PHSSettingsViewController.h"
#import "PHSImageViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

//URL for the staging server. @TODO: create global variable for below.
static NSString * const BaseURLString = @"https://northstar-qa.dosomething.org/v1/";

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
    
    if (!_imageView.image) {
        // @TODO: add alert here that a photo must be selected.
        return;
    }

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *userId = appDelegate.userId;
    
    NSDictionary *keysDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"]];

    NSString *appId = keysDictionary[@"appId"];
    NSString *apiKey = keysDictionary[@"northstarApiKey"];
    NSString *contentType = @"multipart/form-data";
    NSString *accept = @"application/json";
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // Setting headers.
    [manager.requestSerializer setValue:appId forHTTPHeaderField:@"X-DS-Application-Id"];
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"X-DS-REST-API-Key"];
    [manager.requestSerializer setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:accept forHTTPHeaderField:@"Accept"];
    
    // Image objects are immutable and do not provide direct access to their underlying image data. You can get an NSData object containing a JPEG representation of the image data using UIImageJPEGRepresentation.    // Taking the image from the _imageView property.
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 1.0);

    
    // We need to construct the URL string with the userId.
    NSString *urlPath = [NSString stringWithFormat:@"users/%@/avatar", userId];
    NSString *fileNameForImage = [NSString stringWithFormat:@"User_%@_ProfileImage", userId];
    
    AFHTTPRequestOperation *op = [manager POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // Appending the image to the body.
        [formData appendPartWithFileData:imageData name:@"photo" fileName:fileNameForImage mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
}

- (IBAction)logout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *sessionId = appDelegate.sessionId;
    
    NSDictionary *keysDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"]];
    
    NSString *appId = keysDictionary[@"appId"];
    NSString *apiKey = keysDictionary[@"northstarApiKey"];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:appId forHTTPHeaderField:@"X-DS-Application-Id"];
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"X-DS-REST-API-Key"];
    [manager.requestSerializer setValue:sessionId forHTTPHeaderField:@"Session"];
    
    NSString *urlPath = [NSString stringWithFormat:@"logout"];
    
    AFHTTPRequestOperation *op = [manager POST:urlPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // no body necessary
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successful logout: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error during logout: %@ ***** %@", operation.responseString, error);
    }];
    
    [op start];
}

- (void)PHSImageViewController:(PHSImageViewController *)viewController didChooseImage:(UIImage *)image {
    
    // local variable which comes imageView property from the class extension in the implementation.
    _imageView.image = image;
    
    // Dismisses child view controller
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end