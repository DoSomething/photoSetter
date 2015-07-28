//
//  AppDelegate.m
//  photoSetter
//
//  Created by Tong Xiang on 7/2/15.
//  Copyright (c) 2015 DoSomething. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFNetworkActivityLogger.h"
#import "PHSSettingsViewController.h"
#import "PHSImageViewController.h"

//URL for the staging server
static NSString * const BaseURLString = @"https://northstar-qa.dosomething.org/v1/";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PHSSettingsViewController *settingsVC = [[PHSSettingsViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityLogger sharedLogger]setLevel: AFLoggerLevelDebug];
	
#warning You'd want to move this into another class/multiple classes
	// If you want to use AFN, you'd subclass one of their session manager classes like we do in the DSO app;
	// otherwise, you'd make a networking class that subclasses NSObject to put this request together
	// You should also have a separate API class that other unrelated classes (view controllers) in your app call
	// to get info they need, if you'd have more than a few different endpoints to hit (personally, I think it's good
	// practice to do so, period, though).  I.e., your view controller would hit your app's API class like so
	
	/*
	 [APIClient loginUserWithEmail:userEmail andPassword:userPassword successBlock: ^{
		Do something (pun intended) if we login successfully, like present next view controller
	 } failureBlock ^{
		Handle error depending on info we get from server: incorrect password
	 }];
	 
	 */
	
	// I realize this is a simple project, but you should only put what's necessary in your AppDelegate.  The App
	// Delegate is what it sounds: a delegate to handle messages that the operating system (iOS) needs to communicate
	// to your app.  The App Delegate is your app's entry point, so you should just put whatever the top of your chain
	// of actions is in -application didFinishLaunchingWithOptions, i.e., set a nav controller and a root view controller,
	// start logging, initialize Core Data, etc.  Things that your app needs globally.
    NSString *northstarApiKey = @"northstarApiKey";
    NSString *userEmail = @"userEmail";
    NSString *userPassword = @"userPassword";
    NSString *appId = @"appId";
    
    NSDictionary *keysDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"keys" ofType:@"plist"]];
    
    // Creates an NSURL object, used to make an NSURLRequest
    NSString *urlString = [NSString stringWithFormat:@"%@login", BaseURLString];
    NSString *apiKeyHeader = keysDictionary[northstarApiKey];
    NSString *appIdHeader = keysDictionary[appId];
    NSString *bodyString = [NSString stringWithFormat:@"{ \"email\": \"%@\", \"password\":\"%@\"}", keysDictionary[userEmail], keysDictionary[userPassword]];

    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:apiKeyHeader forHTTPHeaderField:@"X-DS-REST-API-Key"];
    [request setValue:appIdHeader forHTTPHeaderField:@"X-DS-Application-Id"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPMethod:@"POST"];
    
    // AFHTTPRequestOperation is an all-in-one class for handling HTTP transfers.

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    // Indicates that the response should be parsed as JSON.
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *objectData = operation.responseObject;
        if ([NSJSONSerialization isValidJSONObject:objectData]) {
            NSMutableString *sessionToken = objectData[@"data"][@"session_token"];
            NSLog(@"Session Token: %@ \n", sessionToken);
            _sessionId = sessionToken;
            
            NSMutableString *userId = objectData[@"data"][@"_id"];
            _userId = userId;
            NSLog(@"userId: %@ \n", _userId);
        }
        else {
            [NSException raise:@"Response returned from API is invalid" format:@"JSON response is invalid: %@", objectData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"&&&Unresolved error logging in: %@", error);
    }];
    
    [operation start];

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
