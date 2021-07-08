//
//  PostCell.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import "PostCell.h"
#import "DateTools.h"

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
    
    [self setupLabels];
    [self setupImages];
}

- (void)setupLabels {
    UIFont *boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    UIFont *regularFont = [UIFont fontWithName:@"HelveticaNeue" size:18];
    
    // setup bolded username
    NSMutableAttributedString *username = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", self.post.author.username]];
    [username addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0,username.length)];
    
    
    self.usernameLabel.attributedText = username;
    
    
    // setup caption
    NSMutableAttributedString *captionText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", self.post.caption]];
    [captionText addAttribute:NSFontAttributeName value:regularFont range:NSMakeRange(0, captionText.length)];
    
    [username appendAttributedString:captionText];
    self.captionLabel.attributedText = username;
    
    // setup date
    self.timeLabel.text = self.post.createdAt.timeAgoSinceNow;
}

- (void) setupImages {
    // setup Post Image
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    
    // setup Profile Image
    self.userImageView.layer.masksToBounds = false;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2;
    self.userImageView.clipsToBounds = true;
    
    self.userImageView.file = [self.post.author objectForKey:@"profileImage"];
    [self.userImageView loadInBackground];
    
}

@end
