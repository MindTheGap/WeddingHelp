//
//  WeddingSearchResultTableViewController.m
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "WeddingSearchResultTableViewController.h"
#import "WeddingSearchResultsCell.h"
#import "ServerMessagesMisc.h"
#import <Foundation/NSJSONSerialization.h>
#import "WeddingSearchResult.h"

@interface WeddingSearchResultTableViewController ()

@end

@implementation WeddingSearchResultTableViewController

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
    
    [[self.delegate commManager] sendCommand:SearchResults completion:^(NSDictionary *json)
     {
         NSArray *results = [json objectForKey:@"Results"];
         
         self.results = [[NSMutableArray alloc] init];
         for (int i = 0; i < [results count]; i++) {
             NSDictionary *weddingDictionary = [results objectAtIndex:i];
             
             WeddingSearchResult *searchResult = [[WeddingSearchResult alloc] init];
             
             NSString *groomFullName = [weddingDictionary objectForKey:@"GroomFullName"];
             if ([groomFullName class] != [NSNull class])
                 [searchResult setGroomFullName:groomFullName];
             
             NSString *brideFullName = [weddingDictionary objectForKey:@"BrideFullName"];
             if ([brideFullName class] != [NSNull class])
                 [searchResult setBrideFullName:brideFullName];
             
             NSString *date = [weddingDictionary objectForKey:@"Date"];
             if ([date class] != [NSNull class])
                 [searchResult setDate:date];
             
             NSString *place = [weddingDictionary objectForKey:@"Place"];
             if ([place class] != [NSNull class])
                 [searchResult setPlace:place];
             
             [self.results addObject:searchResult];
         }
         
         [self.tableView reloadData];
     }];
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
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeddingSearchResultIdentifier";
    WeddingSearchResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    WeddingSearchResult *weddingSearchResult = [self.results objectAtIndex:[indexPath row]];
    
    [cell.groomName setText:[weddingSearchResult groomFullName]];
    [cell.brideName setText:[weddingSearchResult brideFullName]];
    [cell.place setText:[weddingSearchResult place]];
    [cell.weddingDate setText:[weddingSearchResult date]];
    
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
