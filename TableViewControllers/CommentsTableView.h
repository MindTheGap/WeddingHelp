//
//  CommentsTableView.h
//  WeddingHelp
//
//  Created by MTG on 2/1/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *rowHeights;

@property (strong, nonatomic) NSMutableArray *comments;

@property (assign, nonatomic) BOOL cascade;

@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;

- (void) initData;
- (void) initTableViewHeight;

- (void) handleShowAllCommentsButtonClicked:(id)sender;


@end
