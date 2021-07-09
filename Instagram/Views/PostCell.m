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
    
    
    [self.usernameButton setTitle:self.post.author.username forState:UIControlStateNormal];
    
    
    // setup caption
    NSMutableAttributedString *captionText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", self.post.caption]];
    [captionText addAttribute:NSFontAttributeName value:regularFont range:NSMakeRange(0, captionText.length)];
    
    [username appendAttributedString:captionText];
    self.captionLabel.attributedText = username;
    
    // setup date
    self.timeLabel.text = self.post.createdAt.timeAgoSinceNow;
}


- (IBAction)didTapProfileImage:(id)sender {
    // Passes selected User into ProfileViewController
    [self.delegate didClickProfile:self.post.author];
}

- (IBAction)didTapUsername:(id)sender {
    // Passes selected User into ProfileViewController
    [self.delegate didClickProfile:self.post.author];
}

- (void) setupImages {
    // setup Post Image
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    
    // setup Profile Image
    self.profileImageButton.layer.masksToBounds = false;
    self.profileImageButton.layer.cornerRadius = self.profileImageButton.frame.size.height/2;
    self.profileImageButton.clipsToBounds = true;
    
    PFFileObject *profilePictureObject =[self.post.author objectForKey:@"profileImage"];
    
    [profilePictureObject getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (!error) {
                [self.profileImageButton setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            } else {
                NSLog(@"Error: %@", error.localizedDescription);
            }
    }];

    
}

- (IBAction)settingsButton:(id)sender {
}
@end
