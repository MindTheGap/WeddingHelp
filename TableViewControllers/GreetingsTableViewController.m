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
#import "CommentTableViewCell.h"
#import "GreetingTableViewProfileLabelImageCell.h"


#define USERPROFILEIMAGE_TAG 1
#define FIRSTLABEL_TAG 2
#define ADDEDIMAGE_TAG 3
#define SECONDLABEL_TAG 4
#define NUMLIKES_TAG 5
#define LIKE_TAG 6
#define COMMENT_TAG 7
#define COMMENT_TV_TAG 8


static NSString *GreetingsTableViewProfileLabelImageCellIdentifier = @"GreetingsTableViewProfileLabelImageCellIdentifier";





@interface GreetingsTableViewController ()

@property (strong, nonatomic) NSMutableArray *greetings;
@property (strong, nonatomic) Greeting *lastSelectedGreeting;
@property (weak, nonatomic) WeddingHelpAppDelegate *delegate;
@property (strong, nonatomic) CommentTableViewCell *commentSampleCell;

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
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.tableView registerClass:[GreetingTableViewProfileLabelImageCell class] forCellReuseIdentifier:GreetingsTableViewProfileLabelImageCellIdentifier];
    
    self.tableView.allowsSelection = NO;

    
    self.greetings = [[NSMutableArray alloc] init];
    
    self.delegate = (WeddingHelpAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    static NSString *CellNib = @"CommentTableViewCell";
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
    if ([nib count] == 0)
    {
        NSLog(@"Greetings ERROR: can't find comment cell nib!");
    }
    else
    {
        self.commentSampleCell = (CommentTableViewCell *)[nib objectAtIndex:0];
    }
    
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
        Comment *comment2 = [[Comment alloc] init];
        Comment *comment3 = [[Comment alloc] init];
        Comment *comment4 = [[Comment alloc] init];
        Comment *comment5 = [[Comment alloc] init];
        [comment setText:@"This is a comment!"];
        [comment3 setText:@"This is a comment4353!"];
        [comment4 setText:@"This is a commen53453453t!"];
        [comment5 setText:@"This is a comm53453ent!"];
        [comment2 setText:@"This is a another really long comment. do you know what day it is today? it's a holiday! I'm so excited! let me see that more button! My name is chen and I love Eti! I know you know that already but I wanted to tell you again anyway!!"];
        [greeting.comments addObject:comment];
        [greeting.comments addObject:comment2];
        [greeting.comments addObject:comment3];
        [greeting.comments addObject:comment4];
        [greeting.comments addObject:comment5];
        
        [greeting setGreetingId: (i+1) ];
        
        [self.greetings addObject:greeting];
    }
    NSLog(@"Finished adding greetings");
    NSLog(@"Calling reload data");
    [self.tableView reloadData];
    NSLog(@"after greetings reloadData");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GreetingTableViewProfileLabelImageCell *cell = [tableView dequeueReusableCellWithIdentifier:GreetingsTableViewProfileLabelImageCellIdentifier];
    
    Greeting *greeting = [self.greetings objectAtIndex:[indexPath row]];
    
    // Configure the cell for this indexPath
    [cell updateFonts];
    
    NSString *bodyText = [greeting firstLines];
    NSMutableAttributedString *bodyAttributedText = [[NSMutableAttributedString alloc] initWithString:bodyText];
    NSMutableParagraphStyle *bodyParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [bodyParagraphStyle setLineSpacing:10.0f];
    [bodyAttributedText addAttribute:NSParagraphStyleAttributeName value:bodyParagraphStyle range:NSMakeRange(0, bodyText.length)];
    cell.bodyLabel.attributedText = bodyAttributedText;
    
    cell.userProfileImage.image = [greeting userProfileImage] ? [greeting userProfileImage] : [UIImage imageNamed:@"anonymous.png"];
    cell.addedImage.image = [greeting addedImage] ? [greeting addedImage] : [UIImage imageNamed:@"anonymous.png"];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // Set the width of the cell to match the width of the table view. This is important so that we'll get the
    // correct height for different table view widths, since our cell's height depends on its width due to
    // the multi-line UILabel word wrapping. Don't need to do this above in -[tableView:cellForRowAtIndexPath]
    // because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"heightForRowAtIndexPath is %f for row %d", height, [indexPath row]);
    if (height == 0.0f)
    {
        height = 800.0f;
    }
    
    // Add an extra point to the height to account for internal rounding errors that are occasionally observed in
    // the Auto Layout engine, which cause the returned height to be slightly too small in some cases.
    height += 1;
    
    return height;
    

    
