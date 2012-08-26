//
//  RecordingController.m
//  MyTelephone
//
//  Created by Itai Ram on 8/19/12.
//
//

#import "RecordingController.h"
#import "History.h"

@interface RecordingController ()

@end

@implementation RecordingController

@synthesize playButton;
@synthesize recordButton;
@synthesize stopButton;
@synthesize replaystatus;
@synthesize progressBar;
@synthesize updateTimer;
@synthesize currentTime;
@synthesize duration;
@synthesize sendEmail;
@synthesize saveButton;
@synthesize recordName;
@synthesize listOfURLs;
@synthesize listOfNames;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        listOfURLs = [[NSMutableArray alloc] initWithObjects:nil];
        listOfNames = [[NSMutableArray alloc] initWithObjects:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"Entering Recording Controller");

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"History" style:UIBarButtonItemStylePlain target:self action:@selector(history:)];
    self.navigationItem.rightBarButtonItem = leftButton;

    progressBar = [[UISlider alloc] init];
    progressBar.minimumValue = 0.0;
    progressBar.frame = CGRectMake(50, 300, 200, 20);
    [self.view addSubview:progressBar];

    updateTimer = [[NSTimer alloc] init];
    currentTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 300, 40, 30)];
    currentTime.text = @"0.0";
    currentTime.font = [UIFont boldSystemFontOfSize:12];
    currentTime.backgroundColor = [UIColor clearColor];
    duration = [[UILabel alloc] initWithFrame:CGRectMake(260, 300, 40, 30)];
    duration.text = @"0.0";
    duration.font = [UIFont boldSystemFontOfSize:12];
    duration.backgroundColor = [UIColor clearColor];

    [self.view addSubview:currentTime];
    [self.view addSubview:duration];


 //   UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    recordButton = [[UIButton alloc] init];
    recordButton.frame = CGRectMake(50, 20, 200, 44); // position in the parent view and set the size of the button
    [recordButton setTitle:@"Start Recording" forState:UIControlStateNormal];
    recordButton.titleLabel.backgroundColor = [UIColor blackColor];
    recordButton.backgroundColor = [UIColor blackColor];
    // add targets and actions
    [recordButton addTarget:self action:@selector(recordAudio:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:recordButton];

   // UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton = [[UIButton alloc] init];
    stopButton.frame = CGRectMake(50, 80, 200, 44); // position in the parent view and set the size of the button
    [stopButton setTitle:@"Stop Recording" forState:UIControlStateNormal];
    stopButton.backgroundColor = [UIColor blackColor];
    // add targets and actions
    [stopButton addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:stopButton];

   // UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playButton = [[UIButton alloc] init];
    playButton.frame = CGRectMake(50, 150, 200, 44); // position in the parent view and set the size of the button
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    playButton.backgroundColor = [UIColor blackColor];

    // add targets and actions
    [playButton addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:playButton];

    replaystatus = [[UIButton alloc] init];
    replaystatus.frame = CGRectMake(50, 220, 200, 44); // position in the parent view and set the size of the button
 //   [replaystatus setTitle:@"Start Recording" forState:UIControlStateNormal];
    replaystatus.backgroundColor = [UIColor grayColor];
    // add targets and actions
  //  [replaystatus addTarget:self action:@selector(recordAudio:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:replaystatus];

    sendEmail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendEmail = [[UIButton alloc] init];
    sendEmail.frame = CGRectMake(40, 340, 120, 44); // position in the parent view and set the size of the button
    [sendEmail setTitle:@"Email file" forState:UIControlStateNormal];
    sendEmail.titleLabel.backgroundColor = [UIColor blackColor];
    sendEmail.backgroundColor = [UIColor blackColor];
    // add targets and actions
    [sendEmail addTarget:self action:@selector(sendFile:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:sendEmail];

    saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton = [[UIButton alloc] init];
    saveButton.frame = CGRectMake(180, 340, 120, 44); // position in the parent view and set the size of the button
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    saveButton.titleLabel.backgroundColor = [UIColor blackColor];
    saveButton.backgroundColor = [UIColor blackColor];
    // add targets and actions
    [saveButton addTarget:self action:@selector(saveFile:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:saveButton];


    playButton.enabled = NO;
    stopButton.enabled = NO;
    progressBar.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.wav"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSettings error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
        
    } else {
        [audioRecorder prepareToRecord];
    }
    
    
    
    //LOAD DATA FROM NSUSERDEFAULTS
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *archivedHistoryURLData = [[NSData alloc] init];
    NSData *archivedHistoryRecordNameData = [[NSData alloc] init];
    
    archivedHistoryURLData = [defaults dataForKey:@"historyURL"];
    archivedHistoryRecordNameData = [defaults dataForKey:@"historyRecordName"];
    
//    lastIndexPath = [NSKeyedUnarchiver unarchiveObjectWithData:archivedlastIndexPath];
    
    
    if ([archivedHistoryURLData length] == 0 ){
        
        NSLog(@"archivedSavedData is nil");
    }
    //Unarchieve
    else
    {
        NSMutableArray *savedArray = [[NSMutableArray alloc] init];
        listOfURLs = [NSKeyedUnarchiver unarchiveObjectWithData:archivedHistoryURLData];
        listOfNames = [NSKeyedUnarchiver unarchiveObjectWithData:archivedHistoryRecordNameData];
    }
    
}


-(void) recordAudio:(id)sender
{
    NSLog(@"entering recordAudio");

    if (!audioRecorder.recording)
    {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        sendEmail.enabled = NO;
        [audioRecorder record];
        replaystatus.backgroundColor = [UIColor redColor];

        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSLog(@"paths is %@", paths);
//
//        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
//        NSLog(@"documentsDirectory is %@", documentsDirectory);
//
//        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"Recording"];
//        NSLog(@"dataPath is %@", dataPath);
//
//        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
//        NSString *filePath =[NSString stringWithFormat:@"%@.wav",dataPath];
//
//        NSLog(@"filePath is %@", filePath);

        
        
    }
}
-(void)stop:(id)sender
{
    NSLog(@"entering stop");

    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    sendEmail.enabled = YES;
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
    replaystatus.backgroundColor = [UIColor grayColor];

}
-(void) playAudio:(id)sender
{
    NSLog(@"entering playAudio");

    if (!audioRecorder.recording)
    {
        stopButton.enabled = NO; //was YES?
        recordButton.enabled = NO;
        sendEmail.enabled = NO;
        
//        if (audioPlayer)
//            [audioPlayer release];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioRecorder.url error:&error];
        audioPlayer.delegate = self;
        
        if (error)
        {
            NSLog(@"Error: %@", [error localizedDescription]);   
        }
        else
        {
            [audioPlayer play];
            [self updateViewForPlayerInfo:audioPlayer];
            [self updateViewForPlayerState:audioPlayer];


        }
        
        replaystatus.backgroundColor = [UIColor blueColor];

    }
    
    NSLog(@"audioRecorder URL %@", audioRecorder.url);

}

//Managing elapsed replay time

-(void)updateViewForPlayerInfo:(AVAudioPlayer*)p
{
    NSLog(@"entering updateViewForPlayerInfo");
    NSLog(@"duration is %f", p.duration);
    
	progressBar.maximumValue = p.duration;
    duration.text = [NSString stringWithFormat:@"%.2f", p.duration];
	//volumeSlider.value = p.volume;
}

- (void)updateViewForPlayerState:(AVAudioPlayer *)p
{
	[self updateCurrentTimeForPlayer:p];
    
	if (updateTimer)
		[updateTimer invalidate];
    
	if (p.playing)
	{
	//	[playButton setImage:((p.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
	//	[lvlMeter_in setPlayer:p];
        NSLog(@"entering timer");

		updateTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateCurrentTime) userInfo:p repeats:YES];
	}
	else
	{
	///	[playButton setImage:((p.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
		//[lvlMeter_in setPlayer:nil];
        NSLog(@"timer nil");

		updateTimer = nil;
	}
	
}

