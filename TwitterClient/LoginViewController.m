//
//  LoginViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/4/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "LoginViewController.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if(user != nil){
            // present tweets view
            NSLog(@"Welcome to Twaya client: %@", user.name);
            TweetsViewController *twc = [[TweetsViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:twc];
            [self presentViewController:nvc animated:YES completion:nil];
        }else{
            // present error view
            
        }
    }];

}
@end
