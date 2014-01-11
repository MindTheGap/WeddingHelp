//
//  WeddingSearchResultTableViewController.h
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeddingHelpAppDelegate.h"

@interface WeddingSearchResultTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *results;

@property (strong, nonatomic) WeddingHelpAppDelegate *delegate;

@end
