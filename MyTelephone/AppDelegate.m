//
//  AppDelegate.m
//  MyTelephone
//
//  Created by Itai Ram on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <CoreTelephony/CTCallCenter.h>    
#import <CoreTelephony/CTCall.h>   
#import <CoreTelephony/CTCarrier.h>    
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize consoleLog;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    
    UINavigationController *screenOneDontNav = [[UINavigationController alloc]initWithRootViewController:self.viewController];

    self.window.rootViewController = screenOneDontNav;
    [self.window makeKeyAndVisible];
    return YES;

    
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];
//    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"*****applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"*****applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self
//                                                      selector: @selector(callAfterSixtySecond:) userInfo: nil repeats: YES];
//    
//    [self callAfterSixtySecond:nil];
    
//    while (1)
//    {
//        sleep(4);
//        NSLog(@"infinite loop");
//        NSDate *today = [NSDate date];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
//        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//        NSString *currentTime = [dateFormatter stringFromDate:today];
//        NSLog(@"User's current time in their preference format:%@",currentTime);
//        
//        NSString *message3 = [NSString stringWithFormat:@"User's current time in their preference format:%@",currentTime];
//        
//        consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
//
//    }
    
//    sleep(4);
//    
//    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"title" message:@"fsdfsd" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil , nil];
//    
//    [alert1 show];

    
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    { //Check if our iOS version supports multitasking I.E iOS 4
        if ([[UIDevice currentDevice] isMultitaskingSupported]) 
        { //Check if device supports mulitasking
            UIApplication *application = [UIApplication sharedApplication]; //Get the shared application instance
            
            __block UIBackgroundTaskIdentifier background_task; //Create a task object
            
            background_task = [application beginBackgroundTaskWithExpirationHandler: ^ {
                [application endBackgroundTask: background_task]; //Tell the system that we are done with the tasks
                background_task = UIBackgroundTaskInvalid; //Set the task to be invalid
                
                //System will be shutting down the app at any point in time now
            }];
            
            //Background tasks require you to use asyncrous tasks
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //Perform your tasks that your application requires
                
   
                NSLog(@"\n\nRunning in the background!\n\n");
                
                [application endBackgroundTask: background_task]; //End the task so the system knows that you are done with what you need to perform
                background_task = UIBackgroundTaskInvalid; //Invalidate the background_task
            });
        }
    }
    
        
}


-(void) callAfterSixtySecond:(NSTimer*) t
{
    NSLog(@"yellow background");
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
     NSLog(@"*******didReceiveRemoteNotification");
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        //the app is in the foreground, so here you do your stuff since the OS does not do it for you
        //navigate the "aps" dictionary looking for "loc-args" and "loc-key", for example, or your personal payload)
    }
    
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"*****applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"*****applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
       
    [self.viewController refreshCalls];
    
    
    
    
    CTCallCenter *callCenter = [[CTCallCenter alloc] init];
    
    callCenter.callEventHandler=^(CTCall* call)
    {
        if (call.callState == CTCallStateDisconnected){ 
            NSLog(@"Call has been disconnected");
        }
        else if (call.callState == CTCallStateConnected){
            NSLog(@"Call has just been connected");
        }
        else if(call.callState == CTCallStateConnected){
            NSLog(@"Call is incoming");
        }
        else{
            NSLog(@"None of the conditions");
        }
    };
    
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"title" message:@"Enter applicationDidBecomeActive" delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil , nil];

    [alert1 show];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"*****applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
