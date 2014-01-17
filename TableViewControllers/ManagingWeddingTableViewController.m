//
//  ManagingWeddingTableViewController.m
//  WeddingHelp
//
//  Created by MTG on 1/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "ManagingWeddingTableViewController.h"
#import "ServerMessagesMisc.h"
#import "ServerMessagesPH.h"
#import "Wedding.h"
#import "Toast+UIView.h"
#import "ManagingWeddingTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface ManagingWeddingTableViewController ()

@end

@implementation ManagingWeddingTableViewController

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
    
    [[self.delegate commManager] sendCommand:GetAllJoinedWeddings completion:^(NSDictionary *json)
     {
         NSArray *weddings = [json objectForKey:@"Weddings"];
         
         self.weddings = [[NSMutableArray alloc] init];
         for (int i = 0; i < [weddings count]; i++) {
             NSDictionary *weddingDictionary = [weddings objectAtIndex:i];
             
             Wedding *wedding = [[Wedding alloc] init];
             
             NSString *groomFullName = [weddingDictionary objectForKey:@"GroomFullName"];
             if ([groomFullName class] != [NSNull class])
                 [wedding setGroomFullName:groomFullName];
             
             NSString *brideFullName = [weddingDictionary objectForKey:@"BrideFullName"];
             if ([brideFullName class] != [NSNull class])
                 [wedding setBrideFullName:brideFullName];
             
             NSString *date = [weddingDictionary objectForKey:@"Date"];
             if ([date class] != [NSNull class])
                 [wedding setDate:date];
             
             NSString *place = [weddingDictionary objectForKey:@"Place"];
             if ([place class] != [NSNull class])
                 [wedding setPlace:place];
             
             NSString *imagePath = [weddingDictionary objectForKey:@"Image"];
             if ([imagePath class] != [NSNull class])
                 [wedding setImagePath:imagePath];
             
             [self.weddings addObject:wedding];
         }
         
         NSLog(@"calling reloadData");
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.weddings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"returning cell for row %d", [indexPath row]);
    
    static NSString *CellIdentifier = @"ManagingWeddingCellIdentifier";
    
    ManagingWeddingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
    Wedding *wedding = [self.weddings objectAtIndex:[indexPath row]];
        
    [cell.groomNameLabel setText:[wedding groomFullName]];
    [cell.brideNameLabel setText:[wedding brideFullName]];
    [cell.placeLabel setText:[wedding place]];
    [cell.dateLabel setText:[wedding date]];
        
    NSLog(@"image path is: %@", [wedding imagePath]);
    [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[wedding imagePath]]] placeholderImage:[UIImage imageNamed:@"anonymous"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [UIView transitionWithView:cell.imageView
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                NSLog(@"cellForRowAtIndexPath setting image view to image");
                                if (image == nil)
                                    NSLog(@"image is nil!");
                                
                                [cell.imageView setImage:image];
                                [wedding setImage:image];
                            }
                            completion:NULL];
            
    }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           NSLog(@"cellForRowAtIndexPath failed to fetch image! error: %@", error);
                                       }];
        
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