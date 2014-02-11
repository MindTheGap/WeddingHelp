//
//  GreetingTableViewCell.m
//  WeddingHelp
//
//  Created by MTG on 1/25/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "GreetingTableViewProfileLabelImageCell.h"
#import "Greeting.h"
#import "UIImageView+AFNetworking.h"
#import "CommentTableViewCell.h"
#import "Comment.h"
#import "UIView+AutoLayout.h"

@interface GreetingTableViewProfileLabelImageCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation GreetingTableViewProfileLabelImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        self.userProfileImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.userProfileImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.userProfileImage setContentMode:UIViewContentModeCenter];
        
        self.addedImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.addedImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.addedImage setContentMode:UIViewContentModeCenter];

        self.bodyLabel = [UILabel newAutoLayoutView];
        [self.bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.bodyLabel setNumberOfLines:0];
        [self.bodyLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bodyLabel setTextColor:[UIColor darkGrayColor]];
        [self.bodyLabel setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.1]];
        
        self.likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.likeImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.likeImageView setContentMode:UIViewContentModeCenter];

        self.commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.commentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.commentImageView setContentMode:UIViewContentModeCenter];
        
        self.numOfLikesLabel = [UILabel newAutoLayoutView];
        [self.numOfLikesLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.numOfLikesLabel setNumberOfLines:1];
        [self.numOfLikesLabel setTextAlignment:NSTextAlignmentLeft];
        [self.numOfLikesLabel setTextColor:[UIColor darkGrayColor]];
        
        [self.contentView addSubview:self.userProfileImage];
        [self.contentView addSubview:self.addedImage];
        [self.contentView addSubview:self.bodyLabel];
        [self.contentView addSubview:self.likeImageView];
        [self.contentView addSubview:self.commentImageView];
        [self.contentView addSubview:self.numOfLikesLabel];

        [self updateFonts];
    }
    
    return self;
}

- (void)updateFonts
{
    self.numOfLikesLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // The below call to layoutSubviews on the table view cell's contentView should NOT be necessary.
    // However, in some (but not all!) cases it appears as though the super implementation does not call
    // layoutSubviews on the contentView, which causes all the UILabels to have a frame of CGRectZero.
    [self.contentView layoutSubviews];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints) return; // If constraints have been set, don't do anything.
    
    // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
    // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
    //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
    // self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
    
    [self.userProfileImage setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.userProfileImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kUserProfileImageVerticalInsets];
    [self.userProfileImage autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kUserProfileImageHorizontalInsets];
    [self.userProfileImage autoSetDimension:ALDimensionWidth toSize:kUserProfileImageWidth];
    [self.userProfileImage autoSetDimension:ALDimensionHeight toSize:kUserProfileImageHeight];

    [self.bodyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kBodylabelVerticalInsets];
    [self.bodyLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeRight ofView:self.userProfileImage withOffset:kBodylabelTrailingHorizontalInsets];
    [self.bodyLabel autoSetDimension:ALDimensionWidth toSize:kBodylabelWidth];
    
    [self.addedImage setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.addedImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.bodyLabel withOffset:kAddedImageVerticalInsets];
    [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:kAddedImageHorizontalInsets];
    [self.addedImage autoSetDimension:ALDimensionWidth toSize:kAddedImageWidth];
    [self.addedImage autoSetDimension:ALDimensionHeight toSize:kAddedImageHeight];
    
    self.didSetupConstraints = YES;
}



