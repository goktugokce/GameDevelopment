//
//  TileView.h
//  2048
//
//  Created by Erdem Meral on 2/11/19.
//  Copyright © 2019 Ibrahim Gokce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct{
    int xPos;
    int yPos;
}tilePosition;

@interface TileView : UIView

@property(nonatomic)tilePosition matrixPosition;
@property(nonatomic)int number;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic)BOOL hasCombined;

-(id)initWithFrame:(CGRect)frame atMatrixPosition:(int)x andY:(int)y;
-(void)actualizeText;

@end
