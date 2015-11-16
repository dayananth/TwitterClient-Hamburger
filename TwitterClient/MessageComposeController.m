//
//  MessageComposeController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/8/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "MessageComposeController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "User.h"

@interface MessageComposeController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;
@property (strong, nonatomic) User *user;
@property BOOL isMessagePosted;

@property (weak, nonatomic) IBOutlet UILabel *coutnerLabel;
@end

@implementation MessageComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupHeader];
    [self setUserInfo];

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

-(void) setupHeader{
    
    self.title = @"Compose";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *rbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rbutton.frame = CGRectMake(10, 0, 100, 30);
    rbutton.layer.cornerRadius = 15.0;
    rbutton.layer.borderColor = [UIColor whiteColor].CGColor;
    rbutton.layer.borderWidth = 1.0f;
    [rbutton setTitle:@"Send" forState:UIControlStateNormal];
    [rbutton addTarget:self action:@selector(onSend) forControlEvents:UIControlEventAllEvents];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rbutton];
    [rightButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                               forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.messageTextField becomeFirstResponder];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
                                   selector:@selector(countText)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) setUserInfo{
    if(self.inReplyToTweet){
        self.user = self.inReplyToTweet.user;
    }else{
        self.user = [User currentUser];
    }
    self.isMessagePosted = false;
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
    self.userNameLabel.text = self.user.name;


}

-(void) viewWillAppear:(BOOL)animated{
    self.isMessagePosted = false;
}

-(void) onCancel{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) onSend{
    if(!self.isMessagePosted){
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        dictionary[@"status"] = self.messageTextField.text;
        if(self.inReplyToTweet){
            dictionary[@"in_reply_to_status_id"] = self.inReplyToTweet.twetID;
            dictionary[@"status"] = [NSString stringWithFormat:@"@%@ %@",self.inReplyToTweet.user.screenName, self.messageTextField.text];
        }
        [[TwitterClient sharedInstance] sendTweet:dictionary completion:^(Tweet *tweet, NSError *error) {
        if (tweet !=nil) {
            NSLog(@"successfully posted");
            [self.delegate MessageComposeController:self didPostMessage:tweet];
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
            
        }else{
            [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
            NSLog(@"Failed to post message");
        }
      }];
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.isMessagePosted = true;
    }
}

-(void) countText{
    self.coutnerLabel.text = [NSString stringWithFormat:@"%i",
                       140-self.messageTextField.text.length];
}

@end
