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

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
