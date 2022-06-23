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
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
    [self refreshData];
    // TODO: Send a POST request to the POST favorites/create endpoint
}

- (void)refreshData{
    if (self.tweet.favorited){
        [self.likeButton setSelected:YES];
    }
    

}

@end