//- (void)initStyleForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting
//{
//    self.accessoryType = UITableViewCellAccessoryNone;
//    
//    if ([greeting userProfileImagePath])
//    {
//        NSLog(@"Creating userProfileImage in cell%d", [indexPath row]);
//        
//        self.userProfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(USERPROFILEIMAGE_X, USERPROFILEIMAGE_Y, USERPROFILEIMAGE_WIDTH,USERPROFILEIMAGE_HEIGHT)];
//        [self.userProfileImage setAutoresizingMask:UIViewAutoresizingNone];
//        
//        [self.userProfileImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[greeting userProfileImagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            [UIView transitionWithView:_userProfileImage
//                              duration:0.3
//                               options:UIViewAnimationOptionTransitionCrossDissolve
//                            animations:^{
//                                NSLog(@"cellForRowAtIndexPath setting user profile image view to image in greeting %d", [indexPath row]);
//                                if (image == nil)
//                                    NSLog(@"image is nil!");
//                                
//                                [self.userProfileImage setImage:image];
//                                [greeting setUserProfileImage:image];
//                            }
//                            completion:NULL];
//            
//        }
//                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                                    NSLog(@"cellForRowAtIndexPath failed to fetch user profile image on greeting %d! error: %@", [indexPath row], error);
//                                                }];
//        
//        
//        [self.contentView addSubview:self.userProfileImage];
//    }
//    
//    if ([greeting firstLines])
//    {
//        NSAttributedString *attrFirstLines = [[NSAttributedString alloc] initWithString:[greeting firstLines]];
//        CGRect firstLinesRect = [attrFirstLines boundingRectWithSize:CGSizeMake(FIRSTLABEL_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//        
//        NSLog(@"Creating first line in cell%d with width %f and height %f", [indexPath row], FIRSTLABEL_WIDTH, firstLinesRect.size.height);
//        
//        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIRSTLABEL_X, FIRSTLABEL_Y, FIRSTLABEL_WIDTH, firstLinesRect.size.height)];
//        [self.firstLabel setLineBreakMode:NSLineBreakByWordWrapping];
//        [self.firstLabel setNumberOfLines:0];
//        [self.firstLabel setFont:[UIFont systemFontOfSize:14.0]];
//        [self.firstLabel setTextAlignment:NSTextAlignmentLeft];
//        [self.firstLabel setTextColor:[UIColor blackColor]];
//        [self.firstLabel setAutoresizingMask:UIViewAutoresizingNone];
//        [self.contentView addSubview:self.firstLabel];
//    }
//    
//    if ([greeting addedImagePath])
//    {
//        NSLog(@"Creating addedImage in cell%d", [indexPath row]);
//        
//        CGFloat addedImageY = MAX(USERPROFILEIMAGE_Y + USERPROFILEIMAGE_HEIGHT, FIRSTLABEL_Y) + ADDEDIMAGE_MARGIN_TOP;
//        
//        self.addedImage = [[UIImageView alloc] initWithFrame:CGRectMake(ADDEDIMAGE_X, addedImageY, ADDEDIMAGE_WIDTH, ADDEDIMAGE_HEIGHT)];
//        [self.addedImage setAutoresizingMask:UIViewAutoresizingNone];
//        
//        [self.addedImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[greeting addedImagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            [UIView transitionWithView:self.addedImage
//                              duration:0.3
//                               options:UIViewAnimationOptionTransitionCrossDissolve
//                            animations:^{
//                                NSLog(@"cellForRowAtIndexPath setting added image view to image in greeting %d", [indexPath row]);
//                                if (image == nil)
//                                    NSLog(@"added image on greeting %d is nil!", [indexPath row]);
//                                
//                                [self.addedImage setImage:image];
//                                [greeting setAddedImage:image];
//                            }
//                            completion:NULL];
//            
//        }
//                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                              NSLog(@"cellForRowAtIndexPath failed to fetch added image on greeting %d! error: %@", [indexPath row], error);
//                                          }];
//        
//        
//        [self.contentView addSubview:self.addedImage];
//    }
//    
//    CGFloat buttonsHeight = MAX(self.addedImage.frame.origin.y + self.addedImage.frame.size.height, self.firstLabel.frame.origin.y + self.firstLabel.frame.size.height) + 10.0;
//    
//    // add like image button
//    self.likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like.png"]];
//    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeClicked:)];
//    [self.likeImageView setUserInteractionEnabled:YES];
//    [likeTap setNumberOfTapsRequired:1];
//    [self.likeImageView addGestureRecognizer:likeTap];
//    [self.likeImageView setFrame:CGRectMake(180.0, buttonsHeight, 30.0, 25.0)];
//    [self.contentView addSubview:self.likeImageView];
//    
//    // add comment image button
//    self.commentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment.png"]];
//    UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentClicked:)];
//    [commentTap setNumberOfTapsRequired:1];
//    [self.commentImageView setUserInteractionEnabled:YES];
//    [self.commentImageView addGestureRecognizer:commentTap];
//    [self.commentImageView setFrame:CGRectMake(230.0, buttonsHeight, 30.0, 25.0)];
//    [self.contentView addSubview:self.commentImageView];
//    
//    // add number of likes uilabel
//    self.numOfLikesLabel = [[UILabel alloc] initWithFrame:CGRectMake(USERPROFILEIMAGE_X + 10.0, buttonsHeight, 100.0, 13.0)];
//    NSString *numberOfLikesString = [NSString stringWithFormat:@"%d liked", [[greeting likes] count]];
//    [self.numOfLikesLabel setText:numberOfLikesString];
//    [self.contentView addSubview:self.numOfLikesLabel];
//    
//    
//    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
//    CGFloat borderHeight = MAX(MAX(self.addedImage.frame.origin.y + self.addedImage.frame.size.height, self.secondLabel.frame.origin.y + self.frame.size.height), self.firstLabel.frame.origin.y + self.firstLabel.frame.size.height) - 30.0;
//    CGRect borderRect = CGRectMake(15.0, 35.0, 300.0, borderHeight);
//    UIView *outlineBorderView = [[UIView alloc] initWithFrame:borderRect];
//    outlineBorderView.layer.borderColor = lightGrayColor.CGColor;
//    outlineBorderView.layer.borderWidth = 1.0f;
//    [self.contentView addSubview:outlineBorderView];
//    
//    
//    
//    if ([greeting comments])
//    {
//        NSLog(@"Creating comments in cell%d", [indexPath row]);
//        
//        CGRect commentsRect;
//        if ([[greeting comments] count] > NUMBER_OF_COMMENTS_TO_SEE_IN_LOAD_MORE)
//        {
//            self.showAllCommentsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [self.showAllCommentsButton setFrame:CGRectMake(20.0, 400.0, 280.0, 30.0)];
//            [self.showAllCommentsButton setTitle:[NSString stringWithFormat:@"Load all %d comments", [[greeting comments] count]] forState:UIControlStateNormal];
//            [self.showAllCommentsButton addTarget:self action:@selector(handleShowAllCommentsButtonClicked:) forControlEvents:UIControlEventTouchDown];
//            
//            [self.contentView addSubview:self.showAllCommentsButton];
//            
//            commentsRect = CGRectMake(20.0, 430.0, 280.0, 500.0);
//        }
//        else
//        {
//            CGRectMake(20.0, 400.0, 280.0, 500.0);
//        }
//        
//        self.commentsTableView = [[CommentsTableView alloc] initWithFrame:commentsRect];
//        [self.commentsTableView setScrollEnabled:NO];
//        [self.commentsTableView setAutoresizingMask:UIViewAutoresizingNone];
//        [self.commentsTableView setComments:[greeting comments]];
//        [self.commentsTableView initData];
//        [self.commentsTableView setDelegate:self.commentsTableView];
//        [self.commentsTableView setDataSource:self.commentsTableView];
//        [self.commentsTableView initTableViewHeight];
//        
//        
////        [self.commentsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([[greeting comments] count] - 2) inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//        
//        [self.contentView addSubview:(UIView *)self.commentsTableView];
//    }
//}

