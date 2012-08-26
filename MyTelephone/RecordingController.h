//
//  RecordingController.h
//  MyTelephone
//
//  Created by Itai Ram on 8/19/12.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>


@interface RecordingController : UIViewController <UIAlertViewDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, MFMailComposeViewControllerDelegate> {
    
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    IBOutlet UIButton *playButton;
    IBOutlet UIButton *recordButton;
    IBOutlet UIButton *stopButton;
    IBOutlet UIButton *replaystatus;
    IBOutlet UISlider *progressBar;
    IBOutlet UIButton *sendEmail;
    IBOutlet UIButton *saveButton;

	NSTimer *updateTimer;
	IBOutlet UILabel *currentTime;
	IBOutlet UILabel *duration;
    
    IBOutlet UITextField *recordName;
    NSMutableArray *listOfURLs;
    NSMutableArray *listOfNames;


}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
@property (nonatomic, retain) IBOutlet UIButton *replaystatus;
@property (nonatomic, retain) IBOutlet UISlider *progressBar;
@property (nonatomic, retain) IBOutlet UIButton *sendEmail;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) NSTimer *updateTimer;
@property (nonatomic, retain) IBOutlet UILabel *currentTime;
@property (nonatomic, retain) IBOutlet UILabel *duration;
@property (nonatomic, retain) IBOutlet UITextField *recordName;
@property (nonatomic, retain) NSMutableArray *listOfURLs;
@property (nonatomic, retain) NSMutableArray *listOfNames;

-(IBAction) recordAudio:(id)sender;
-(IBAction) playAudio:(id)sender;
-(IBAction) stop:(id)sender;
-(IBAction) sendFile:(id)sender;
-(IBAction) saveFile:(id)sender;
-(IBAction) history:(id)sender;

-(void)updateViewForPlayerInfo:(AVAudioPlayer*)p;
- (void)updateViewForPlayerState:(AVAudioPlayer *)p;
-(void)updateCurrentTimeForPlayer:(AVAudioPlayer *)p;

@end
