//
//  GameController.h
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Player;


@protocol GameControllerDelegate <NSObject>

-(void)updateRoundInformation:(NSInteger)round;

@end

@interface GameController : NSObject

@property (strong, nonatomic) Player * currentPlayer;

@property (strong, nonatomic) NSMutableArray * playerList;
@property (strong, nonatomic) UICollectionView * gameGrid;
@property (strong, nonatomic) NSArray * allCells;

@property (nonatomic) NSInteger round;
@property (nonatomic) BOOL player1Turn;

@property (nonatomic, strong) id<GameControllerDelegate> delegate;

-(BOOL)gameOver;
-(instancetype)initGameWithPlayer1:(Player *)one andPlayer2:(Player *)two withGridSize:(NSInteger) size;
-(void) updateRound;

@end
