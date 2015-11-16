//
//  TweetDetailViewController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/8/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetDetailViewController;

@protocol TweetDetailViewControllerDelegate <NSObject>

-(void) TweetDetailViewController: (TweetDetailViewController *) TweetDetailViewController didReply:(Tweet*) tweet;

@end

@interface TweetDetailViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id<TweetDetailViewControllerDelegate> delegate;

-(id) initWithTweet: (Tweet *) tweet;

- (IBAction)onReply:(id)sender;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onLike:(id)sender;

@end
