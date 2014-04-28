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
@property (strong, nonatomic, readonly) id icon;

-(void) setPlayerName:(NSString *) name;
-(void) setPlayerScore:(NSNumber *) score;
-(void) setPlayerIcon:(id)icon;

@end
