//
//  User.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/5/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

-(id) initWithDictionary: (NSDictionary *)dictionary;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagLine;

+ (User *)currentUser;
+ (void)setCurrentUser: (User *) user;
+ (void) logout;

@end
