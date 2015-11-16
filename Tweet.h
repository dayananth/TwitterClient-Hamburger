//
//  Tweet.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/5/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSNumber *twetID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *formattedDate;
@property (nonatomic, strong) User *user;
@property long noOfReTweets;
@property long noOfLikes;
@property long inReplyTo;


-(id) initWithDictionary: (NSDictionary *)dictionary;

+(NSArray *) tweetsWithArray: (NSArray *) tweetsArray;

@end
