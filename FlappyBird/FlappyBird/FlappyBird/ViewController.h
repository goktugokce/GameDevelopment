//
//  ViewController.h
//  FlappyBird
//
//  Created by Erdem Meral on 2/26/19.
//  Copyright © 2019 Ibrahim Gokce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSTimer * BirdMove;
    NSTimer * ColMove;
}

@property (weak, nonatomic) IBOutlet UIImageView *colTop;

@property (weak, nonatomic) IBOutlet UIImageView *top;

@property (weak, nonatomic) IBOutlet UIImageView *colBottom;

@property (weak, nonatomic) IBOutlet UIImageView *bird;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)startGame:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *highScore;

@property (weak, nonatomic) IBOutlet UIImageView *bot;

@end
