//
//  HamburgerViewController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/15/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface HamburgerViewController : UIViewController
@property MenuViewController *menuViewController;
@property (nonatomic, assign) UIViewController *contentViewController;
@end
