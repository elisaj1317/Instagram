//
//  DetailsViewController.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import "DetailsViewController.h"
#import <Parse/PFImageView.h>
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *backdropImageView;
@property (weak, nonatomic) IBOutlet PFImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)setupView {
    
    // Labels setup
    self.nameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
    [self setupDate];
    [self setupImages];
    
}

- (void)setupDate {
    NSDate *createdAtDate = self.post.createdAt;
    self.dateLabel.text = [createdAtDate formattedDateWithFormat:@"h:mm a - M/d/yy"];
}

- (void)setupImages {
    // setup post image
    self.pictureImageView.file = self.post.image;
    [self.pictureImageView loadInBackground];
    
    // TODO: setup backdrop image
    self.backdropImageView.file = self.post.image;
    [self.backdropImageView loadInBackground];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    blurEffectView.effect = blurEffect;
    blurEffectView.frame = self.backdropImageView.bounds;
//    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    //ADD BLUR EFFECT VIEW IN MAIN VIEW
    [self.backdropImageView addSubview:blurEffectView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
