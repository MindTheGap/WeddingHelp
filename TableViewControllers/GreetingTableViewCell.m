//
//  GreetingTableViewCell.m
//  WeddingHelp
//
//  Created by MTG on 1/25/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "GreetingTableViewCell.h"
#import "Greeting.h"
#import "UIImageView+AFNetworking.h"
#import "CommentTableViewCell.h"
#import "Comment.h"


#define USERPROFILEIMAGE_WIDTH 50.0
#define USERPROFILEIMAGE_HEIGHT 50.0
#define USERPROFILEIMAGE_X 20.0
#define USERPROFILEIMAGE_Y 40.0

#define FIRSTLABEL_MARGIN_TOP 10.0
#define FIRSTLABEL_MARGIN_LEFT 10.0
#define FIRSTLABEL_X USERPROFILEIMAGE_X + USERPROFILEIMAGE_WIDTH + FIRSTLABEL_MARGIN_LEFT
#define FIRSTLABEL_Y USERPROFILEIMAGE_Y + FIRSTLABEL_MARGIN_TOP
#define FIRSTLABEL_WIDTH 200.0

#define ADDEDIMAGE_WIDTH 230.0
#define ADDEDIMAGE_HEIGHT 230.0
#define ADDEDIMAGE_MARGIN_LEFT 10.0
#define ADDEDIMAGE_MARGIN_TOP 30.0
#define ADDEDIMAGE_X USERPROFILEIMAGE_X + ADDEDIMAGE_MARGIN_LEFT
// ADDEDIMAGE_Y is calculated dynamically because we need the maximum between first label height and userprofile height



