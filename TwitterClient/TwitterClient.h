//
//  TwitterClient.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/4/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1RequestOperationManager.h>
#import "Tweet.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

-(void)loginWithCompletion:(void (^) (User *user, NSError *error))completion;

-(void) openURL:(NSURL* )url;

-(void) homeTimeLineWithParams: (NSDictionary *) params completion:(void (^) (NSArray *tweets, NSError *error)) completion;

-(void) sendTweet: (NSDictionary *) params completion:(void (^) (Tweet *tweet, NSError *error)) completion;

-(void) retweet: (NSNumber *) tweetID completion:(void (^) (Tweet *tweet, NSError *error)) completion;

-(void) favourite: (NSNumber *) tweetID completion:(void (^) (Tweet *tweet, NSError *error)) completion;
@end
