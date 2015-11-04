//
//  Video.h
//  Video
//
//  Created by Christian Lysne on 02/09/15.
//  Copyright (c) 2015 Christian Lysne. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, copy) NSString *videoID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *videoDescription;
@property (nonatomic, copy) NSURL *imageURL;

@end
