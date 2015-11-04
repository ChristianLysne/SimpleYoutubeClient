//
//  VideoTableViewCell.m
//  Video
//
//  Created by Christian Lysne on 02/09/15.
//  Copyright (c) 2015 Christian Lysne. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.mainImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (IBAction)playButtonTapped:(id)sender {
    if([self.delegate respondsToSelector: @selector(handlePressedOpenVideoFromCell:)]){
        [self.delegate handlePressedOpenVideoFromCell:self];
    }
}

- (IBAction)infoButtonTapped:(id)sender {
    if([self.delegate respondsToSelector: @selector(handlePressedOpenDetailsFromCell:)]){
        [self.delegate handlePressedOpenDetailsFromCell:self];
    }
}


@end
