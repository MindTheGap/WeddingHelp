//
//  CommentTableViewCell.h
//  WeddingHelp
//
//  Created by MTG on 1/24/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "CommentsTableView.h"

@interface CommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (strong, nonatomic) CommentsTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeightConstraint;

@property (strong, nonatomic) Comment *selectedComment;

@property (assign, nonatomic) NSInteger neededNumberOfLinesForComment;

- (void)initDataForIndexPath:(NSIndexPath *)indexPath forComment:(Comment *)comment;


@end
