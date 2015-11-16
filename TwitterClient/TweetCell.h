//
//  TweetCell.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/7/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (nonatomic, strong) Tweet *tweet;
-(void) setTweet: (Tweet *) tweet;
@end
