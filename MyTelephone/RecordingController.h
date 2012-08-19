//
//  RecordingController.h
//  MyTelephone
//
//  Created by Itai Ram on 8/19/12.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RecordingController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    IBOutlet UIButton *playButton;
    IBOutlet UIButton *recordButton;
    IBOutlet UIButton *stopButton;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;

-(IBAction) recordAudio:(id)sender;
-(IBAction) playAudio:(id)sender;
-(IBAction) stop:(id)sender;

@end