- (void)updateCurrentTime
{
  //  NSLog(@"entering updateCurrentTime");

	[self updateCurrentTimeForPlayer:audioPlayer];
}

-(void)updateCurrentTimeForPlayer:(AVAudioPlayer *)p
{
	progressBar.value = p.currentTime;
    currentTime.text = [NSString stringWithFormat:@"%.1f", p.currentTime];
}



-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"audioPlayerDidFinishPlaying");
    replaystatus.backgroundColor = [UIColor grayColor];

    recordButton.enabled = YES;
    stopButton.enabled = NO;
    sendEmail.enabled = YES;
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"audioRecorderDidFinishRecording recorder successfully is %d", flag);

}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

- (IBAction)startRecording:(id)sender
{
    NSLog(@"entering about");
    RecordingController *recordingControllerVC = [[RecordingController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:recordingControllerVC animated:YES];
    
}

-(IBAction) saveFile:(id)sender {
    
    //recordName
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Enter your record name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save" , nil];

    [alert1 setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [alert1 show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    NSString *inputText = [[alertView textFieldAtIndex:0] text];

    if (buttonIndex == 0)
    {
        //cancel clicked ...do your action
        NSLog(@"%@",[[alertView textFieldAtIndex:0]text]);
        NSLog(@"entering 0");


    }
    else if (buttonIndex == 1)
    {

        NSLog(@"entering save");

        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSMutableArray *arr1  = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"historyURL"]];
//        NSMutableArray *arr2  = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"historyRecordName"]];

        NSLog(@"entering historyURL %@", listOfURLs);
        NSLog(@"entering historyRecordName %@", listOfNames);

        [listOfURLs addObject:audioRecorder.url];
        [listOfNames addObject:[[alertView textFieldAtIndex:0]text]];
   //     [listOfNames addObject:@"dfsdfsd"];

        NSLog(@"%@",audioRecorder.url);
        NSLog(@"%@",[[alertView textFieldAtIndex:0]text]);

        NSLog(@"entering historyURL %@", listOfURLs);
        NSLog(@"entering historyRecordName %@", listOfNames);

//        NSLog(@"entering historyURL %@", arr1);
//        NSLog(@"entering historyRecordName %@", arr2);

        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:listOfURLs];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:listOfNames];

        [defaults setObject:data1 forKey:@"historyURL"];
        [defaults setObject:data2 forKey:@"historyRecordName"];

        [defaults synchronize];
    }
}