@implementation GreetingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initStyleForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting
{
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if ([greeting userProfileImagePath])
    {
        NSLog(@"Creating userProfileImage in cell%d", [indexPath row]);
        
        self.userProfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(USERPROFILEIMAGE_X, USERPROFILEIMAGE_Y, USERPROFILEIMAGE_WIDTH,USERPROFILEIMAGE_HEIGHT)];
        [self.userProfileImage setAutoresizingMask:UIViewAutoresizingNone];
        
        [self.userProfileImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[greeting userProfileImagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [UIView transitionWithView:_userProfileImage
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                NSLog(@"cellForRowAtIndexPath setting user profile image view to image in greeting %d", [indexPath row]);
                                if (image == nil)
                                    NSLog(@"image is nil!");
                                
                                [self.userProfileImage setImage:image];
                                [greeting setUserProfileImage:image];
                            }
                            completion:NULL];
            
        }
                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                    NSLog(@"cellForRowAtIndexPath failed to fetch user profile image on greeting %d! error: %@", [indexPath row], error);
                                                }];
        
        
        [self.contentView addSubview:self.userProfileImage];
    }
    
    if ([greeting firstLines])
    {
        NSAttributedString *attrFirstLines = [[NSAttributedString alloc] initWithString:[greeting firstLines]];
        CGRect firstLinesRect = [attrFirstLines boundingRectWithSize:CGSizeMake(FIRSTLABEL_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        NSLog(@"Creating first line in cell%d with width %f and height %f", [indexPath row], FIRSTLABEL_WIDTH, firstLinesRect.size.height);
        
        self.firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIRSTLABEL_X, FIRSTLABEL_Y, FIRSTLABEL_WIDTH, firstLinesRect.size.height)];
        [self.firstLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.firstLabel setNumberOfLines:0];
        [self.firstLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.firstLabel setTextAlignment:NSTextAlignmentLeft];
        [self.firstLabel setTextColor:[UIColor blackColor]];
        [self.firstLabel setAutoresizingMask:UIViewAutoresizingNone];
        [self.contentView addSubview:self.firstLabel];
    }
    
    if ([greeting addedImagePath])
    {
        NSLog(@"Creating addedImage in cell%d", [indexPath row]);
        
        CGFloat addedImageY = MAX(USERPROFILEIMAGE_Y + USERPROFILEIMAGE_HEIGHT, FIRSTLABEL_Y) + ADDEDIMAGE_MARGIN_TOP;
        
        self.addedImage = [[UIImageView alloc] initWithFrame:CGRectMake(ADDEDIMAGE_X, addedImageY, ADDEDIMAGE_WIDTH, ADDEDIMAGE_HEIGHT)];
        [self.addedImage setAutoresizingMask:UIViewAutoresizingNone];
        
        [self.addedImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[greeting addedImagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [UIView transitionWithView:self.addedImage
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                NSLog(@"cellForRowAtIndexPath setting added image view to image in greeting %d", [indexPath row]);
                                if (image == nil)
                                    NSLog(@"added image on greeting %d is nil!", [indexPath row]);
                                
                                [self.addedImage setImage:image];
                                [greeting setAddedImage:image];
                            }
                            completion:NULL];
            
        }
                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                              NSLog(@"cellForRowAtIndexPath failed to fetch added image on greeting %d! error: %@", [indexPath row], error);
                                          }];
        
        
        [self.contentView addSubview:self.addedImage];
    }
    
    CGFloat buttonsHeight = MAX(self.addedImage.frame.origin.y + self.addedImage.frame.size.height, self.firstLabel.frame.origin.y + self.firstLabel.frame.size.height) + 10.0;
    
    // add like image button
    self.likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like.png"]];
    UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeClicked:)];
    [self.likeImageView setUserInteractionEnabled:YES];
    [likeTap setNumberOfTapsRequired:1];
    [self.likeImageView addGestureRecognizer:likeTap];
    [self.likeImageView setFrame:CGRectMake(180.0, buttonsHeight, 30.0, 25.0)];
    [self.contentView addSubview:self.likeImageView];
    
    // add comment image button
    self.commentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment.png"]];
    UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentClicked:)];
    [commentTap setNumberOfTapsRequired:1];
    [self.commentImageView setUserInteractionEnabled:YES];
    [self.commentImageView addGestureRecognizer:commentTap];
    [self.commentImageView setFrame:CGRectMake(230.0, buttonsHeight, 30.0, 25.0)];
    [self.contentView addSubview:self.commentImageView];
    
    // add number of likes uilabel
    self.numOfLikesLabel = [[UILabel alloc] initWithFrame:CGRectMake(USERPROFILEIMAGE_X + 10.0, buttonsHeight, 100.0, 13.0)];
    NSString *numberOfLikesString = [NSString stringWithFormat:@"%d liked", [[greeting likes] count]];
    [self.numOfLikesLabel setText:numberOfLikesString];
    [self.contentView addSubview:self.numOfLikesLabel];
    
    
    UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
    CGFloat borderHeight = MAX(MAX(self.addedImage.frame.origin.y + self.addedImage.frame.size.height, self.secondLabel.frame.origin.y + self.frame.size.height), self.firstLabel.frame.origin.y + self.firstLabel.frame.size.height) - 30.0;
    CGRect borderRect = CGRectMake(15.0, 35.0, 300.0, borderHeight);
    UIView *outlineBorderView = [[UIView alloc] initWithFrame:borderRect];
    outlineBorderView.layer.borderColor = lightGrayColor.CGColor;
    outlineBorderView.layer.borderWidth = 1.0f;
    [self.contentView addSubview:outlineBorderView];
    
    
    
    if ([greeting comments])
    {
        NSLog(@"Creating comments in cell%d", [indexPath row]);
        
        CGRect commentsRect;
        if ([[greeting comments] count] > 2)
        {
            self.showAllCommentsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [self.showAllCommentsButton setFrame:CGRectMake(20.0, 400.0, 280.0, 30.0)];
            [self.showAllCommentsButton setTitle:[NSString stringWithFormat:@"Load all %d comments", [[greeting comments] count]] forState:UIControlStateNormal];
            
            [self.contentView addSubview:self.showAllCommentsButton];
            
            commentsRect = CGRectMake(20.0, 430.0, 280.0, 500.0);
        }
        else
        {
            CGRectMake(20.0, 400.0, 280.0, 500.0);
        }
        
        self.commentsTableView = [[CommentsTableView alloc] initWithFrame:commentsRect];
        [self.commentsTableView setScrollEnabled:NO];
        [self.commentsTableView setAutoresizingMask:UIViewAutoresizingNone];
        [self.commentsTableView setComments:[greeting comments]];
        [self.commentsTableView initData];
        [self.commentsTableView setDelegate:self.commentsTableView];
        [self.commentsTableView setDataSource:self.commentsTableView];
        
        [self.commentsTableView initTableViewHeight];
//        [self.commentsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([[greeting comments] count] - 2) inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        [self.contentView addSubview:(UIView *)self.commentsTableView];
    }
}

- (void)initDataForIndexPath:(NSIndexPath *)indexPath forGreeting:(Greeting *)greeting
{
    [self.firstLabel setText:[greeting firstLines]];
    [self.secondLabel setText:[greeting secondLines]];
    [self.numOfLikesLabel setText:[NSString stringWithFormat:@"%d liked", [greeting.likes count]]];
    self.comments = [greeting comments];
}

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
