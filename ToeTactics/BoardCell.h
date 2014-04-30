//
//  BoardCell.h
//  ToeTactics
//
//  Created by Louis Tur on 4/27/14.
//  Copyright (c) 2014 Louis Tur. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardCell : UICollectionViewCell

@property (strong, nonatomic) UIImage * playerIcon;
@property (strong, nonatomic) UIImageView * iconView;
@property (nonatomic) BOOL cellSelected;

-(void) setIcon:(UIImage *)icon;

@end
