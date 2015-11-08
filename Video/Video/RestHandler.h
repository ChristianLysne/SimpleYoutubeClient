//
//  RestHandler.h
//  Video
//
//  Created by Christian Lysne on 08/11/15.
//  Copyright © 2015 Christian Lysne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestHandler : NSObject

+ (instancetype)sharedInstance;
- (void)fetchVideos:(void (^)(NSArray *videos))success failure:(void (^)(NSError *error))failure;

@end
