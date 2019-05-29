//
//  GameViewController.m
//  2048
//
//  Created by Erdem Meral on 2/11/19.
//  Copyright © 2019 Ibrahim Gokce. All rights reserved.
//

#import "GameViewController.h"
#import "TileView.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize gameView, tileArray, scoreLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    score = 0;
    self.scoreLabel.layer.cornerRadius = 10.0;
    [self updateScoreLabel];
    self.tileArray = [[NSMutableArray alloc]init];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftAction)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightAction)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUpAction)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [[self view] addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:swipeDown];
    [self spawnTile];
}

-(void)updateScoreLabel{
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",score]];
    
}

-(BOOL)proofBounds:(TileView *)tv inDirection:(int)direction{
    switch (direction) {
        case 0:
            //right
            if(tv.matrixPosition.xPos == 3){
                return false;
            }
            break;
        case 1:
            //down
            if(tv.matrixPosition.yPos == 3){
                return false;
            }
            break;
        case 2:
            //left
            if(tv.matrixPosition.xPos == 0){
                return false;
            }
            break;
        case 3:
            //up
            if(tv.matrixPosition.yPos == 0){
                return false;
            }
            break;
            
        default:
            break;
    }
    return true;
}

-(void)removeTileFromView:(TileView *)tv{
    [tv removeFromSuperview];
    [tileArray removeObject:tv];
}

-(BOOL)tryToMove:(TileView *)tv toX:(int)x andY:(int)y{
    UIColor *color_4 = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1.0];
    UIColor *color_8 = [UIColor colorWithRed:238.0/255.0 green:200.0/255.0 blue:145.0/255.0 alpha:1.0];
    UIColor *color_16 = [UIColor colorWithRed:255.0/255.0 green:165.0/255.0 blue:79.0/255.0 alpha:1.0];
    UIColor *color_32 = [UIColor colorWithRed:255.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:1.0];
    UIColor *color_64 = [UIColor colorWithRed:238.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1.0];
    UIColor *color_128 = [UIColor colorWithRed:240.0/255.0 green:230.0/255.0 blue:140.0/255.0 alpha:1.0];
    UIColor *color_256 = [UIColor colorWithRed:255.0/255.0 green:246.0/255.0 blue:143.0/255.0 alpha:1.0];
    UIColor *color_512 = [UIColor colorWithRed:255.0/255.0 green:246.0/255.0 blue:143.0/255.0 alpha:1.0];
    UIColor *color_1024 = [UIColor colorWithRed:238.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1.0];
    
    
    for (int i = 0; i<tileArray.count; i++) {
        TileView *tile = [[TileView alloc]init];
        tile = [tileArray objectAtIndex:i];
        if(tile.matrixPosition.xPos == x && tile.matrixPosition.yPos == y){
            NSLog(@"Detected!");
            if(tile.number != tv.number)
                return false;
            else{
                if(tv.hasCombined == true || tile.hasCombined==true){
                    return false;
                }
                else{
                    [self performSelector:@selector(removeTileFromView:) withObject:tile afterDelay:0.2];
                    [tv setNumber:tv.number+tile.number];
                    [tv actualizeText];
                    [tile setHasCombined:true];
                    [tv setHasCombined:true];
                    score += tile.number;
                    [self updateScoreLabel];
                    
                    switch (tv.number) {
                        case 4:{
                            tv.backgroundColor = color_4;
                            break;
                        }
                        case 8:{
                            tv.backgroundColor = color_8;
                            break;
                        }
                        case 16:{
                            tv.backgroundColor = color_16;
                            break;
                        }
                        case 32:{
                            tv.backgroundColor = color_32;
                            break;
                        }
                        case 64:{
                            tv.backgroundColor = color_64;
                            break;
                        }
                        case 128:{
                            tv.backgroundColor = color_128;
                            break;
                        }
                        case 256:{
                            tv.backgroundColor = color_256;
                            break;
                        }
                        case 512:{
                            tv.backgroundColor = color_512;
                            break;
                        }
                        case 1024:{
                            tv.backgroundColor = color_1024;
                            break;
                        }
                        case 2048:{
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations" message:@"You Reached 2048" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *OkButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                            [alert addAction:OkButton];
                            [self presentViewController:alert animated:YES completion:nil];
                            break;
                        }
                            
                        default:
                            tv.backgroundColor = color_1024;
                            break;
                    }
                }
            }
        }
    }
    return true;
}

