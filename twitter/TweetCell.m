//
//  TweetCell.m
//  twitter
//
//  Created by Maize Booker on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}
- (IBAction)didTapReply:(id)sender {
}
- (IBAction)didTapRetweet:(id)sender {
}
- (IBAction)didTapLike:(id)sender {
    if(self.tweet.favorited == NO){
        // TODO: Update the local tweet model
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [sender setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
        NSLog(@"Liked");
        // TODO: Update cell UI
        [self refreshData];
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
    else{
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [sender setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
        NSLog(@"Unliked");
        [self refreshData];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void)refreshData{
    if (self.tweet.favorited){
        [self.likeButton setSelected:YES];
    }
    else{
        [self.likeButton setSelected:NO];
    }
    

}

-(void)setUpView{
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:urlData];
    
    self.tweetTextLabel.text = self.tweet.text; // labels the cell with text
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = self.tweet.user.screenName;
    self.profilePicture.image = image;
    self.dateLabel.text = self.tweet.createdAtString;
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.favoriteCount] forState:UIControlStateNormal];
    [self.retweetButton setTitle:[NSString stringWithFormat:@"%i", self.tweet.retweetCount] forState:UIControlStateNormal];
    
}

@end
