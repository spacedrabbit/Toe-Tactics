//
//  GameController.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import "GameController.h"
#import "BoardCell.h"

@interface GameController ()

@property (nonatomic) NSInteger gridSize;
@property (strong, nonatomic) NSMutableArray * winComparisonSet;

@end

@implementation GameController

-(instancetype)initGameWithPlayer1:(Player *)one andPlayer2:(Player *)two withGridSize:(NSInteger) size{
    
    self = [super init];
    if(self){
        _playerList = [NSMutableArray arrayWithObjects:one, two, nil];
        _round = [NSNumber numberWithInt:1];
        _player1Turn = arc4random_uniform(2);
        _gridSize = size;
        
        _currentPlayer = _playerList[_player1Turn];
        _winComparisonSet = [NSMutableArray array];
        
        [self roundBegin];
        [self createWinConditions];
    }
    
    return self;
}

-(instancetype) init{
    return [self initGameWithPlayer1:nil andPlayer2:nil withGridSize:0];
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

-(void) createWinConditions{
    
    // where x = current number (section or index)
    // where n = max length of 1 side of grid
    
    static NSIndexPath * containerPath;
    NSInteger section;
    NSInteger row;
    NSMutableSet * diagonalSet = [NSMutableSet set];

    //horizontal wins ->  cell[x][0-n]
    for (int i = 0; i < self.gridSize; i++) {
        NSMutableSet * horizontalSet = [NSMutableSet set];
        NSMutableSet * verticalSet = [NSMutableSet set];
        
        section = [[NSNumber numberWithInteger:i] integerValue];
        
        for (int j = 0; j < self.gridSize; j++) {
            row = [[NSNumber numberWithInt:j] integerValue];
            
            containerPath = [NSIndexPath indexPathForItem:row   inSection:section];
            [horizontalSet addObject:containerPath];
            
            if ( section == row ) {
                [diagonalSet addObject:containerPath];
            }
            
            containerPath = [NSIndexPath indexPathForItem:section   inSection:row];
            [verticalSet addObject:containerPath];
            
        }
        [self.winComparisonSet addObject:horizontalSet];
        [self.winComparisonSet addObject:verticalSet];

        if ( [diagonalSet count] == self.gridSize) {
            [self.winComparisonSet addObject:diagonalSet];
        }
    }
    
#warning remove these logs at end
    NSLog(@"Number of Comparison Sets: %lu", [self.winComparisonSet count]);
    NSLog(@"%@\n", self.winComparisonSet);
    
}

@end
