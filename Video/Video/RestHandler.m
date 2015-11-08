//
//  RestHandler.m
//  Video
//
//  Created by Christian Lysne on 08/11/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import "RestHandler.h"
#import "Video.h"
@implementation RestHandler

#pragma mark - Init
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RestHandler *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RestHandler alloc] init];
    });
    return sharedInstance;
}

- (void)fetchVideos:(void (^)(NSArray *videos))success failure:(void (^)(NSError *error))failure {
    
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
                
                NSMutableArray *returnArray = [NSMutableArray new];
                
                for (NSDictionary *dic in items) {
                    
                    Video *video = [Video new];
                    video.videoID = [dic objectForKey:@"id"];
                    video.title = [dic valueForKeyPath:@"snippet.title"];
                    video.videoDescription = [dic valueForKeyPath:@"snippet.description"];
                    video.imageURL = [NSURL URLWithString:[dic valueForKeyPath:@"snippet.thumbnails.high.url"]];
                    
                    [returnArray addObject:video];
                }
                
                success(returnArray);
                
            } else {
                NSLog(@"JSON Error: %@", jsonError);
                failure(jsonError);
            }
        } else {
            NSLog(@"Connection error: %@", connectionError);
            failure(connectionError);
        }
    }];
}

@end
