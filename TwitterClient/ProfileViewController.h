//
//  ProfileViewController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/16/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
-(id) initWithUser:(User *)user;
@end
