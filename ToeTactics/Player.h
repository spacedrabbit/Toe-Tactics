//
//  Player.h
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSNumber *score;
@property (strong, nonatomic) UIImage * icon;

-(void) setPlayerName:(NSString *) name;
-(void) setPlayerScore:(NSNumber *) score;
-(void) setPlayerIcon:(UIImage *)icon;

-(void) addCellAtIndex:(NSIndexPath *) indexPath;
-(NSMutableSet *) allOwnedCells;

@end
