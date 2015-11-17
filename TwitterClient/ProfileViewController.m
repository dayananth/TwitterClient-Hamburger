//
//  ProfileViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/16/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfTweets;
@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowing;

@property (weak, nonatomic) IBOutlet UILabel *numberOfFollowers;
@property (weak, nonatomic) User* user;
@end

@implementation ProfileViewController

-(id) initWithUser:(User *)user{
    self = [super init];
    if(self != nil){
        self.user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.user.profileImageUrl];
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
    self.numberOfFollowers.text = self.user.followersCount.description;
    self.numberOfFollowing.text = self.user.followingCount.description;
    self.numberOfTweets.text = self.user.tweetsCount.description;
//    self.timeStampLabel.text = self.tweet.formattedDate;
//    self.tweetLabel.text = self.tweet.text;
//    self.noOfLikeLabel.text = [NSString stringWithFormat:@"%ld likes",self.tweet.noOfLikes];
//    self.noOfTweetsLabel.text = [NSString stringWithFormat:@"%ld  retweets",self.tweet.noOfReTweets];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
