//
//  RecordingController.m
//  MyTelephone
//
//  Created by Itai Ram on 8/19/12.
//
//

#import "RecordingController.h"

@interface RecordingController ()

@end

@implementation RecordingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(50, 20, 200, 44); // position in the parent view and set the size of the button
    [myButton setTitle:@"Start Recording" forState:UIControlStateNormal];
    // add targets and actions
    [myButton addTarget:self action:@selector(startRecording:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:myButton];

}

- (IBAction)startRecording:(id)sender
{
    NSLog(@"entering about");
    RecordingController *recordingControllerVC = [[RecordingController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:recordingControllerVC animated:YES];
    
}


@end
