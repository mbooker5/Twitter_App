//
//  ComposeViewController.m
//  twitter
//
//  Created by Maize Booker on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (IBAction)closeTweetComposer:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

// method for if the "Tweet" button in the top right of the view was tapped
- (IBAction)postTweet:(id)sender {
    [[APIManager shared]  postStatusWithText:(NSString *)self.textView.text completion:^(Tweet *tweet, NSError *error) {
        if (error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}


@end
