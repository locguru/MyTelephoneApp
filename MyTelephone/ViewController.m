//
//  ViewController.m
//  MyTelephone
//
//  Created by Itai Ram on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <CoreTelephony/CTCallCenter.h>    
#import <CoreTelephony/CTCall.h>   
#import <CoreTelephony/CTCarrier.h>    
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "RecordingController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize consoleLog;
@synthesize myLabel;

// Define a block for sorting calls by their callIDs.
NSComparator sortingBlock = ^(id call1, id call2) {
	NSString *callIdentifier = [call1 callID];
	NSString *call2Identifier = [call2 callID];
	NSComparisonResult result = [callIdentifier compare:call2Identifier 
												options:NSNumericSearch | NSForcedOrderingSearch 
												  range:NSMakeRange(0, [callIdentifier length]) 
												 locale:[NSLocale currentLocale]];
	return result;
};


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:myLabel];
    
//    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    myButton.frame = CGRectMake(20, 20, 200, 44); // position in the parent view and set the size of the button
//    [myButton setTitle:@"Click Me!" forState:UIControlStateNormal];
//    // add targets and actions
//    [myButton addTarget:self action:@selector(nextScreen:) forControlEvents:UIControlEventTouchUpInside];
//    // add to a view
//    [self.view addSubview:myButton];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextScreen:)];
    self.navigationItem.rightBarButtonItem = rightButton;

    
//    UIButton *button0 = [[UIButton alloc] init];
//    button0 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button0 addTarget:self action:@selector(nextScreen:) forControlEvents:UIControlEventTouchUpInside];
//    button0.frame = CGRectMake(100, 100, 100, 100);
//    [button0.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:16.0]];
//    [button0 setTitle:@"Loyal" forState:UIControlStateNormal];
//    [self.view addSubview:button0];

    NSLog(@"fdfsfsfsdf");


