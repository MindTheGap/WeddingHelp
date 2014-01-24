//
//  WeddingSearchResultTableViewController.m
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "WeddingSearchResultTableViewController.h"
#import "WeddingSearchResultsCell.h"
#import "ServerMessageTypes.h"
#import <Foundation/NSJSONSerialization.h>
#import "Wedding.h"
#import "Toast+UIView.h"
#import "UIImageView+AFNetworking.h"
#import "WeddingSearchResultLoadMoreCell.h"
#import "WeddingResultSelectionViewController.h"

#define NORMAL_CELL_HEIGHT 106.0f
#define LOAD_MORE_CELL_HEIGHT 48.0f

@interface WeddingSearchResultTableViewController ()

//@property (strong, nonatomic)

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
    
    [self.view makeToastActivity];
    
    NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", SearchResults], @"type", nil];
    [[self.delegate commManager] sendObject:object completion:^(NSDictionary *json)
     {
         NSArray *results = [json objectForKey:@"Results"];
         
         self.results = [[NSMutableArray alloc] init];
         for (int i = 0; i < [results count]; i++) {
             NSDictionary *weddingDictionary = [results objectAtIndex:i];
             
             Wedding *searchResult = [[Wedding alloc] init];
             
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
             
             NSString *imagePath = [weddingDictionary objectForKey:@"Image"];
             if ([imagePath class] != [NSNull class])
                 [searchResult setImagePath:imagePath];
             
             [self.results addObject:searchResult];
         }
         
//         NSLog(@"calling reloadData");
         dispatch_async(dispatch_get_main_queue(), ^{ [self.tableView reloadData]; });
         dispatch_async(dispatch_get_main_queue(), ^{ [self.view hideToastActivity]; });
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
//    NSLog(@"returning number of sections (1)");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"returning number of rows (%d)", [self.results count]);
    int count = [self.results count];
    return (count > 0) ? count + 1 : count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath*)indexPath
{
    if ([indexPath row] == [self.results count])
        return LOAD_MORE_CELL_HEIGHT;
    
    return NORMAL_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"returning cell for row %d", [indexPath row]);
    
    static NSString *LoadMoreCellIdentifier = @"WeddingSearchResultLoadMoreIdentifier";
    static NSString *CellIdentifier = @"WeddingSearchResultIdentifier";
    
    if ([indexPath row] == [self.results count])
    {
        WeddingSearchResultLoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadMoreCellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    else
    {
        WeddingSearchResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if ([indexPath row] >= [self.results count])
        {
            NSLog(@"row (%d) is higher than count (%d)!", [indexPath row], [self.results count]);
            return cell;
        }
        
        Wedding *weddingSearchResult = [self.results objectAtIndex:[indexPath row]];
        
        [cell.groomName setText:[weddingSearchResult groomFullName]];
        [cell.brideName setText:[weddingSearchResult brideFullName]];
        [cell.place setText:[weddingSearchResult place]];
        [cell.weddingDate setText:[weddingSearchResult date]];
        
//        NSLog(@"image path is: %@", [weddingSearchResult imagePath]);
        [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[weddingSearchResult imagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [UIView transitionWithView:cell.imageView
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
//                                NSLog(@"cellForRowAtIndexPath setting image view to image");
//                                if (image == nil)
//                                    NSLog(@"image is nil!");
                                
                                [cell.imageView setImage:image];
                                [weddingSearchResult setImage:image];
                            }
                            completion:NULL];
            
        }
                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                           NSLog(@"cellForRowAtIndexPath failed to fetch image! error: %@", error);
                                       }];

        return cell;
    }
    
    
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    UITabBarController *selectionTabBarController = segue.destinationViewController;
    if ([selectionTabBarController class] == [UITabBarController class])
    {
        WeddingResultSelectionViewController *selectionViewController = [selectionTabBarController.viewControllers firstObject];
        if (selectionViewController)
        {
            Wedding *weddingSearchResult = [self.results objectAtIndex:[indexPath row]];
            
            [selectionViewController setImage:[weddingSearchResult image]];
            [selectionViewController setGroomFullName:[weddingSearchResult groomFullName]];
            [selectionViewController setBrideFullName:[weddingSearchResult brideFullName]];
            [selectionViewController setRehearsalDinnerDateText:[weddingSearchResult date]];
            [selectionViewController setRehearsalDinnerPlaceText:[weddingSearchResult place]];            
        }
    }
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
