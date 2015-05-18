//
//  BSIndicator.m
//  Timer
//
//  Created by Binasystems on 5/18/15.
//  Copyright (c) 2015 Binasystems. All rights reserved.
//

#import "BSIndicator.h"

#define kNumberOfGlasses 8
#define kCounter 5
#define kOutlineColor [UIColor blueColor]
#define kCounterColor [UIColor orangeColor]


@implementation BSIndicator


- (void)drawRect:(CGRect)rect {
    
    // counter BG
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MAX(rect.size.width/2, rect.size.height/2);
    CGFloat arcWidth = 76;
    radius -= arcWidth/2;
    
    CGFloat startAngle = 3 * M_PI / 4;
    CGFloat endAngle = M_PI / 4;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius
                                                          startAngle:startAngle
                                                            endAngle:endAngle
                                                           clockwise:YES];
    bezierPath.lineWidth = arcWidth;
    
    [kCounterColor setStroke];
    [bezierPath stroke];

    // counter indicator
    //1 - first calculate the difference between the two angles
    //ensuring it is positive
    CGFloat angleDifference = 2 * M_PI - startAngle + endAngle;
    
    //then calculate the arc for each single glass
    CGFloat arcLengthPerGlass = angleDifference / self.maxProgress;
    
    //then multiply out by the actual glasses drunk
    CGFloat outlineEndAngle = arcLengthPerGlass * self.progress + startAngle;
    
    //2 - draw the outer arc
    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:rect.size.width/2 - 2.5
                                                          startAngle:startAngle
                                                            endAngle:outlineEndAngle
                                                           clockwise:YES];
    
    //3 - draw the inner arc
    [outlinePath addArcWithCenter:center
                           radius:rect.size.width/2 - arcWidth + 2.5
                       startAngle:outlineEndAngle
                         endAngle:startAngle
                        clockwise:NO];
    
    [outlinePath closePath];
    [kOutlineColor setStroke];
    
    outlinePath.lineWidth = 5.0;
    [outlinePath stroke];
}

- (void)setProgress:(int)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (int)maxProgress
{
    if (_maxProgress == 0) {
        return 100;
    }
    return _maxProgress;
}

@end
