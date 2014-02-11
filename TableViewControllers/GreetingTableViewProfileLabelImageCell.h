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

#define kBodylabelVerticalInsets 25.0f
#define kBodylabelLeadingHorizontalInsets 30.0f
#define kBodylabelWidth 200.0f

#define kAddedImageWidth 230.0f
#define kAddedImageHeight 230.0f
#define kAddedImageHorizontalInsets 10.0f
#define kAddedImageVerticalInsets 20.0f



@interface GreetingTableViewProfileLabelImageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (strong, nonatomic) IBOutlet UIImageView *addedImage;
@property (strong, nonatomic) IBOutlet UIImageView *likeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *commentImageView;
@property (strong, nonatomic) IBOutlet UILabel *numOfLikesLabel;
@property (strong, nonatomic) IBOutlet CommentsTableView *commentsTableView;
@property (strong, nonatomic) IBOutlet UIButton *showAllCommentsButton;

@property (strong, nonatomic) UITableViewController *tableViewController;

- (void)updateFonts;

//- (void)initStyleForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting;
//- (void)initDataForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting;

@property (strong, nonatomic) NSMutableArray *comments;




@end
