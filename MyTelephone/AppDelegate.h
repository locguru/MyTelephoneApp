//
//  AppDelegate.h
//  MyTelephone
//
//  Created by Itai Ram on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    UITextView			*consoleLog;

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, retain) IBOutlet UITextView *consoleLog;

-(void) callAfterSixtySecond:(NSTimer*) t;

@end