-(IBAction) sendFile:(id)sender {
    
    
 //   NSString *mp3File = [NSTemporaryDirectory() stringByAppendingPathComponent: @"tmp.mp3"];
  //  NSURL    *fileURL = [[NSURL alloc] initWithString:audioRecorder.url];
   // NSURL *fileURL = [NSURL fileURLWithPath:audioRecorder.url];
    
    //NSURL *fileURL = [NSURL fileURLWithPath:audioRecorder.url];

    NSData *soundFile = [[NSData alloc] initWithContentsOfURL:audioRecorder.url];

    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller addAttachmentData:soundFile mimeType:@"audio/x-caf" fileName:@"myvoice.wav"];

//    [controller addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];

//    [controller setToRecipients:[NSArray arrayWithObject:@"itairam@gmail.com"]];
    [controller setSubject:@"My XXX audio file"];
    [controller setMessageBody:nil isHTML:NO];
    if (controller) [self presentModalViewController:controller animated:YES];

}

//MAIL DELEGATE METHODS
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
            
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email", nil) message:NSLocalizedString(@"SendingFailed", nil)
                                                           delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [alert show];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction) history:(id)sender {
    
    NSLog(@"entering history");
    History *historyVc = [[History alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:historyVc animated:YES];
    
}

@end
