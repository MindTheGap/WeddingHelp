//
//  GreetingTableViewCell.h
//  WeddingHelp
//
//  Created by MTG on 1/25/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Greeting.h"
#import "CommentsTableView.h"

@interface GreetingTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *firstLabel;
@property (strong, nonatomic) UILabel *secondLabel;
@property (strong, nonatomic) UIImageView *userProfileImage;
@property (strong, nonatomic) UIImageView *addedImage;
@property (strong, nonatomic) UIImageView *likeImageView;
@property (strong, nonatomic) UIImageView *commentImageView;
@property (strong, nonatomic) UILabel *numOfLikesLabel;
@property (strong, nonatomic) CommentsTableView *commentsTableView;
@property (strong, nonatomic) UIButton *showAllCommentsButton;

- (void)initStyleForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting;
- (void)initDataForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting;

@property (strong, nonatomic) NSMutableArray *comments;




@end
