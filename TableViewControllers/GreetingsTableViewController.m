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
#import "GreetingTableViewCell.h"


#define USERPROFILEIMAGE_TAG 1
#define FIRSTLABEL_TAG 2
#define ADDEDIMAGE_TAG 3
#define SECONDLABEL_TAG 4
#define NUMLIKES_TAG 5
#define LIKE_TAG 6
#define COMMENT_TAG 7
#define COMMENT_TV_TAG 8






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
    if (self.tableView != tableView)
    {
//        NSLog(@"number of rows (comments) %d", [self.greetings ob])
    }
    else
    {
        NSLog(@"number of rows in section %d", [self.greetings count]);
        return [self.greetings count];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 800.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GreetingCellIdentifier";
    
    Greeting *greeting = [self.greetings objectAtIndex:[indexPath row]];
    
    NSLog(@"Dequeuing resuable GreetingTableViewCell");
    GreetingTableViewCell *cell = (GreetingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSLog(@"Allocating new GreetingTableViewCell");
        
        cell = [[GreetingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        [cell initStyleForIndexPath:indexPath forGreeting:greeting];
    }
    
    [cell initDataForIndexPath:indexPath forGreeting:greeting];
    
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
