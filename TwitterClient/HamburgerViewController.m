//
//  HamburgerViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/15/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@property (assign, nonatomic) CGFloat originalLeftMargin;

@end

@implementation HamburgerViewController

-(void) setMenuViewController:(MenuViewController *)menuViewController{
    _menuViewController = menuViewController;
    [self.view layoutIfNeeded];
    [self.menuView addSubview:menuViewController.view];
}

-(void) setContentViewController:(UIViewController *)contentViewController{
//    if(_contentViewController != nil){
//        [_contentViewController willMoveToParentViewController:nil];
//        [_contentViewController.view removeFromSuperview];
//    }
    _contentViewController = contentViewController;

    [self.view layoutIfNeeded];
    
    [contentViewController willMoveToParentViewController:self];

    [self.contentView addSubview:contentViewController.view];
    [contentViewController didMoveToParentViewController:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

//-(void) setMenuView:(UIView *)menuView{
//    _menuView = menuView;
//
//    [menuView addSubview:_menuView];
//}


- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {            CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = [self.leftMarginConstraint constant];
      
    }else if (sender.state == UIGestureRecognizerStateChanged){
        self.leftMarginConstraint.constant  = self.originalLeftMargin + translation.x;
        
        NSLog([NSString stringWithFormat:@"x:%f y:%f", translation.x, translation.y ]);
        
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.3 animations:^{
            if(velocity.x > 0){
                self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
            }else{
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
        
        
    }
    
}

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

@end
