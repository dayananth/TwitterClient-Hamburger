//
//  TweetsViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/6/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetDetailViewController.h"
#import "MessageComposeController.h"
#import "HamburgerViewController.h"
#import "ProfileViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, MessageComposeControllerDelegate, TweetDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *TweetTableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property BOOL isComposeShown;
@property BOOL isMentionsView;
@property HamburgerViewController *hamburgerController;
@end

@implementation TweetsViewController

-(id) initAsTweetsViewControllerWithHamBurgerController: (HamburgerViewController *) hamburgerController {
    self = [super init];
    if(self){
        self.isMentionsView = NO;
        self.hamburgerController = hamburgerController;
    }
    return self;
}

-(id) initAsMentionsViewControllerWithHamBurgerController: (HamburgerViewController *) hamburgerController {
    self = [super init];
    if(self){
        self.isMentionsView = YES;
        self.hamburgerController = hamburgerController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Home";
    self.isComposeShown = false;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:80.0/255.0 green: 80.0/255.0 blue:180.0/255.0 alpha: 1.0]];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 100, 30);
    button.layer.cornerRadius = 15.0;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0f;
    [button setTitle:@"Signout" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onLogout) forControlEvents:UIControlEventAllEvents];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [leftButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                              forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = leftButton;

    
    UIButton *rbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rbutton.userInteractionEnabled = YES;
    rbutton.frame = CGRectMake(10, 0, 100, 30);
    rbutton.layer.cornerRadius = 15.0;
    rbutton.layer.borderColor = [UIColor whiteColor].CGColor;
    rbutton.layer.borderWidth = 1.0f;
    [rbutton setTitle:@"Compose" forState:UIControlStateNormal];
    [rbutton addTarget:self action:@selector(onCompose:) forControlEvents:UIControlEventAllEvents];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rbutton];
    [rightButton setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,nil]
                              forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.TweetTableView.delegate = self;
    self.TweetTableView.dataSource = self;
    [self.TweetTableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.TweetTableView.estimatedRowHeight = 86;
    self.TweetTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.TweetTableView addSubview:self.refreshControl];
    self.tweets = [NSMutableArray array];
    if(self.isMentionsView){
        [self fetchMentions];
    }else{
        [self fetchTweets];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void) fetchTweets{
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if(tweets != nil){
            self.tweets = tweets;
            [self.TweetTableView reloadData];
        }else{
            NSLog(@"Render Error");
        }
    }];
}

- (void) fetchMentions{
    [[TwitterClient sharedInstance] mentions:nil completion:^(NSArray *tweets, NSError *error) {
        if(tweets != nil){
            self.tweets = tweets;
            [self.TweetTableView reloadData];
        }else{
            NSLog(@"Render Error");
        }
    }];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    self.isComposeShown = false;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)onCompose:(id)sender {
    if(!self.isComposeShown){
        UIButton *button = (UIButton*)sender;
//        button.userInteractionEnabled = NO;
        MessageComposeController *mcc = [[MessageComposeController alloc] init];
        mcc.delegate = self;
        [self.navigationController pushViewController:mcc animated:YES];
        self.isComposeShown = true;
    }
}

-(void)onLogout{
    [User logout];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    NSLog([NSString stringWithFormat:@"%ld", indexPath.row]);
    cell.profileImageView.tag = indexPath.row;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [cell.profileImageView addGestureRecognizer:tap];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    Tweet *tweet = self.tweets[indexPath.row];
//    TweetDetailViewController *tvc = [[TweetDetailViewController alloc] initWithTweet:tweet];
//    tvc.delegate = self;
//    [self.navigationController pushViewController:tvc animated:YES];
//}

-(void) MessageComposeController: (MessageComposeController *) MessageComposeController didPostMessage:tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.TweetTableView reloadData];
}

-(void) TweetDetailViewController: (TweetDetailViewController *) TweetDetailViewController didReply:(Tweet*) tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.TweetTableView reloadData];
}

-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Image Tapped: %ld", [recognizer.view tag]);
    HamburgerViewController *hamburgerViewController = (HamburgerViewController *)self.presentingViewController;
    Tweet *tweet = self.tweets[[recognizer.view tag]];
    self.hamburgerController.contentViewController = [[ProfileViewController alloc] initWithUser:tweet.user];
   
}


@end
