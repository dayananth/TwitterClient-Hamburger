//
//  MenuViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/15/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "MenuViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MenuCell.h"
#import "User.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
#import "ProfileViewController.h"
#import "User.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, atomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray* menuArray;
@property (strong, nonatomic) NSMutableArray* viewControllers;
@end

@implementation MenuViewController

- (id) initWithMenu {
    self = [super init];
    if(self){
        self.menuArray = @[@"Profile", @"Tweets", @"Mentions"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:NULL] forCellReuseIdentifier:@"MenuCell"];
    self.menuTableView.dataSource = self;
    self.menuTableView.delegate = self;
    [self.menuTableView reloadData];
    [self setUserInfo];
    
    self.viewControllers = [NSMutableArray array];
    [self.viewControllers insertObject:[[ProfileViewController alloc] initWithUser:[User currentUser]]  atIndex:0];
    [self.viewControllers insertObject:[[TweetsViewController alloc] initAsTweetsViewControllerWithHamBurgerController:self.hamburgerController]  atIndex:1];
    [self.viewControllers insertObject:[[TweetsViewController alloc] initAsMentionsViewControllerWithHamBurgerController:self.hamburgerController]  atIndex:2];
    
    HamburgerViewController *hamburgerController = self.hamburgerController;
    
    hamburgerController.contentViewController = self.viewControllers[1];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.menuTitleLabel.text = self.menuArray[indexPath.row];
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HamburgerViewController *hamburgerController = self.hamburgerController;
    
    hamburgerController.contentViewController = self.viewControllers[indexPath.row];
}



-(void) setUserInfo{
    User *user = [User currentUser];
    NSURL *url = [NSURL URLWithString:user.profileImageUrl];
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
    self.usernameLabel.text = user.name;
    self.screennameLabel.text = user.screenName;
}

@end
