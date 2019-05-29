//
//  TileView.m
//  2048
//
//  Created by Erdem Meral on 2/11/19.
//  Copyright © 2019 Ibrahim Gokce. All rights reserved.
//

#import "TileView.h"

@implementation TileView
@synthesize matrixPosition,numberLabel,number,hasCombined;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame atMatrixPosition:(int)x andY:(int)y{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0]];
        numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 50, 70)];
        [numberLabel setTextColor:[UIColor blackColor]];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        [numberLabel setFont:[UIFont fontWithName:@"Chalkboard" size:20.0f]];
        
        int randomStart = arc4random() % 2;
        if(randomStart == 0){
            self.number = 2;
        }
        else{
            self.number = 4;
        }
        [numberLabel setText:[NSString stringWithFormat:@"%d",self.number]];
        
        
        
        matrixPosition.xPos = x;
        matrixPosition.yPos = y;
        
        [self addSubview:numberLabel];
    }
    return self;
}

-(void)actualizeText{
    [numberLabel setText:[NSString stringWithFormat:@"%d",self.number]];
}

@end
