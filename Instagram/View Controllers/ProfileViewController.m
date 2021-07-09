//
//  ProfileViewController.m
//  Instagram
//
//  Created by Elisa Jacobo Arill on 7/7/21.
//

#import "ProfileViewController.h"
#import "PostCollectionCell.h"
#import "ProfileHeaderView.h"
#import "DetailsViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (strong, nonatomic) ProfileHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.settingsButton.enabled = NO;
    
    if (!self.user) {
        self.user = [PFUser currentUser];
        self.settingsButton.enabled = YES;
    }
    
    [self setCellSize];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchUserPosts];
}

- (void)fetchUserPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"author" equalTo:self.user];
    [query includeKey:@"author"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = [NSMutableArray arrayWithArray:posts];
            
            [self.collectionView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void) setCellSize {
    // change width of images depending on width of phone
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    CGFloat postersPerLine = 3;
    CGFloat itemSize = (self.collectionView.frame.size.width - (2 * (postersPerLine-1)))/ postersPerLine;
    layout.itemSize = CGSizeMake(itemSize, itemSize);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    
    cell.post = self.posts[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProfileHeaderView" forIndexPath:indexPath];
    
    self.headerView.postCount = [NSNumber numberWithInteger:self.posts.count];
    self.headerView.user = self.user;

    return self.headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if(!self.headerView) {
        return CGSizeMake(10, 10);
    }
    
    return [self.headerView systemLayoutSizeFittingSize: CGSizeMake(collectionView.frame.size.width, UILayoutFittingExpandedSize.height) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    
   }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"profileDetailsSegue"]) {
        // Passes selected Tweet into DetailsViewController
        UICollectionViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.item];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.post = post;
    }
}
*/





@end
