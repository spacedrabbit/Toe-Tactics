//
//  Player.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import "Player.h"

@interface Player ()

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSNumber * score;
@property (strong, nonatomic) NSMutableSet * ownedCells;

@end


@implementation Player

-(id)init{
    self = [super init];
    if (self) {
        _name = @"Player1";
        _score = [NSNumber numberWithUnsignedInteger:0];
        
        _icon = [UIImage new];
        _ownedCells = [NSMutableSet set];

    }
    
    return self;
}

-(void)setPlayerName:(NSString *)name{
    self.name = name;
}

-(void) setPlayerIcon:(UIImage *)icon{
    self.icon = icon;
}

-(void)setPlayerScore:(NSNumber *)score{
    
    NSInteger scoreChange = [score integerValue];
    NSInteger currentScore = [self.score integerValue];
    
    self.score = [NSNumber numberWithInteger:(scoreChange + currentScore)];
    
}

-(void) addCellAtIndex:(NSIndexPath *)indexPath{
    
    [self.ownedCells addObject:indexPath];
    
}

-(NSMutableSet *) allOwnedCells{
    return self.ownedCells;
}

@end
