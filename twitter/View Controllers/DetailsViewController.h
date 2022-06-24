//
//  DetailsViewController.h
//  twitter
//
//  Created by Maize Booker on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface DetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *detailsView;
@property (strong, nonatomic) IBOutlet UIImageView *detailsImage;
@property (strong, nonatomic) IBOutlet UILabel *detailsName;
@property (strong, nonatomic) IBOutlet UILabel *detailsUsername;
@property (strong, nonatomic) IBOutlet UILabel *detailsDate;
@property (strong, nonatomic) IBOutlet UILabel *detailsTweet;
@property (strong, nonatomic) IBOutlet UIButton *detailsReplyButton;
@property (strong, nonatomic) IBOutlet UIButton *detailsRetweetButton;
@property (strong, nonatomic) IBOutlet UIButton *detailsLikeButton;

@property (strong, nonatomic) Tweet *tweet;
- (void) refreshData;
@end

NS_ASSUME_NONNULL_END
