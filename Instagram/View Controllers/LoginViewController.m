//
//  LoginViewController.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/6/21.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
        
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    UIImage *placeholder = [UIImage imageNamed:@"placeholder_profile"];
    
    [newUser setObject:[self getPFFileFromImage:placeholder] forKey:@"profileImage"];
    [newUser setObject:@"" forKey:@"userDescription"];
        
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSString *error_string = [NSString stringWithFormat:@"%@", error.localizedDescription];
            NSLog(@"Error: %@", error_string);
            [self displayError:error_string];

        } else {
            NSLog(@"User registered successfully");
                
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            
            
        }
        
    }];
    
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

- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSString *error_string = [NSString stringWithFormat:@"%@", error.localizedDescription];
            NSLog(@"User log in failed: %@", error_string);
            [self displayError:error_string];
            
        } else {
            NSLog(@"User logged in successfully");
                
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    
}

- (void) displayError: (NSString *)error_string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:error_string
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    // display alert
    [self presentViewController:alert animated:YES completion:nil];
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
