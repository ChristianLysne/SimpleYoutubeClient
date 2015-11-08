//
//  VideoTableViewCell.h
//  Video
//
//  Created by Christian Lysne on 02/09/15.
//  Copyright (c) 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImageView.h"

@protocol VideoTableViewCellDelegate <NSObject>

-(void)handlePressedOpenVideoFromCell:(UITableViewCell *)cell;
-(void)handlePressedOpenDetailsFromCell:(UITableViewCell *)cell;

@end

@interface VideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet RoundedCornerImageView *mainImageView;
@property(nonatomic,weak)id <VideoTableViewCellDelegate> delegate;

@end