- (void) handleShowAllCommentsButtonClicked:(UIButton *)sender
{
    [self.showAllCommentsButton setHidden:YES];
    [[self.tableViewController tableView] reloadData];
    [self.commentsTableView handleShowAllCommentsButtonClicked:sender];
    
}

//- (void)initDataForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting
//{
//    [self.firstLabel setText:[greeting firstLines]];
//    [self.secondLabel setText:[greeting secondLines]];
//    [self.numOfLikesLabel setText:[NSString stringWithFormat:@"%d liked", [greeting.likes count]]];
//    self.comments = [greeting comments];
//}

- (void)commentClicked:(UITapGestureRecognizer *)sender
{
    NSLog(@"Comment clicked");
    
    //    UIImageView *imageView = (UIImageView *)sender.view;
    //    CGPoint hitPoint = [imageView convertPoint:CGPointZero toView:self.tableView];
    //    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    //    NSInteger row = [hitIndex row];
    //    Greeting *greeting = [self.greetings objectAtIndex:row];
    //    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:hitIndex];
    //    UIView *commentView = [cell viewWithTag:COMMENT_TAG];
    //
    //    [self.tableView setContentOffset:CGPointMake(0, commentView.frame.origin.y + (cell.frame.origin.y * row) - 20.0) animated:YES];
    
    //    [self.tableView scrollToRowAtIndexPath:hitIndex
    //                     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //    [self.view makeToast:nil
    //                duration:0.6
    //                position:@"center"
    //                   image:[UIImage imageNamed:@"heartlike.png"]];
    //
    //    Like *like = [[Like alloc] init];
    //    [like setObject:greeting];
    //    [[greeting likes] addObject:like];
    //    [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    //
    //    NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:[self.delegate email], @"Email", [NSString stringWithFormat:@"%d",[greeting greetingId]], @"GreetingId", [NSString stringWithFormat:@"%d", LikeGreeting], @"type", nil];
    //    [[self.delegate commManager] sendObject:object completion:^(NSDictionary *json)
    //     {
    //         NSNumber *type = [json objectForKey:@"Type"];
    //
    //         if ([type intValue] != AOK)
    //         {
    //             NSLog(@"LikeGreeting: Server returned something different than AOK!");
    //         }
    //     }];
}


- (void)likeClicked:(UITapGestureRecognizer *)sender
{
    NSLog(@"Like clicked");
    
    //    UIImageView *imageView = (UIImageView *)sender.view;
    //    CGPoint hitPoint = [imageView convertPoint:CGPointZero toView:self.tableView];
    //    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    //    NSInteger row = [hitIndex row];
    //    Greeting *greeting = [self.greetings objectAtIndex:row];
    //
    //    [self.view makeToast:nil
    //                duration:0.6
    //                position:@"center"
    //                   image:[UIImage imageNamed:@"heartlike.png"]];
    //
    //    Like *like = [[Like alloc] init];
    //    [like setObject:greeting];
    //    [[greeting likes] addObject:like];
    //    [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    //
    //    NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:[self.delegate email], @"Email", [NSString stringWithFormat:@"%d",[greeting greetingId]], @"GreetingId", [NSString stringWithFormat:@"%d", LikeGreeting], @"type", nil];
    //    [[self.delegate commManager] sendObject:object completion:^(NSDictionary *json)
    //     {
    //         NSNumber *type = [json objectForKey:@"Type"];
    //
    //         if ([type intValue] != AOK)
    //         {
    //             NSLog(@"LikeGreeting: Server returned something different than AOK!");
    //         }
    //     }];
    
}




@end
