//
//  ViewController.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//
#define GRIDSIZE 3
#import "ViewController.h"
#import "BoardCell.h"
#import "GameController.h"
#import "Player.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, GameControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *player1name;
@property (nonatomic, weak) IBOutlet UITextField *player2name;
//@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *player1Score;
@property (nonatomic, weak) IBOutlet UILabel *player2Score;
@property (nonatomic, weak) IBOutlet UILabel *roundLabel;

@property (nonatomic, weak) IBOutlet UICollectionView * gameBoard;

@property (nonatomic, strong) UIImage * xIcon;
@property (nonatomic, strong) UIImage * oIcon;

@property (nonatomic, strong) IBOutlet UIImageView * turnIcon;
@property (nonatomic, strong) IBOutlet UIImageView * player1icon;
@property (nonatomic, strong) IBOutlet UIImageView * player2icon;

@property (nonatomic, strong) GameController * game;

-(IBAction) startButton;

@end

@implementation ViewController{
    
    NSString * reuseIdentifier;
    
    Player * player1;
    Player * player2;
    
    CGRect player1TurnIconSpot;
    CGRect player2TurnIconSpot;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    reuseIdentifier = @"Cell";
    
    self.xIcon = [UIImage imageNamed:@"x_icon.png"];
    self.oIcon = [UIImage imageNamed:@"o_icon.png"];
    
    //need to adjust for the header view which I guess is automatically included
    [self.gameBoard setContentInset:UIEdgeInsetsMake(-45.0, 0.0, 0.0, 5.0)];
    
    player1TurnIconSpot = CGRectMake(140.0, 15.0, 40.0, 40.0);
    player2TurnIconSpot = CGRectMake(140.0, 62.0, 40.0, 40.0);
    [self.turnIcon setFrame:player1TurnIconSpot];
    
	[self.gameBoard registerClass:[BoardCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //playing around with gesture recognizers and tags
    UIGestureRecognizer * tapSomewhere = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    tapSomewhere.cancelsTouchesInView = NO;
    //Tag 1 references the view located between the uinavbar and uicollectionview
    [[self.view viewWithTag:1] addGestureRecognizer:tapSomewhere];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard and Status Bar dismissing

-(void)hideKeyboard{
    
    [self.player1name resignFirstResponder];
    [self.player2name resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self hideKeyboard];
    return YES;
}

-(BOOL)prefersStatusBarHidden{
    return TRUE;
}

#pragma mark - Game Logic

-(void)startButton{
    
    if ([self getPlayerNames]) {
        [self beginGame];
    };
    
}

-(void) beginGame{

    
    if (!self.game) {
        self.game = [[GameController alloc] initGameWithPlayer1:player1 andPlayer2:player2 withGridSize:GRIDSIZE];
    }
    [self.game setDelegate:self];
    self.game.gameGrid = self.gameBoard;
    [self updateTurnIcon];
    
}

#warning this is currently bugged for when it's player 2's turn
-(void) updateTurnIcon{
    
    /*
     // Bugged if I try to move from 1 location to the other, unsure why
     
    NSLog(@"Player 1 X:  %f   Y:%f    W:%f    H:%f" ,player1TurnIconSpot.origin.x, player1TurnIconSpot.origin.y, player1TurnIconSpot.size.width, player1TurnIconSpot.size.height);
    
    NSLog(@"Player 2 X:  %f   Y:%f    W:%f    H:%f" ,player2TurnIconSpot.origin.x, player2TurnIconSpot.origin.y, player2TurnIconSpot.size.width, player2TurnIconSpot.size.height);
     */
    
    CGRect destinationFrame;
    
    if (self.game.player1Turn) {
        NSLog(@"Player 1 turn");
        destinationFrame = player1TurnIconSpot;
    }else{
        NSLog(@"Player 2 turn");
        [self.turnIcon setFrame:player2TurnIconSpot];
        destinationFrame = player2TurnIconSpot;
    }
    
    [UIView animateWithDuration:1.0 delay:0.1
                                 options:UIViewAnimationCurveLinear
                            animations:^{
                                    [self.turnIcon setFrame:destinationFrame];
                                    [self.turnIcon setAlpha:1.0];
                                 }
                              completion:^(BOOL finished){
                                  if (finished) {
                                      NSLog(@"animation done");
                                  }
                              }];
    
}

-(BOOL) getPlayerNames{
    
    if ([self.player1name.text length] > 0 && [self.player2name.text length]>0){
        
        //create player objects
        player1 = [[Player alloc] init];
        [player1 setPlayerName:[self.player1name text]];
        [player1 setPlayerIcon:self.xIcon];
        [self.player1icon setImage:player1.icon];
        
        player2 = [[Player alloc] init];
        [player2 setPlayerName:[self.player2name text]];
        [player2 setPlayerIcon:self.oIcon];
        [self.player2icon setImage:player2.icon];

        //change textfields
        self.player1name.enabled = FALSE;
        [self.player1name setBorderStyle:UITextBorderStyleNone];
        self.player1name.textAlignment = NSTextAlignmentCenter;
        
        self.player2name.enabled = FALSE;
        [self.player2name setBorderStyle:UITextBorderStyleNone];
        self.player2name.textAlignment = NSTextAlignmentCenter;

        
        NSLog(@"Player 1: %@", player1.name);
        NSLog(@"Player 2: %@", player2.name);
        
        [self.view resignFirstResponder];
        
        return TRUE;
    }
    return FALSE;
    
}

-(void)updateRoundInformation:(NSInteger) round{
    
    self.roundLabel.text = [NSString stringWithFormat:@"Round: %i",round];
    
}

#pragma mark - UICollection View Methods

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    BoardCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //cols
    return GRIDSIZE;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //rows
    return GRIDSIZE;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, 90);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(10, 10, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BoardCell * selectedCell = (BoardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    Player * currentPlayer = self.game.currentPlayer;
    //NSLog(@"NSIndexPath: %@    Section: %d    Row: %d", indexPath, indexPath.section, indexPath.row);
#warning probably moving this line to cellatindexpath will solve bug with enabled cells.. or in willSelect... this property itself is bugged, look at code for uicollectionviewCell
    [selectedCell setUserInteractionEnabled:selectedCell.selected];//false by default
    [selectedCell setIcon:currentPlayer.icon forPlayer:currentPlayer];
    
    [currentPlayer addCellAtIndex:indexPath];
    if ([selectedCell isUserInteractionEnabled]) {
       [self.game updateRound];
    }
    
}

@end
