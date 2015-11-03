//
//  VideoTableViewCell.h
//  Video
//
//  Created by Christian Lysne on 02/09/15.
//  Copyright (c) 2015 Christian Lysne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@end
