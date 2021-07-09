//
//  SettingsViewController.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/8/21.
//

#import "SettingsViewController.h"
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>

@interface SettingsViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;

@property (strong, nonatomic) PFUser *currentUser;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up settings page with current values
    self.currentUser = [PFUser currentUser];
    self.profileImage.file = [self.currentUser objectForKey:@"profileImage"];
    [self.profileImage loadInBackground];
    
    self.bioTextView.text = [self.currentUser objectForKey:@"userDescription"];
}

- (IBAction)didTapChangePicture:(id)sender {
    // set up image picker
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    // show photo album
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapCancel:(id)sender {
    [self showCancelAlert];
}


- (IBAction)didTapDone:(id)sender {
    CGSize imageSize = CGSizeMake(300, 300);
    UIImage *resizedImage = [self resizeImage:self.profileImage.image withSize:imageSize];
    
    PFUser *currentUser = [PFUser currentUser];
    currentUser[@"profileImage"] = [self getPFFileFromImage:resizedImage];
    currentUser[@"userDescription"] = self.bioTextView.text;
    
    [currentUser saveInBackground];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.profileImage.image = editedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)showCancelAlert {
    // alert user of losing changes
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure you want to exit?"
                                                                               message:@"All changes made in this session will be lost."
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    // create a cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    // add the cancel action to the alertController
    [alert addAction:cancelAction];

    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Exit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
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
