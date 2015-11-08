//
//  RoundedCornerImageView.m
//  Video
//
//  Created by Christian Lysne on 08/11/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "RoundedCornerImageView.h"

@implementation RoundedCornerImageView

- (void)awakeFromNib {
    [self customInit];
}

- (void)prepareForInterfaceBuilder {
    [self customInit];
}

- (void)customInit {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.cornerRadius;
}

@end
