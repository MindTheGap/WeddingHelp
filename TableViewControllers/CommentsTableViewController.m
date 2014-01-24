//
//  CommentsTableViewController.m
//  WeddingHelp
//
//  Created by MTG on 1/24/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "Greeting.h"
#import "UIImageView+AFNetworking.h"
#import "Like.h"
#import "Comment.h"
#import "Toast+UIView.h"
#import "WeddingHelpAppDelegate.h"
#import "ServerMessageTypes.h"
#import "CommentTableViewCell.h"


@interface CommentsTableViewController ()

@property (strong, nonatomic) NSMutableArray *comments;
@property (strong, nonatomic) Greeting *lastSelectedComment;
@property (weak, nonatomic) WeddingHelpAppDelegate *delegate;


@end

@implementation CommentsTableViewController

- (IBAction)moreButtonPressed:(id)sender
{

}

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
    
    self.delegate = (WeddingHelpAppDelegate *)[[UIApplication sharedApplication] delegate];
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
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CommentCellIdentifier = @"CommentCellIdentifier";
    CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier forIndexPath:indexPath];
    if (cell)
    {
        if ([indexPath row] >= [self.comments count])
            return cell;
        
        Comment *comment = [self.comments objectAtIndex:[indexPath row]];
        if (comment)
        {
            [cell setImageView:[[UIImageView alloc] initWithImage:[comment image]]];
            [[cell mainLabel] setText:[comment text]];
            NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[comment text]];
            CGRect textRect = [attrText boundingRectWithSize:CGSizeMake([[cell mainLabel] bounds].size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            int numberOfRowsUsed = (int)ceil(textRect.size.height / [cell mainLabel].font.lineHeight);
            
            NSLog(@"calculated number of rows %d for row %d", numberOfRowsUsed, [indexPath row]);
            
            if (numberOfRowsUsed > 4)
            {
                [[cell moreButton] setHidden:NO];
            }
        }
    }
    
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