-(void)resetCombinations{
    for(int i = 0; i<tileArray.count; i++){
        TileView *tv = [tileArray objectAtIndex:i];
        [tv setHasCombined:NO];
    }
}

-(void)sortFromLeft{
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for(int x = 0; x < 4; x++){
        for(int y = 0; y < 4; y++){
            for(int i = 0;  i < tileArray.count; i++){
                TileView *tv = [[TileView alloc]init];
                tv = [tileArray objectAtIndex:i];
                if(tv.matrixPosition.xPos==x && tv.matrixPosition.yPos==y){
                    [tmpArray addObject:tv];
                }
            }
        }
    }
    [tileArray removeAllObjects];
    tileArray = [NSMutableArray arrayWithArray:tmpArray];
}

-(void)sortFromRight{
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for(int x = 3; x >= 0; x--){
        for(int y = 0; y < 4; y++){
            for(int i = 0;  i < tileArray.count; i++){
                TileView *tv = [[TileView alloc]init];
                tv = [tileArray objectAtIndex:i];
                if(tv.matrixPosition.xPos==x && tv.matrixPosition.yPos==y){
                    [tmpArray addObject:tv];
                }
            }
        }
    }
    [tileArray removeAllObjects];
    tileArray = [NSMutableArray arrayWithArray:tmpArray];
}

-(void)sortFromBottom{
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for(int y = 3; y >= 0; y--){
        for(int x = 0; x < 4; x++){
            for(int i = 0;  i < tileArray.count; i++){
                TileView *tv = [[TileView alloc]init];
                tv = [tileArray objectAtIndex:i];
                if(tv.matrixPosition.xPos==x && tv.matrixPosition.yPos==y){
                    [tmpArray addObject:tv];
                }
            }
        }
    }
    [tileArray removeAllObjects];
    tileArray = [NSMutableArray arrayWithArray:tmpArray];
}

-(void)sortFromTop{
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for(int y = 0 ; y < 4; y++){
        for(int x = 0; x < 4; x++){
            for(int i = 0;  i < tileArray.count; i++){
                TileView *tv = [[TileView alloc]init];
                tv = [tileArray objectAtIndex:i];
                if(tv.matrixPosition.xPos==x && tv.matrixPosition.yPos==y){
                    [tmpArray addObject:tv];
                }
            }
        }
    }
    [tileArray removeAllObjects];
    tileArray = [NSMutableArray arrayWithArray:tmpArray];
}

-(void)swipeLeftAction{
    [self sortFromLeft];
    for (int i = 0; i < tileArray.count; i++) {
        TileView *t = [tileArray objectAtIndex:i];
        tilePosition newPos;
        tilePosition oldPos = t.matrixPosition;
        while ([self proofBounds:t inDirection:2]) {
            if ([self tryToMove:t toX:t.matrixPosition.xPos - 1 andY:t.matrixPosition.yPos] == true) {
            newPos = t.matrixPosition;
            newPos.xPos = t.matrixPosition.xPos - 1;
            [t setMatrixPosition:newPos];
            NSLog(@"X:%d Y:%d",t.matrixPosition.xPos,t.matrixPosition.yPos);
            }
            else{
                break;
            }
        }
        int diff = oldPos.xPos - t.matrixPosition.xPos;
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        t.center = CGPointMake(t.center.x-(diff*80), t.center.y);
        [UIView commitAnimations];
    }
    [self performSelector:@selector(spawnTile) withObject:nil afterDelay:0.3];
    [self resetCombinations];
}


