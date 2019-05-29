//
//  ViewController.m
//  FlappyBird
//
//  Created by Erdem Meral on 2/26/19.
//  Copyright © 2019 Ibrahim Gokce. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

int width;
int height;
int birdUp;
int randomTopColPosition;
int randomBotColPosition;
int score;
int highScore;

@implementation ViewController
@synthesize top, bot, colBottom, colTop;
@synthesize highScore;
@synthesize startButton;
@synthesize bird;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getScreenWidth];
    top.hidden=YES;
    bot.hidden=YES;
    score=0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)theCols{
    int num = height/2;
    randomTopColPosition=arc4random() % num;
    randomTopColPosition=randomTopColPosition-260;
    randomBotColPosition=randomTopColPosition + 555;
    colTop.center=CGPointMake(width+25, randomTopColPosition);
    colBottom.center=CGPointMake(width+25, randomBotColPosition);
    
    
}

-(void)colMoving{
    colTop.center=CGPointMake(colTop.center.x-1, colTop.center.y);
    colBottom.center=CGPointMake(colBottom.center.x-1, colBottom.center.y);
    if(colBottom.center.x<-28){
        [self theCols];
    }
    if(colBottom.center.x==28){
        [self calculateScore];
    }
    if(CGRectIntersectsRect(bird.frame, colTop.frame)){
        [self gameOver];
    }
    if(CGRectIntersectsRect(bird.frame, colBottom.frame)){
        [self gameOver];
    }
    if(CGRectIntersectsRect(bird.frame, top.frame)){
        [self gameOver];
    }
    if(CGRectIntersectsRect(bird.frame, bot.frame)){
        [self gameOver];
    }
}

-(void)getScreenWidth{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    width = (int) roundf(screenWidth);
    height = (int) roundf(screenHeight);
}

-(void) calculateScore{
    score=score+1;
    highScore.text=[NSString stringWithFormat:@"Score: %d",score];
}

-(void)gameOver{
    //gameover conditions
}

-(void) birdMoving{
    bird.center=CGPointMake(bird.center.x, bird.center.y+birdUp);
    
    
    birdUp=birdUp+5;//bird falls if you dont tap the screen
    
    if(birdUp>15){
        birdUp=15;
    }
    if(birdUp>0){
        bird.image=[UIImage imageNamed:@"bird1.png"];
    }
    else{
        bird.image=[UIImage imageNamed:@"bird2.png"];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    birdUp=-30;
    
}

-(IBAction)startGame:(id)sender{
    startButton.hidden=YES;
    BirdMove=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(birdMoving) userInfo:nil repeats:YES];
    [self theCols];
    ColMove=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(colMoving) userInfo:nil repeats:YES];
    colTop.hidden=NO;
    colBottom.hidden=NO;
    bird.center=CGPointMake(bird.center.x, 250);
    bird.hidden=NO;
    
    score=0;
    highScore.text=[NSString stringWithFormat:@"%d",score];
}


@end
