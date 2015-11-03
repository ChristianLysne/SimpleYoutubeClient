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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *videos;

@end

@implementation ViewController

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

- (void)fetchVideos {
    
    // Set up your URL
    NSString *youtubeEndpoint = @"https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&maxResults=50&regionCode=NO&videoCategoryId=23&key=AIzaSyDlLkNDgDjQWPJ-dUE840goio7Mki0rtnM";
    NSURL *url = [[NSURL alloc] initWithString:youtubeEndpoint];
    
    // Create your request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Send the request asynchronously
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // Callback, parse the data and check for errors
        if (data && !connectionError) {
            NSError *jsonError;
            NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            if (!jsonError) {
//                NSLog(@"Response from YouTube: %@", jsonResult);
                
                NSArray *items = [jsonResult objectForKey:@"items"];
                
                for (NSDictionary *dic in items) {
                    
                    Video *video = [Video new];
                    video.videoID = [dic objectForKey:@"id"];
                    video.title = [dic valueForKeyPath:@"snippet.title"];
                    video.imageURL = [NSURL URLWithString:[dic valueForKeyPath:@"snippet.thumbnails.high.url"]];
                    
                    [self.videos addObject:video];
                }
                
                [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
                
            } else {
                NSLog(@"Error: %@", jsonError);
            }
        } else {
            NSLog(@"Connection error: %@", connectionError);
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(self.view.frame)/2.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
    
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

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.tableView reloadData];
}

@end
