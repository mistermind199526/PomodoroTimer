//
//  ViewController.m
//  Timer
//
//  Created by Binasystems on 5/15/15.
//  Copyright (c) 2015 Binasystems. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>


@interface ViewController ()

{
    AVAudioPlayer *_audioPlayer;
}
@property (strong, nonatomic) NSTimer *workTimer;
@property (strong, nonatomic) NSTimer *pauseTimer;


@property int workTimerSecondsCounter;
@property int pauseTimerSecondsCounter;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/timati.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
   
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

- (IBAction)startButtonAction:(id)sender
{
    [self performAction:BSActionTypeStartWorkTimer];
}

- (void)performAction:(BSActionType)action
{
    switch (action) {
        
        case BSActionTypeStartWorkTimer:
        case BSActionTypeStartPauseTimer: {
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(timerTick:)
                                                            userInfo:nil
                                                             repeats:YES];;
            
            if (action == BSActionTypeStartWorkTimer) {
                self.workTimerSecondsCounter = 3;
                self.workTimer = timer;
                  [self.well setMaxProgress:self.workTimerSecondsCounter];
            } else {
                self.pauseTimerSecondsCounter = 300;
                self.pauseTimer = timer;
                [self.well setMaxProgress:self.pauseTimerSecondsCounter];
            }
            
        }
            break;
        
        case BSActionTypeStopPauseTimer:
            break;
        
        default:
            break;
    }
}



#pragma mark - Internals
- (void)timerTick:(id)sender
{
    if ([sender isEqual:self.workTimer]) {
        self.workTimerSecondsCounter -= 1;
        
        int minuts = self.workTimerSecondsCounter/60;
        int seconds = self.workTimerSecondsCounter-(minuts*60);
        
        [self.well setProgress:self.workTimerSecondsCounter];
        NSString *timerOutputString = [NSString stringWithFormat:@"%2d:%.2d",minuts,seconds];
        self.workTimeCounterLabel.text=timerOutputString;
        self.workTimeCounterLabel.textColor = [UIColor redColor];
        
        
        
        if (self.workTimerSecondsCounter == 0) {
            [self.workTimer invalidate];
            _workTimer = nil;
            
            [self performAction:BSActionTypeStartPauseTimer];
        }
    } else if([sender isEqual:self.pauseTimer]) {
        self.pauseTimerSecondsCounter -= 1;
        [self.well setProgress:self.pauseTimerSecondsCounter];
        
        int minuts = self.pauseTimerSecondsCounter/60;
        int seconds = self.pauseTimerSecondsCounter-(minuts*60);
        
        
        NSString *timerOutputString = [NSString stringWithFormat:@"%2d:%.2d",minuts,seconds];
        self.workTimeCounterLabel.text=timerOutputString;
        self.workTimeCounterLabel.textColor = [UIColor greenColor];
        [_audioPlayer play];
        
        if (self.pauseTimerSecondsCounter == 0) {
            [self.pauseTimer invalidate];
            _pauseTimer = nil;
            [_audioPlayer stop];
           
            [self performAction:BSActionTypeStartWorkTimer];
        }
    }
    

}



@end
