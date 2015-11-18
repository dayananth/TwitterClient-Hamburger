//
//  TweetsViewController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/6/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerViewController.h"

@interface TweetsViewController : UIViewController

-(id) initAsTweetsViewControllerWithHamBurgerController: (HamburgerViewController *) hamburgerController;
-(id) initAsMentionsViewControllerWithHamBurgerController: (HamburgerViewController *) hamburgerController;
@end
