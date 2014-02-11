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

#define NUMBER_OF_COMMENTS_TO_SEE_IN_LOAD_MORE 2

#define kUserProfileImageWidth 50.0f
#define kUserProfileImageHeight 50.0f
#define kUserProfileImageHorizontalInsets 20.0f
#define kUserProfileImageVerticalInsets 40.0f

#define kBodylabelVerticalInsets 10.0f
#define kBodylabelTrailingHorizontalInsets 10.0f
#define kBodylabelLeadingHorizontalInsets 10.0f
#define kBodylabelWidth 200.0f

#define kAddedImageWidth 230.0f
#define kAddedImageHeight 230.0f
#define kAddedImageHorizontalInsets 10.0f
#define kAddedImageVerticalInsets 30.0f



@interface GreetingTableViewProfileLabelImageCell : UITableViewCell

@property (strong, nonatomic) UILabel *bodyLabel;
@property (strong, nonatomic) UIImageView *userProfileImage;
@property (strong, nonatomic) UIImageView *addedImage;
@property (strong, nonatomic) UIImageView *likeImageView;
@property (strong, nonatomic) UIImageView *commentImageView;
@property (strong, nonatomic) UILabel *numOfLikesLabel;
@property (strong, nonatomic) CommentsTableView *commentsTableView;
@property (strong, nonatomic) UIButton *showAllCommentsButton;

@property (strong, nonatomic) UITableViewController *tableViewController;

- (void)updateFonts;

//- (void)initStyleForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting;
//- (void)initDataForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting;

@property (strong, nonatomic) NSMutableArray *comments;




@end
