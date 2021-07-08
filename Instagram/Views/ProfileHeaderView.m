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
    self.descriptionLabel.text = [self.user objectForKey:@"userDescription"];
    
    [self setupProfileImage];
    
}

- (void)setupProfileImage {
    // set profile Image
    self.profileImage.layer.masksToBounds = false;
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    self.profileImage.clipsToBounds = true;
    
    self.profileImage.file = [self.user objectForKey:@"profileImage"];
    [self.profileImage loadInBackground];
}

@end
