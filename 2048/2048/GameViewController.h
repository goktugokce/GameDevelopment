//
//  GameViewController.h
//  2048
//
//  Created by Erdem Meral on 2/11/19.
//  Copyright © 2019 Ibrahim Gokce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController{
    int score;
}
@property(nonatomic,strong)IBOutlet UILabel *scoreLabel;
@property(nonatomic,strong)IBOutlet UIView *gameView;
@property(nonatomic,strong)NSMutableArray *tileArray;

@end
