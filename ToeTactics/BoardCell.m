//
//  BoardCell.m
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import "BoardCell.h"
@interface BoardCell ()

@property (nonatomic, strong) id owner;

@end

@implementation BoardCell

-(id)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];

    if (self) {
        self.cellSelected = FALSE;
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        [self addSubview:_iconView];
        
        [_iconView setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void) setIcon:(UIImage *)icon forPlayer:(id)player{
    
    if ( !_playerIcon ) {
        _playerIcon = icon;
    }
    
    /*
        If cell isn't selected (bool), then set the icon
        to the playerIcon, change the cell to disabled
     
     */
    if (!self.cellSelected) {
        self.iconView.image = self.playerIcon;
        self.cellSelected = !self.cellSelected;
        //I want the value to be set to player, not a pointer to the actual object... i believe this is correct
        _owner = player;
    }
    
}

-(id)returnCellOwner{
    return self.owner;
}


@end
