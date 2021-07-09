//
//  PostCell.h
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostCellDelegate

- (void)didClickProfile:(PFUser *)user;

@end

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *profileImageButton;
@property (weak, nonatomic) IBOutlet UIButton *usernameButton;


@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) id<PostCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
