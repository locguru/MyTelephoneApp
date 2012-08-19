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

@synthesize playButton;
@synthesize recordButton;
@synthesize stopButton;

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
    
    NSLog(@"Entering Recording Controller");

 //   UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    recordButton = [[UIButton alloc] init];
    recordButton.frame = CGRectMake(50, 20, 200, 44); // position in the parent view and set the size of the button
    [recordButton setTitle:@"Start Recording" forState:UIControlStateNormal];
    recordButton.backgroundColor = [UIColor yellowColor];
    // add targets and actions
    [recordButton addTarget:self action:@selector(recordAudio:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:recordButton];

   // UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton = [[UIButton alloc] init];
    stopButton.frame = CGRectMake(50, 80, 200, 44); // position in the parent view and set the size of the button
    [stopButton setTitle:@"Stop Recording" forState:UIControlStateNormal];
    stopButton.backgroundColor = [UIColor yellowColor];
    // add targets and actions
    [stopButton addTarget:self action:@selector(stop:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:stopButton];

   // UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playButton = [[UIButton alloc] init];
    playButton.frame = CGRectMake(50, 150, 200, 44); // position in the parent view and set the size of the button
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    playButton.backgroundColor = [UIColor yellowColor];

    // add targets and actions
    [playButton addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
    [self.view addSubview:playButton];

    
    playButton.enabled = NO;
    stopButton.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];
    
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
    
}

-(void) recordAudio:(id)sender
{
    NSLog(@"entering recordAudio");

    if (!audioRecorder.recording)
    {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        [audioRecorder record];
    }
}
-(void)stop:(id)sender
{
    NSLog(@"entering stop");

    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}
-(void) playAudio:(id)sender
{
    NSLog(@"entering playAudio");

    if (!audioRecorder.recording)
    {
        stopButton.enabled = YES;
        recordButton.enabled = NO;
        
//        if (audioPlayer)
//            [audioPlayer release];
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:audioRecorder.url
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"audioPlayerDidFinishPlaying");

    recordButton.enabled = YES;
    stopButton.enabled = NO;    
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


@end
