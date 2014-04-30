//
//  BoardCell.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import "BoardCell.h"
@interface BoardCell ()
@end

@implementation BoardCell

-(id)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];

    if (self) {
        self.cellSelected =FALSE;
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        [self addSubview:_iconView];
        
        [_iconView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void) setIcon:(UIImage *)icon{
    
    if ( !_playerIcon ) {
        _playerIcon = icon;
    }
    
    if (!self.cellSelected) {
        self.iconView.image = self.playerIcon;
        self.cellSelected = !self.cellSelected;

    }
    
}


@end
