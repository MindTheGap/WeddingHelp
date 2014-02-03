//
//  CommentTableViewCell.m
//  WeddingHelp
//
//  Created by MTG on 1/24/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.neededNumberOfLinesForComment = 0;
    }
    return self;
}

- (void)initDataForIndexPath:(NSIndexPath *)indexPath forComment:(Comment *)comment
{
    NSLog(@"CommentTableViewCell: initDataForIndexPath %d", [indexPath row]);
    [self.mainLabel setText:[comment text]];
    
    if ([comment image])
    {
        [self.userImageView setImage:[comment image]];
    }
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                forKey:NSFontAttributeName];
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[comment text] attributes:attrsDictionary];
    
    CGFloat width = [[self mainLabel] bounds].size.width;
    CGRect textRect = [attrText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil];
    
    int numberOfRowsUsed = (int)ceil(textRect.size.height / [self mainLabel].font.lineHeight);
    
    if (numberOfRowsUsed > 4)
    {
        [[self moreButton] setHidden:NO];
    }
    
    self.neededNumberOfLinesForComment = numberOfRowsUsed;
    
    self.selectedComment = comment;
    
//    CGFloat lineHeight = ([self mainLabel].font.lineHeight + 3.0) * self.neededNumberOfLinesForComment;
//    NSUInteger index = [[self.tableView comments] indexOfObject:self.selectedComment];
//    [[self.tableView rowHeights] setObject:[NSNumber numberWithFloat:lineHeight] atIndexedSubscript:index];
}

- (IBAction)moreButtonPressed:(UIButton *)sender
{
    NSLog(@"'More' button pressed");
    [[self moreButton] setHidden:YES];
    
    CGFloat height = [self mainLabel].font.lineHeight * self.neededNumberOfLinesForComment;
    CGFloat lineHeight = ([self mainLabel].font.lineHeight + 3.0) * self.neededNumberOfLinesForComment;
    [self.labelHeightConstraint setConstant:height];
    [[self mainLabel] setNumberOfLines:self.neededNumberOfLinesForComment];
    
    
    NSUInteger index = [[self.tableView comments] indexOfObject:self.selectedComment];
    [[self.tableView rowHeights] setObject:[NSNumber numberWithFloat:lineHeight] atIndexedSubscript:index];
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
