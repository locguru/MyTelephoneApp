//
//  ViewController.h
//  MyTelephone
//
//  Created by Itai Ram on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    UITextView			*consoleLog;
    UILabel *myLabel;
}

@property (nonatomic, retain) IBOutlet UITextView *consoleLog;
@property (nonatomic, retain) IBOutlet UILabel *myLabel;

-(void) refreshCalls;


@end
