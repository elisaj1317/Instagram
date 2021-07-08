//
//  ProfileHeaderView.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import "ProfileHeaderView.h"
#import <Parse/Parse.h>

@implementation ProfileHeaderView

- (void)setPostCount:(NSNumber *)postCount{
    _postCount = postCount;
    
    self.numPostLabel.text = [NSString stringWithFormat:@"%@", postCount];
}

- (void)setUser:(PFUser *)user{
    _user = user;
    
    self.usernameLabel.text = user.username;
}

@end