//    consoleLog = [[UITextView alloc] init];
//    consoleLog.frame = CGRectMake(0, 0, 320, 480);
//    [self.view addSubview:consoleLog];
//    
//    //CTCarrier Class Parameters 
//    CTCarrier *myCarrier = [[CTCarrier alloc] init];
//    BOOL myAllowVOIP;
//    __block NSString *myCarrierName = [[NSString alloc] init];    
//    NSString *myIsoCountryCode = [[NSString alloc] init];   
//    NSString *myMobileCountryCode = [[NSString alloc] init];
//    NSString *myMobileNetworkCode = [[NSString alloc] init];
//     
//    //Newtowrk info
//    CTTelephonyNetworkInfo *myNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
//    myCarrier = [myNetworkInfo subscriberCellularProvider];
//    myAllowVOIP = myCarrier.allowsVOIP;
//    myCarrierName = myCarrier.carrierName;
//    myIsoCountryCode = myCarrier.isoCountryCode;
//    myMobileCountryCode = myCarrier.mobileCountryCode;
//    myMobileNetworkCode = myCarrier.mobileNetworkCode;
//
//    //CTCallCenter Class
//    CTCallCenter *myCallCenter = [[CTCallCenter alloc] init];
//    
//    //    NSSet *arrayOfCalls = [[NSSet alloc] init];
//    __block NSArray *arrayOfCalls = [[NSArray alloc] init];
//    arrayOfCalls = [myCallCenter.currentCalls allObjects];
//    //arrayOfCalls = [arrayOfCalls sortedArrayUsingComparator:sortingBlock];
//
//    //CTCall Class
//    CTCall *myCall = [[CTCall alloc] init];
//    NSString *myCallID = [[NSString alloc] init];
//    NSString *myCallState = [[NSString alloc] init];
//    myCallID = [myCall callID];
//    myCallState = [myCall callState];
// 
//    
//    // Define callEventHandler block inline
//	myCallCenter.callEventHandler = ^(CTCall* inCTCall) {
//		dispatch_async(dispatch_get_main_queue(), 
//                       ^{
//                           arrayOfCalls = [myCallCenter.currentCalls allObjects];
//                         //  arrayOfCalls = [arrayOfCalls sortedArrayUsingComparator:sortingBlock];
//                           NSLog(@"entering call handler");
//                           NSLog(@"incoming call callID is %@", inCTCall.callID);
//                           NSLog(@"incoming call callState is %@", inCTCall.callState);
//                          // NSLog(@"arrayOfCalls is %@", arrayOfCalls);
//                           NSString * result = [[arrayOfCalls valueForKey:@"description"] componentsJoinedByString:@""];
//
//                           
//                           //LOG TO SCREEN
//                           NSString *message1 = [NSString stringWithFormat:@"\nYour carrier is %@\n VOIP enabled: %d\n ISO country code is: %@\n Mobile Country code: %@`\n Mobile Network code: %@\n", myCarrierName, myAllowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode];
//                           
//                           NSString *message2 = [NSString stringWithFormat:@"\nList of calls in progress: %@\n", arrayOfCalls];
//                           
//                           NSString *message3 = [NSString stringWithFormat:@"\nCall ID is: %@;\n Call state is %@",  inCTCall.callID, inCTCall.callState];
//                           NSString *message4 = [NSString stringWithFormat:@"incoming call is %@", inCTCall.callState];
//                           
//                           
////                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message1];
////                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message2];
////                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
////                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message4];
//
//    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"title" message:message4 delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil , nil];
//    
//    [alert1 show];
//
//                       });
//		
//		// Enable this NSLog inspect current call center.
//		// NSLog(@"%s, self: <%@>, callCenter: <%@>", __PRETTY_FUNCTION__, self, self.callCenter);
//	};
//    
//    // Define subscriberCellularProviderDidUpdateNotifier block inline
//	myNetworkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier* inCTCarrier) {
//		dispatch_async(dispatch_get_main_queue(), ^{
//			myCarrierName = inCTCarrier.carrierName;
//            NSLog(@"subscriberCellularProviderDidUpdateNotifier");
//
//		});
//	};
//    
//    
//    //LOG TO SCREEN
//    NSString *message1 = [NSString stringWithFormat:@"\nYour carrier is %@\n VOIP enabled: %d\n ISO country code is: %@\n Mobile Country code: %@`\n Mobile Network code: %@\n", myCarrierName, myAllowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode];
//
//    CTCall *tempCall = [[CTCall alloc] init];
//
//    tempCall = [arrayOfCalls objectAtIndex:0];
//    
//    NSString *message2 = [NSString stringWithFormat:@"\nList of calls in progress: %@\n", arrayOfCalls];
//    NSString *message5 = [NSString stringWithFormat:@"\nCall ID of first call in array of calls: %@\n", tempCall.callID];
//    NSString *message6 = [NSString stringWithFormat:@"\nCall State of first call in array of calls: %@\n", tempCall.callState];
//
//    
// //   NSString *message3 = [NSString stringWithFormat:@"\nCall ID is: %@;\n Call state is %@",  inCTCall.callID, inCTCall.callState];
////    NSString *message4 = [NSString stringWithFormat:@"incoming call is %@", inCTCall.callState];
//    
//    
//    consoleLog.text = [self.consoleLog.text stringByAppendingString:message1];
//    consoleLog.text = [self.consoleLog.text stringByAppendingString:message2];
////    consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
////    consoleLog.text = [self.consoleLog.text stringByAppendingString:message4];
//    consoleLog.text = [self.consoleLog.text stringByAppendingString:message5];
//    consoleLog.text = [self.consoleLog.text stringByAppendingString:message6];
//
//    //LOG TO DEBUGGER
//    NSLog(@"\nYour carrier is %@;\n VOIP enabled: %d;\n ISO country code is: %@;\n Mobile Country code: %@;\n Mobile Network code: %@\n", myCarrierName, myAllowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode);
//    NSLog(@"\nList of calls in progress: %@", arrayOfCalls);
//    NSLog(@"\nCall ID is: %@;\n Call state is %@", myCallID, myCallState);
//
////    
////    //LOG TO SCREEN
////    NSString *message1 = [NSString stringWithFormat:@"\nYour carrier is %@\n VOIP enabled: %d\n ISO country code is: %@\n Mobile Country code: %@`\n Mobile Network code: %@\n", myCarrierName, allowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode];
////    
////    NSString *message2 = [NSString stringWithFormat:@"\nList of calls in progress: %@\n", arrayOfCalls];
////
////    NSString *message3 = [NSString stringWithFormat:@"\nCall ID is: %@;\n Call state is %@",  myCallID, myCallState];
////
////    consoleLog.text = [self.consoleLog.text stringByAppendingString:message1];
////    consoleLog.text = [self.consoleLog.text stringByAppendingString:message2];
////    consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
//
//	
//	[consoleLog scrollRangeToVisible:NSMakeRange([consoleLog.text length], 0)];
//    
//    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self selector: @selector(callAfterSixtySecond:) userInfo: nil repeats: YES];
}

