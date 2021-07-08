//
//  PostCollectionCell.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import "PostCollectionCell.h"

@implementation PostCollectionCell

- (void)setPost:(Post *)post {
    _post = post;
    
    self.pictureImageView.file = post.image;
    [self.pictureImageView loadInBackground];
    
}
@end
