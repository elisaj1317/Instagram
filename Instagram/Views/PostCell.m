//
//  PostCell.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    
    self.descriptionLabel.text = post.caption;
    
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

@end
