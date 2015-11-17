//
//  MenuViewController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/15/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HamburgerViewController;

@interface MenuViewController : UIViewController
@property HamburgerViewController *hamburgerController;
- (id) initWithMenu;
@end
