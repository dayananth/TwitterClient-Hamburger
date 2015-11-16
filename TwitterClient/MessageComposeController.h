//
//  MessageComposeController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/8/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class MessageComposeController;

@protocol MessageComposeControllerDelegate <NSObject>

-(void) MessageComposeController: (MessageComposeController *) MessageComposeController didPostMessage:(Tweet*) tweet;

@end

@interface MessageComposeController : UIViewController
@property (nonatomic, weak) id<MessageComposeControllerDelegate> delegate;
@property (strong, nonatomic) Tweet *inReplyToTweet;
@end
