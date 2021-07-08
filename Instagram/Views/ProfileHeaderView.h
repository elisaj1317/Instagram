//
//  ProfileHeaderView.h
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>


NS_ASSUME_NONNULL_BEGIN

@interface ProfileHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *numPostLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) PFUser *user;
@property (nonatomic, strong) NSNumber *postCount;

@end

NS_ASSUME_NONNULL_END
