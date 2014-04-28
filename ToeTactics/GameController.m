//
//  GameController.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import "GameController.h"
#import "BoardCell.h"

@implementation GameController

-(instancetype)initGameWithPlayer1:(Player *)one andPlayer2:(Player *)two{
    
    self = [super init];
    if(self){
        _playerList = [NSMutableArray arrayWithObjects:one, two, nil];
        _round = [NSNumber numberWithInt:1];
        _player1Turn = arc4random_uniform(2);
        
        
        //this is redundant but was added after the above BOOL to enchance
        //functionality. Would be removed later
        _currentPlayer = _playerList[_player1Turn];
        
        [self roundBegin];
    }
    
    return self;
}

-(instancetype) init{
    return [self initGameWithPlayer1:nil andPlayer2:nil];
}

-(BOOL)gameOver{
    return FALSE;
}

-(void) roundBegin{
    
    if (self.player1Turn) {
        
    }
    
}

-(void) winCheck{
    
    if ([self.round compare:[NSNumber numberWithInt:6]] == NSOrderedSame) {
        //first round of a potential win will be after 6 plays have been made
        NSLog(@"Checking for wins");
        
        NSInteger sections = [self.gameGrid numberOfSections];
        NSInteger items = [self.gameGrid numberOfItemsInSection:0];
        
        if (!self.allCells) {
            self.allCells = [NSArray arrayWithArray:[self.gameGrid indexPathsForVisibleItems]];
        }
#warning Create logic here. 
    }
}

-(void) updateRound{
    self.round = [NSNumber numberWithInt:([self.round intValue] + 1)];
    self.player1Turn = !self.player1Turn;
    self.currentPlayer = self.playerList[self.player1Turn];
    [self.delegate updateRoundInformation:self.round];
    [self winCheck];
}

@end
