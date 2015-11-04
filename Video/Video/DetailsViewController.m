//
//  DetailsViewController.m
//  Video
//
//  Created by Håkon Knutzen on 04/11/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "DetailsViewController.h"
#import "Video.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self populateVideoInfo];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)populateVideoInfo{
    self.titleLabel.text = self.video.title;
    self.detailsTextView.text = self.video.videoDescription;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
