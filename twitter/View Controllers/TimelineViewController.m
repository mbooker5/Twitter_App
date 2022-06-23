//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"


@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>
- (IBAction)didTapLogout:(id)sender;
@property (nonatomic, strong) NSMutableArray *arrayOfTweets;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    [self beginRefresh];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Return the number of rows for the table.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { //required method from UITableViewDataSource
    return self.arrayOfTweets.count; // # of cells
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{ //required method from UITableViewDataSource
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath]; //class constructor
    
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    // using indexPath
    
    
    // loading each poster image
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:urlData];

    
    cell.tweetTextLabel.text = tweet.text; // labels the cell with text
    cell.nameLabel.text = tweet.user.name;
    cell.usernameLabel.text = tweet.user.screenName;
    cell.profilePicture.image = image;
    cell.dateLabel.text = tweet.createdAtString;
    
    
    return cell;

}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfTweets = (NSMutableArray *)tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
//            for (Tweet *tweet in tweets) {
//                //NSString *text = dictionary[@"text"];
//                //come back to this if tweet text does not load
//                NSString *text = tweet.text;
//                NSLog(@"%@", text);
//            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.tableView.refreshControl endRefreshing];
    }];
}

// #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
    // Pass the selected object to the new view controller.
    
    
}


- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)didTweet:(Tweet *)tweet{
    [self.arrayOfTweets insertObject:tweet atIndex: 0];
    [self.tableView reloadData];
}
@end
