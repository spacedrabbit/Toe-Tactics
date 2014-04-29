//
//  GameController.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import "GameController.h"
#import "BoardCell.h"
#import "Player.h"

@interface GameController ()

@property (nonatomic) NSInteger gridSize;
@property (strong, nonatomic) NSMutableArray * winComparisonSet;

@end

@implementation GameController

-(instancetype)initGameWithPlayer1:(Player *)one andPlayer2:(Player *)two withGridSize:(NSInteger) size{
    
    self = [super init];
    if(self){
        _playerList = [NSMutableArray arrayWithObjects:one, two, nil];
        _round = 1;
        _player1Turn = arc4random_uniform(2);
        _gridSize = size;
        
        _currentPlayer = _playerList[_player1Turn];
        _winComparisonSet = [NSMutableArray array];
        
        [self createWinConditions];//game starts and win conditions are set
    }
    
    return self;
}

-(instancetype) init{
    return [self initGameWithPlayer1:nil andPlayer2:nil withGridSize:0];
}

-(BOOL)gameOver{
    return FALSE;
}

-(BOOL) winCheck{
    
    //1st round where a win can occur is (size*2 - 1) --> 3 X's, 2 O's --> 5 rounds
    if ( self.round >= ((self.gridSize * 2) -1) ) {
        
        //checks to see if a winSet is a subset of a player's owned cells, if so... WINRARRR
        for (NSSet * winSet in self.winComparisonSet) {
            if ( [winSet isSubsetOfSet:[self.currentPlayer allOwnedCells]] ) {
                return TRUE;
            }
        }
    }
    return FALSE;
}

-(void) updateRound{
    
    /*
        1 - Check for win
            - should end here potentially
     
        2 - Update round
        3 - Update Round Info on view delegate
     
        4 - Change Bool for player turn
        5 - Based on Bool, switch between player @[0,1]
     */
    if ([self winCheck]) {
        NSLog(@"O MAN YOU WON!");
    };
    
    self.round++;
    [self.delegate updateRoundInformation:self.round];
    
    self.player1Turn = !self.player1Turn;
    self.currentPlayer = self.playerList[self.player1Turn];

}


// Create criteria for wins. Scalable with odd # of side lengths... if needed
-(void) createWinConditions{
    
    // where x = current number (section or index)
    // where n = max length of 1 side of grid
    
    static NSIndexPath * containerPath;
    NSInteger section;
    NSInteger row;
    NSMutableSet * diagonalSet = [NSMutableSet set];

    //horizontal wins ->  cell[x][0-n] (i.e row: 0, sections: 0-max)
    //vertical wins -> cell[0-n][x];    (i.e row: 0-max, section: 0)
    for (int i = 0; i < self.gridSize; i++) {
        NSMutableSet * horizontalSet = [NSMutableSet set];
        NSMutableSet * verticalSet = [NSMutableSet set];
        
        section = [[NSNumber numberWithInteger:i] integerValue];
        
        for (int j = 0; j < self.gridSize; j++) {
            row = [[NSNumber numberWithInt:j] integerValue];
            
            containerPath = [NSIndexPath indexPathForItem:row   inSection:section];
            [horizontalSet addObject:containerPath];
            
            //grabs 1st diagonal, index[x-n][x-n]
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
    
    //opposite diagonal, cell[0 - (max-1)][(max-1) - 0];
    int diagBound = self.gridSize-1;
    diagonalSet = [NSMutableSet set];
    for (int i = 0; i <= diagBound ; i++ ){
        NSIndexPath * diag = [NSIndexPath indexPathForRow:i inSection:diagBound-i];
        [diagonalSet addObject:diag];
    }
    [self.winComparisonSet addObject:diagonalSet];
    
    #warning Remove this before sending
    /*
    NSLog(@"Number of Comparison Sets: %lu", (unsigned long)[self.winComparisonSet count]);
    NSLog(@"%@\n", self.winComparisonSet);

    for (NSArray * comparisonSets in self.winComparisonSet) {
        NSLog(@"Comparison set: \n");
        for (NSIndexPath *path in comparisonSets) {
            NSLog(@"(IndexPath) [%u ,  %u] \n", path.section, path.row);
        }
    }*/
    
}

@end