//    NSInteger row = [indexPath row];
//    Greeting *greeting = [self.greetings objectAtIndex:row];
//    NSArray *comments = [greeting comments];
//    CGFloat height = 0.0f;
//    
//    if (![self.cells count])
//    {
//        return 800.0;
//    }
//    else
//    {
//        GreetingTableViewCell *cell = [self.cells objectAtIndex:row];
//        assert(cell);
//        
//        height = [[cell contentView] frame].size.height;
//    }
    
//
//    if ([comments count] > NUMBER_OF_COMMENTS_TO_SEE_IN_LOAD_MORE)
//    {
//        height += 30.0f;
//    }
//    if ([greeting comments])
//    {
//        if ([self.cells count])
//        {
//            NSLog(@"greeting has comments so calulcating based on frame!");
//            GreetingTableViewCell *cell = [self.cells objectAtIndex:row];
//            if (cell)
//            {
//                CGRect rect = [[cell commentsTableView] frame];
//                height += rect.size.height;
//                
//            }
//        }
//        else
//        {
//            for (int i = [comments count] - 1; i >= [comments count] - NUMBER_OF_COMMENTS_TO_SEE_IN_LOAD_MORE; i--)
//            {
//                Comment *comment = [comments objectAtIndex:i];
//                
//                UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
//                NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
//                                                                            forKey:NSFontAttributeName];
//                NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[comment text] attributes:attrsDictionary];
//                
//                CGFloat width = [[self.commentSampleCell mainLabel] bounds].size.width;
//                CGRect textRect = [attrText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil];
//                
//                height += textRect.size.height;
//            }
//        }
//    }
//    if ([greeting addedImage] != nil || [greeting addedImagePath] != nil)
//    {
//        CGFloat addedImageY = MAX(USERPROFILEIMAGE_Y + USERPROFILEIMAGE_HEIGHT, FIRSTLABEL_Y) + ADDEDIMAGE_MARGIN_TOP;
//        height += addedImageY + 230.0f;
//    }
//    height += FIRSTLABEL_Y;
//    if ([greeting firstLines] != nil)
//    {
//        UIFont *font = [UIFont fontWithName:@"Helvetica" size:14.0];
//        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
//                                                                    forKey:NSFontAttributeName];
//        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[greeting firstLines] attributes:attrsDictionary];
//        
//        CGRect textRect = [attrText boundingRectWithSize:CGSizeMake(FIRSTLABEL_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//        
//        height += textRect.size.height;
//    }
//    
//    height += 100.0;
//    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"GreetingCellIdentifier";
//    
//    Greeting *greeting = [self.greetings objectAtIndex:[indexPath row]];
//    
//    NSLog(@"Dequeuing resuable GreetingTableViewCell");
//    GreetingTableViewCell *cell = (GreetingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        
//        NSLog(@"Allocating new GreetingTableViewCell");
//        
//        cell = [[GreetingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        
//        [cell initStyleForIndexPath:indexPath forGreeting:greeting];
//    }
//    
//    [cell setTableViewController:self];
//    [self.cells setObject:cell atIndexedSubscript:[indexPath row]];
//    [cell initDataForIndexPath:indexPath forGreeting:greeting];
//    

    GreetingTableViewProfileLabelImageCell *cell = [tableView dequeueReusableCellWithIdentifier:GreetingsTableViewProfileLabelImageCellIdentifier forIndexPath:indexPath];
    
    Greeting *greeting = [self.greetings objectAtIndex:[indexPath row]];
    
    // Configure the cell for this indexPath
    [cell updateFonts];
    
    NSString *bodyText = [greeting firstLines];
    NSMutableAttributedString *bodyAttributedText = [[NSMutableAttributedString alloc] initWithString:bodyText];
    NSMutableParagraphStyle *bodyParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [bodyParagraphStyle setLineSpacing:10.0f];
    [bodyAttributedText addAttribute:NSParagraphStyleAttributeName value:bodyParagraphStyle range:NSMakeRange(0, bodyText.length)];
    cell.bodyLabel.attributedText = bodyAttributedText;
    
    cell.userProfileImage.image = [greeting userProfileImage] ? [greeting userProfileImage] : [UIImage imageNamed:@"anonymous.png"];
    cell.addedImage.image = [greeting addedImage] ? [greeting addedImage] : [UIImage imageNamed:@"anonymous.png"];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];

    
    return cell;
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
