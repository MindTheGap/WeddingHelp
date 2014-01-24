//
//  GreetingsTableViewController.m
//  WeddingHelp
//
//  Created by MTG on 1/18/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "GreetingsTableViewController.h"
#import "Greeting.h"
#import "UIImageView+AFNetworking.h"
#import "Like.h"
#import "Comment.h"
#import "Toast+UIView.h"
#import "WeddingHelpAppDelegate.h"
#import "ServerMessageTypes.h"


#define USERPROFILEIMAGE_TAG 1
#define FIRSTLABEL_TAG 2
#define ADDEDIMAGE_TAG 3
#define SECONDLABEL_TAG 4
#define NUMLIKES_TAG 5
#define LIKE_TAG 6
#define COMMENT_TAG 7
#define COMMENT_TV_TAG 8




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


@interface GreetingsTableViewController ()

@property (strong, nonatomic) NSMutableArray *greetings;
@property (strong, nonatomic) Greeting *lastSelectedGreeting;
@property (weak, nonatomic) WeddingHelpAppDelegate *delegate;

@end

@implementation GreetingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.greetings = [[NSMutableArray alloc] init];
    
    self.delegate = (WeddingHelpAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"Adding greetings");
    for (int i = 0; i < 2; i++)
    {
        Greeting *greeting = [[Greeting alloc] init];
        [greeting setFirstLines:[NSString stringWithFormat:@"Hello this is chen sdfsdgsdgfsd gdfgfdh drhg we tgw eg sd g sdh sd h sd g sd   f s  dfs f dfdfdfgdf d gdg dfdfdggg g gd dgdgdfsdjgfsdkg d g djghdjghjdhgd  gdmhgdjgh %d", i]];
        [greeting setUserProfileImagePath:@"http://www.online-image-editor.com/styles/2013/images/example_image.png"];
        [greeting setAddedImagePath:@"http://wowslider.com/images/demo/terse-blur/data1/images/maseratimc12racingcar.jpg"];
        greeting.likes = [[NSMutableArray alloc] init];
        greeting.comments = [[NSMutableArray alloc] init];
        [greeting.likes addObject:[[Like alloc] init]];
        [greeting.likes addObject:[[Like alloc] init]];
        Comment *comment = [[Comment alloc] init];
        [comment setText:@"This is a comment!"];
        [greeting.comments addObject:comment];
        [greeting setGreetingId: (i+1) ];
        
        [self.greetings addObject:greeting];
    }
    NSLog(@"Finished adding greetings");
    NSLog(@"Calling reload data");
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"number of rows in section %d", [self.greetings count]);
    return [self.greetings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GreetingCellIdentifier";
    
    Greeting *greeting = [self.greetings objectAtIndex:[indexPath row]];
    
    UILabel *firstLabel, *secondLabel;
    CGSize firstLabelSize;
    UIImageView *userProfileImage, *addedImage;
    UIImageView *likeImageView, *commentImageView;
    UILabel *numOfLikesLabel;
    UITableView *commentsTableView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([greeting userProfileImagePath])
        {
            NSLog(@"Creating userProfileImage in cell%d", [indexPath row]);
            
            userProfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(USERPROFILEIMAGE_X, USERPROFILEIMAGE_Y, USERPROFILEIMAGE_WIDTH,USERPROFILEIMAGE_HEIGHT)];
            userProfileImage.tag = USERPROFILEIMAGE_TAG;
            userProfileImage.autoresizingMask = UIViewAutoresizingNone;
            
            [userProfileImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[greeting userProfileImagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [UIView transitionWithView:cell.imageView
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    NSLog(@"cellForRowAtIndexPath setting user profile image view to image in greeting %d", [indexPath row]);
                                    if (image == nil)
                                        NSLog(@"image is nil!");
                                    
                                    [userProfileImage setImage:image];
                                    [greeting setUserProfileImage:image];
                                }
                                completion:NULL];
                
            }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                 NSLog(@"cellForRowAtIndexPath failed to fetch user profile image on greeting %d! error: %@", [indexPath row], error);
                                             }];

            
            [cell.contentView addSubview:userProfileImage];
        }
        
        if ([greeting firstLines])
        {
            NSAttributedString *attrFirstLines = [[NSAttributedString alloc] initWithString:[greeting firstLines]];
            CGRect firstLinesRect = [attrFirstLines boundingRectWithSize:CGSizeMake(FIRSTLABEL_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            
            NSLog(@"Creating first line in cell%d with width %f and height %f", [indexPath row], FIRSTLABEL_WIDTH, firstLinesRect.size.height);
            
            firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIRSTLABEL_X, FIRSTLABEL_Y, FIRSTLABEL_WIDTH, firstLinesRect.size.height)];
            firstLabel.tag = FIRSTLABEL_TAG;
            firstLabel.lineBreakMode = NSLineBreakByWordWrapping;
            firstLabel.numberOfLines = 0;
            firstLabel.font = [UIFont systemFontOfSize:14.0];
            firstLabel.textAlignment = NSTextAlignmentLeft;
            firstLabel.textColor = [UIColor blackColor];
            firstLabel.autoresizingMask = UIViewAutoresizingNone;
            [cell.contentView addSubview:firstLabel];
        }
        
        if ([greeting addedImagePath])
        {
            NSLog(@"Creating addedImage in cell%d", [indexPath row]);
            
            CGFloat addedImageY = MAX(USERPROFILEIMAGE_Y + USERPROFILEIMAGE_HEIGHT, FIRSTLABEL_Y + firstLabelSize.height) + ADDEDIMAGE_MARGIN_TOP;
            
            addedImage = [[UIImageView alloc] initWithFrame:CGRectMake(ADDEDIMAGE_X, addedImageY, ADDEDIMAGE_WIDTH, ADDEDIMAGE_HEIGHT)];
            addedImage.tag = ADDEDIMAGE_TAG;
            addedImage.autoresizingMask = UIViewAutoresizingNone;
            
            [addedImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[greeting addedImagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [UIView transitionWithView:cell.imageView
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    NSLog(@"cellForRowAtIndexPath setting added image view to image in greeting %d", [indexPath row]);
                                    if (image == nil)
                                        NSLog(@"added image on greeting %d is nil!", [indexPath row]);
                                    
                                    [addedImage setImage:image];
                                    [greeting setAddedImage:image];
                                }
                                completion:NULL];
                
            }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                 NSLog(@"cellForRowAtIndexPath failed to fetch added image on greeting %d! error: %@", [indexPath row], error);
                                             }];

            
            [cell.contentView addSubview:addedImage];
        }
        
        CGFloat buttonsHeight = MAX(addedImage.frame.origin.y + addedImage.frame.size.height, firstLabel.frame.origin.y + firstLabel.frame.size.height) + 10.0;
        
        // add like image button
        likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"like.png"]];
        UITapGestureRecognizer *likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeClicked:)];
        [likeImageView setUserInteractionEnabled:YES];
        [likeTap setNumberOfTapsRequired:1];
        [likeImageView addGestureRecognizer:likeTap];
        [likeImageView setFrame:CGRectMake(180.0, buttonsHeight, 30.0, 25.0)];
        [likeImageView setTag:LIKE_TAG];
        [cell.contentView addSubview:likeImageView];
        
        // add comment image button
        commentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment.png"]];
        UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentClicked:)];
        [commentTap setNumberOfTapsRequired:1];
        [commentImageView setUserInteractionEnabled:YES];
        [commentImageView addGestureRecognizer:commentTap];
        [commentImageView setFrame:CGRectMake(230.0, buttonsHeight, 30.0, 25.0)];
        [commentImageView setTag:[indexPath row]];
        commentImageView.tag = COMMENT_TAG;
        [cell.contentView addSubview:commentImageView];
        
        // add number of likes uilabel
        numOfLikesLabel = [[UILabel alloc] initWithFrame:CGRectMake(USERPROFILEIMAGE_X + 10.0, buttonsHeight, 100.0, 13.0)];
        NSString *numberOfLikesString = [NSString stringWithFormat:@"%d liked", [[greeting likes] count]];
        [numOfLikesLabel setText:numberOfLikesString];
        numOfLikesLabel.tag = NUMLIKES_TAG;
        [cell.contentView addSubview:numOfLikesLabel];

        
        UIColor *lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
        CGFloat borderHeight = MAX(MAX(addedImage.frame.origin.y + addedImage.frame.size.height, secondLabel.frame.origin.y + secondLabel.frame.size.height), firstLabel.frame.origin.y + firstLabel.frame.size.height) - 30.0;
        CGRect borderRect = CGRectMake(15.0, 35.0, 300.0, borderHeight);
        UIView *outlineBorderView = [[UIView alloc] initWithFrame:borderRect];
        outlineBorderView.layer.borderColor = lightGrayColor.CGColor;
        outlineBorderView.layer.borderWidth = 1.0f;
        [cell.contentView addSubview:outlineBorderView];
        
        if ([greeting comments])
        {
            NSLog(@"Creating comments in cell%d", [indexPath row]);
            
            UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"iPhone5Storyboard"
                                                          bundle:nil];
            
            commentsTableView = [sb instantiateViewControllerWithIdentifier:@"CommentsTableViewControllerIdentifier"];
            [commentsTableView setFrame:CGRectMake(20.0, 300.0, 250.0, 100.0)];
            commentsTableView.tag = COMMENT_TV_TAG;
            commentsTableView.autoresizingMask = UIViewAutoresizingNone;
            [cell.contentView addSubview:commentsTableView];
        }
    }
    else
    {
        NSLog(@"Greeting %d, just getting items from cell by tags!", [indexPath row]);
        firstLabel = (UILabel *)[cell.contentView viewWithTag:FIRSTLABEL_TAG];
        secondLabel = (UILabel *)[cell.contentView viewWithTag:SECONDLABEL_TAG];
        addedImage = (UIImageView *)[cell.contentView viewWithTag:ADDEDIMAGE_TAG];
        userProfileImage = (UIImageView *)[cell.contentView viewWithTag:USERPROFILEIMAGE_TAG];
        likeImageView = (UIImageView *)[cell.contentView viewWithTag:LIKE_TAG];
        commentImageView = (UIImageView *)[cell.contentView viewWithTag:COMMENT_TAG];
        numOfLikesLabel = (UILabel *)[cell.contentView viewWithTag:NUMLIKES_TAG];
    }
    
    
    [firstLabel setText:[greeting firstLines]];
    [secondLabel setText:[greeting secondLines]];
    [numOfLikesLabel setText:[NSString stringWithFormat:@"%d liked", [greeting.likes count]]];
    
    return cell;
}

