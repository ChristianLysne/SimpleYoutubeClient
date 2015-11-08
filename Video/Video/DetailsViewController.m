//
//  DetailsViewController.m
//  Video
//
//  Created by Håkon Knutzen on 04/11/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "DetailsViewController.h"
#import "Video.h"
#import <PINRemoteImage/UIImageView+PINRemoteImage.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self populateVideoInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)populateVideoInfo{
    self.titleLabel.text = self.video.title;
    self.detailsTextView.text = self.video.videoDescription;
    [self.imageView pin_setImageFromURL:self.video.imageURL];
}

@end
