//
//  ViewController.h
//  Timer
//
//  Created by Binasystems on 5/15/15.
//  Copyright (c) 2015 Binasystems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSIndicator.h"

typedef NS_ENUM(NSUInteger, BSActionType) {
    BSActionTypeStartWorkTimer,
    BSActionTypeStopWorkTimer,
    BSActionTypeStartPauseTimer,
    BSActionTypeStopPauseTimer,
};


@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet BSIndicator *well;

- (IBAction)startButtonAction:(id)sender;
- (IBAction)stopButtonAction:(id)sender;
- (IBAction)pauseButtonAction:(id)sender;

- (void)performAction:(BSActionType)action;


@property (strong, nonatomic) IBOutlet UILabel *workTimeCounterLabel;
//@property (strong, nonatomic) IBOutlet UILabel *pauseTimeCounterLabel;

@end
