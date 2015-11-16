    //
//  TweetCell.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/7/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"


@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.contentView.layer setBorderWidth:1.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setTweet: (Tweet *) tweet{
    _tweet = tweet;
    NSLog(self.tweet.user.profileImageUrl);
    NSURL *url = [NSURL URLWithString:self.tweet.user.profileImageUrl];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];

    [self.profileImageView setImageWithURLRequest:urlReq placeholderImage:NULL success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [UIView transitionWithView:self.profileImageView
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.profileImageView.image = image;
                        }
                        completion:NULL];
                }
        failure:NULL];
    self.userNameLabel.text = self.tweet.user.name;
    self.timeStampLabel.text = self.tweet.formattedDate;
    self.TweetLabel.text = self.tweet.text;
    [self.TweetLabel sizeToFit];
}

@end