-(void)swipeRightAction{
    [self sortFromRight];
    for (int i = 0; i < tileArray.count; i++) {
        TileView *t = [tileArray objectAtIndex:i];
        tilePosition newPos;
        tilePosition oldPos = t.matrixPosition;
        while ([self proofBounds:t inDirection:0]) {
            if ([self tryToMove:t toX:t.matrixPosition.xPos + 1 andY:t.matrixPosition.yPos] == true){
            newPos = t.matrixPosition;
            newPos.xPos = t.matrixPosition.xPos + 1;
            [t setMatrixPosition:newPos];
            NSLog(@"X:%d Y:%d",t.matrixPosition.xPos,t.matrixPosition.yPos);
            }
            else{
                break;
            }
        }
        int diff = oldPos.xPos - t.matrixPosition.xPos;
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        t.center = CGPointMake(t.center.x-(diff*80), t.center.y);
        [UIView commitAnimations];
    }
    [self performSelector:@selector(spawnTile) withObject:nil afterDelay:0.3];
    [self resetCombinations];
}

-(void)swipeUpAction{
    [self sortFromTop];
    for (int i = 0; i < tileArray.count; i++) {
        TileView *t = [tileArray objectAtIndex:i];
        tilePosition newPos;
        tilePosition oldPos = t.matrixPosition;
        while ([self proofBounds:t inDirection:3]) {
            if ([self tryToMove:t toX:t.matrixPosition.xPos andY:t.matrixPosition.yPos-1] == true){
            newPos = t.matrixPosition;
            newPos.yPos = t.matrixPosition.yPos - 1;
            [t setMatrixPosition:newPos];
            NSLog(@"X:%d Y:%d",t.matrixPosition.xPos,t.matrixPosition.yPos);
            }
            else{
                break;
            }
        }
        int diff = oldPos.yPos - t.matrixPosition.yPos;
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        t.center = CGPointMake(t.center.x, t.center.y - (diff*80));
        [UIView commitAnimations];
    }
    [self performSelector:@selector(spawnTile) withObject:nil afterDelay:0.3];
    [self resetCombinations];
}

-(void)swipeDownAction{
    [self sortFromBottom];
    for (int i = 0; i < tileArray.count; i++) {
        TileView *t = [tileArray objectAtIndex:i];
        tilePosition newPos;
        tilePosition oldPos = t.matrixPosition;
        while ([self proofBounds:t inDirection:1]) {
            if ([self tryToMove:t toX:t.matrixPosition.xPos andY:t.matrixPosition.yPos+1] == true){
            newPos = t.matrixPosition;
            newPos.yPos = t.matrixPosition.yPos + 1;
            [t setMatrixPosition:newPos];
            NSLog(@"X:%d Y:%d",t.matrixPosition.xPos,t.matrixPosition.yPos);
            }
            else{
                break;
            }
        }
        int diff = oldPos.yPos - t.matrixPosition.yPos;
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        t.center = CGPointMake(t.center.x, t.center.y-(diff*80));
        [UIView commitAnimations];
    }
    [self performSelector:@selector(spawnTile) withObject:nil afterDelay:0.3];
    [self resetCombinations];
}

-(BOOL)isFree:(int)x andY:(int)y{
    for(int i = 0 ; i < tileArray.count; i++){
        TileView *proofTile = [tileArray objectAtIndex:i];
        if (x == proofTile.matrixPosition.xPos && y == proofTile.matrixPosition.yPos) {
            return false;
        }
    }
    return true;
}

-(void) spawnTile{
    int randX = (arc4random() % 4);
    int randY = (arc4random() % 4);
    
    TileView *startTile = [[TileView alloc]initWithFrame:CGRectMake((randX*80)+5, (randY*80)+5, 70, 70) atMatrixPosition:randX andY:randY];
    if([self isFree:randX andY:randY] == true){
        [self.gameView addSubview:startTile];
        [self.tileArray addObject:startTile];
    }
    else{
        [self spawnTile];
    }
    
}

-(IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)newGame:(id)sender{
    for(id child in [self.gameView subviews]){
        if([child isMemberOfClass:[TileView class]]){
            [child removeFromSuperview];
        }
    }
    [self.tileArray removeAllObjects];
    score = 0;
    [self updateScoreLabel];
    [self spawnTile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