- (void)viewDidAppear:(BOOL)animated
{

    NSLog(@"entering viewDidAppear");
    
    [super viewDidAppear:animated];

    [self refreshCalls];
}

-(void) refreshCalls {
    
    consoleLog = [[UITextView alloc] init];
    consoleLog.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:consoleLog];
    
    //CTCarrier Class Parameters
    CTCarrier *myCarrier = [[CTCarrier alloc] init];
    BOOL myAllowVOIP;
    __block NSString *myCarrierName = [[NSString alloc] init];
    NSString *myIsoCountryCode = [[NSString alloc] init];
    NSString *myMobileCountryCode = [[NSString alloc] init];
    NSString *myMobileNetworkCode = [[NSString alloc] init];
    
    //Newtowrk info
    CTTelephonyNetworkInfo *myNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    myCarrier = [myNetworkInfo subscriberCellularProvider];
    myAllowVOIP = myCarrier.allowsVOIP;
    myCarrierName = myCarrier.carrierName;
    myIsoCountryCode = myCarrier.isoCountryCode;
    myMobileCountryCode = myCarrier.mobileCountryCode;
    myMobileNetworkCode = myCarrier.mobileNetworkCode;
    
    //CTCallCenter Class
    CTCallCenter *myCallCenter = [[CTCallCenter alloc] init];
    
    //    NSSet *arrayOfCalls = [[NSSet alloc] init];
    __block NSArray *arrayOfCalls = [[NSArray alloc] init];
    arrayOfCalls = [myCallCenter.currentCalls allObjects];
    //arrayOfCalls = [arrayOfCalls sortedArrayUsingComparator:sortingBlock];
    
    //CTCall Class
    CTCall *myCall = [[CTCall alloc] init];
    NSString *myCallID = [[NSString alloc] init];
    NSString *myCallState = [[NSString alloc] init];
    myCallID = [myCall callID];
    myCallState = [myCall callState];
    
    
    // Define callEventHandler block inline
	myCallCenter.callEventHandler = ^(CTCall* inCTCall) {
		dispatch_async(dispatch_get_main_queue(),
                       ^{
                           arrayOfCalls = [myCallCenter.currentCalls allObjects];
                           //  arrayOfCalls = [arrayOfCalls sortedArrayUsingComparator:sortingBlock];
                           NSLog(@"entering call handler");
                           NSLog(@"incoming call callID is %@", inCTCall.callID);
                           NSLog(@"incoming call callState is %@", inCTCall.callState);
                           // NSLog(@"arrayOfCalls is %@", arrayOfCalls);
                           NSString * result = [[arrayOfCalls valueForKey:@"description"] componentsJoinedByString:@""];
                           
                           
                           //LOG TO SCREEN
                           NSString *message1 = [NSString stringWithFormat:@"\nYour carrier is %@\n VOIP enabled: %d\n ISO country code is: %@\n Mobile Country code: %@`\n Mobile Network code: %@\n", myCarrierName, myAllowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode];
                           
                           NSString *message2 = [NSString stringWithFormat:@"\nList of calls in progress: %@\n", arrayOfCalls];
                           
                           NSString *message3 = [NSString stringWithFormat:@"\nCall ID is: %@;\n Call state is %@",  inCTCall.callID, inCTCall.callState];
                           NSString *message4 = [NSString stringWithFormat:@"incoming call is %@", inCTCall.callState];
                           
                           
                           //                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message1];
                           //                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message2];
                           //                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
                           //                           consoleLog.text = [self.consoleLog.text stringByAppendingString:message4];
                           
                           UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"title" message:message3 delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil , nil];
                           
                           [alert1 show];
                           
                       });
		
		// Enable this NSLog inspect current call center.
		// NSLog(@"%s, self: <%@>, callCenter: <%@>", __PRETTY_FUNCTION__, self, self.callCenter);
	};
    
    // Define subscriberCellularProviderDidUpdateNotifier block inline
	myNetworkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier* inCTCarrier) {
		dispatch_async(dispatch_get_main_queue(), ^{
			myCarrierName = inCTCarrier.carrierName;
            NSLog(@"subscriberCellularProviderDidUpdateNotifier");
            
		});
	};
    
    
    //LOG TO SCREEN
    NSString *message1 = [NSString stringWithFormat:@"\nYour carrier is %@\n VOIP enabled: %d\n ISO country code is: %@\n Mobile Country code: %@`\n Mobile Network code: %@\n", myCarrierName, myAllowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode];
    
    CTCall *tempCall = [[CTCall alloc] init];
    
    tempCall = [arrayOfCalls objectAtIndex:0];
    
    NSString *message2 = [NSString stringWithFormat:@"\nList of calls in progress: %@\n", arrayOfCalls];
    NSString *message5 = [NSString stringWithFormat:@"\nCall ID of first call in array of calls: %@\n", tempCall.callID];
    NSString *message6 = [NSString stringWithFormat:@"\nCall State of first call in array of calls: %@\n", tempCall.callState];
    
    
    //   NSString *message3 = [NSString stringWithFormat:@"\nCall ID is: %@;\n Call state is %@",  inCTCall.callID, inCTCall.callState];
    //    NSString *message4 = [NSString stringWithFormat:@"incoming call is %@", inCTCall.callState];
    
    
    consoleLog.text = [self.consoleLog.text stringByAppendingString:message1];
    consoleLog.text = [self.consoleLog.text stringByAppendingString:message2];
    //    consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
    //    consoleLog.text = [self.consoleLog.text stringByAppendingString:message4];
    consoleLog.text = [self.consoleLog.text stringByAppendingString:message5];
    consoleLog.text = [self.consoleLog.text stringByAppendingString:message6];
    
    //LOG TO DEBUGGER
    NSLog(@"\nYour carrier is %@;\n VOIP enabled: %d;\n ISO country code is: %@;\n Mobile Country code: %@;\n Mobile Network code: %@\n", myCarrierName, myAllowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode);
    NSLog(@"\nList of calls in progress: %@", arrayOfCalls);
    NSLog(@"\nCall ID is: %@;\n Call state is %@", myCallID, myCallState);
    
    //
    //    //LOG TO SCREEN
    //    NSString *message1 = [NSString stringWithFormat:@"\nYour carrier is %@\n VOIP enabled: %d\n ISO country code is: %@\n Mobile Country code: %@`\n Mobile Network code: %@\n", myCarrierName, allowVOIP, myIsoCountryCode, myMobileCountryCode, myMobileNetworkCode];
    //
    //    NSString *message2 = [NSString stringWithFormat:@"\nList of calls in progress: %@\n", arrayOfCalls];
    //
    //    NSString *message3 = [NSString stringWithFormat:@"\nCall ID is: %@;\n Call state is %@",  myCallID, myCallState];
    //
    //    consoleLog.text = [self.consoleLog.text stringByAppendingString:message1];
    //    consoleLog.text = [self.consoleLog.text stringByAppendingString:message2];
    //    consoleLog.text = [self.consoleLog.text stringByAppendingString:message3];
    

	NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    NSLog(@"User's current time in their preference format:%@",currentTime);
    
   UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"TIME" message:currentTime delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil , nil];

 //  [alert1 show];

    consoleLog.text = [self.consoleLog.text stringByAppendingString:currentTime];
    
    
    self.myLabel.text = currentTime;
  //  [self.view addSubview:myLabel];
    
    
    
    
    
    
	[consoleLog scrollRangeToVisible:NSMakeRange([consoleLog.text length], 0)];
    
    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 3.0 target: self selector: @selector(callAfterSixtySecond:) userInfo: nil repeats: YES];
}


- (IBAction)nextScreen:(id)sender
{
    NSLog(@"entering about");
    RecordingController *recordingControllerVC = [[RecordingController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:recordingControllerVC animated:YES];
    
}


-(void) callAfterSixtySecond:(NSTimer*) t
{
    NSLog(@"red");
}

@end
