//
//  CommentsMoreButtonCell.m
//  WeddingHelp
//
//  Created by MTG on 2/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "CommentsMoreButtonCell.h"
#import "CommentsTableView.h"

@implementation CommentsMoreButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)moreButtonClicked:(id)sender
{
    CommentsTableView *tableView = (CommentsTableView *)self.tableView;
    
    [tableView handleShowAllCommentsButtonClicked:sender];
}

@end