- (void)commentClicked:(UITapGestureRecognizer *)sender
{
    NSLog(@"Comment clicked");
    
    UIImageView *imageView = (UIImageView *)sender.view;
    CGPoint hitPoint = [imageView convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSInteger row = [hitIndex row];
    Greeting *greeting = [self.greetings objectAtIndex:row];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:hitIndex];
    UIView *commentView = [cell viewWithTag:COMMENT_TAG];

    [self.tableView setContentOffset:CGPointMake(0, commentView.frame.origin.y + (cell.frame.origin.y * row) - 20.0) animated:YES];
    
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
    
    UIImageView *imageView = (UIImageView *)sender.view;
    CGPoint hitPoint = [imageView convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    NSInteger row = [hitIndex row];
    Greeting *greeting = [self.greetings objectAtIndex:row];
    
    [self.view makeToast:nil
                duration:0.6
                position:@"center"
                   image:[UIImage imageNamed:@"heartlike.png"]];
        
    Like *like = [[Like alloc] init];
    [like setObject:greeting];
    [[greeting likes] addObject:like];
    [self.tableView reloadRowsAtIndexPaths:@[hitIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:[self.delegate email], @"Email", [NSString stringWithFormat:@"%d",[greeting greetingId]], @"GreetingId", [NSString stringWithFormat:@"%d", LikeGreeting], @"type", nil];
    [[self.delegate commManager] sendObject:object completion:^(NSDictionary *json)
     {
         NSNumber *type = [json objectForKey:@"Type"];
         
         if ([type intValue] != AOK)
         {
             NSLog(@"LikeGreeting: Server returned something different than AOK!");
         }
     }];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
