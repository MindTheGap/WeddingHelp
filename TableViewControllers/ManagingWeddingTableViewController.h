//
//  ManagingWeddingTableViewController.h
//  WeddingHelp
//
//  Created by MTG on 1/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeddingHelpAppDelegate.h"

@interface ManagingWeddingTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *weddings;

@property (strong, nonatomic) WeddingHelpAppDelegate *delegate;

@end
