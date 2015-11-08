//
//  ViewController.m
//  Video
//
//  Created by Christian Lysne on 01/09/15.
//  Copyright (c) 2015 Christian Lysne. All rights reserved.
//

#import "ViewController.h"
#import "VideoTableViewCell.h"
#import "Video.h"
#import <PINRemoteImage/UIImageView+PINRemoteImage.h>
#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import "DetailsViewController.h"
#import "RestHandler.h"

NSString * const kDetailsSegue = @"DetailsSegue";

@interface ViewController () <VideoTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *videos;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.videos = [NSMutableArray new];
    [self fetchVideos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetching
- (void)fetchVideos {
    
    [[RestHandler sharedInstance] fetchVideos:^(NSArray *videos) {
        
        self.videos = [NSMutableArray arrayWithArray:videos];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get videos: %@", error);
    }];
}

#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(200, CGRectGetHeight(self.view.frame)/3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.delegate = self;
    
    Video *video = [self.videos objectAtIndex:indexPath.row];
    [cell.mainImageView pin_setImageFromURL:video.imageURL];
    
    cell.titleLabel.text = video.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = [self.videos objectAtIndex:indexPath.row];
    
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:video.videoID];
    
    [self presentViewController:videoPlayerViewController animated:YES completion:^{
        [videoPlayerViewController.moviePlayer play];
    }];
    
}

#pragma mark - Rotation
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.tableView reloadData];
}

#pragma mark - VideoCell Delegate
- (void)handlePressedOpenDetailsFromCell:(UITableViewCell *)cell {
    [self performSegueWithIdentifier:kDetailsSegue sender:[self videoForCell:cell]];
}


- (void)handlePressedOpenVideoFromCell:(UITableViewCell *)cell {
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:[self videoForCell:cell].videoID];
    
    [self presentViewController:videoPlayerViewController animated:YES completion:^{
        [videoPlayerViewController.moviePlayer play];
    }];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:kDetailsSegue]){
        DetailsViewController *vc = segue.destinationViewController;
        if([sender isKindOfClass: [Video class]] && [vc isKindOfClass:[DetailsViewController class]]){
            vc.video = (Video *)sender;
        }
    }
}

#pragma mark - Utils
- (Video *)videoForCell:(UITableViewCell *)cell {
    NSInteger index = [self.tableView indexPathForCell:cell].row;
    return self.videos[index];
}

@end
