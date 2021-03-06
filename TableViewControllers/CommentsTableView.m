//
//  CommentsTableView.m
//  WeddingHelp
//
//  Created by MTG on 2/1/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "CommentsTableView.h"
#import "CommentTableViewCell.h"
#import "Comment.h"
#import  "QuartzCore/QuartzCore.h"
#import "CommentsMoreButtonCell.h"

#define kNumOfVisibleCommentsWhenCascaded 3

@interface CommentsTableView()

@end

@implementation CommentsTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [[UIColor blueColor] CGColor];
    }
    return self;
}

- (void) initData
{
    NSLog(@"initData");
    self.rowHeights = [[NSMutableArray alloc] initWithCapacity:[self.comments count]];
    for (NSInteger i = 0; i < [self.comments count]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.cascade ? i + 1 : i) inSection:1];
        CommentTableViewCell *sizingCell = (CommentTableViewCell *)[self tableView:self cellForRowAtIndexPath:indexPath];
        
        CGFloat min = MIN(20.0 * [sizingCell neededNumberOfLinesForComment],130.0);
        CGFloat lineHeight = MAX(min, 50.0);
        [self.rowHeights insertObject:[NSNumber numberWithFloat:lineHeight] atIndex:i];
    }
    
    if ([self.comments count] > kNumOfVisibleCommentsWhenCascaded)
        self.cascade = YES;
}

- (void) handleShowAllCommentsButtonClicked:(UIButton *)sender
{
    self.cascade = NO;
    [self initTableViewHeight];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger res = 0;
    if (self.cascade == YES)
        res = 2;
    else
        res = [self.comments count];
    
    NSLog(@"numberOfRowsInSection with %d", res);
    return res;
}

- (void) initTableViewHeight
{
    float height = 0.0;
    int totalVisibleElements = self.cascade == YES ? [[self comments] count] - kNumOfVisibleCommentsWhenCascaded : 0;
    for (int i = [[self comments] count] - 1; i >= totalVisibleElements ; i--)
    {
        NSNumber *number = [[self rowHeights] objectAtIndex:i];
        height += [number floatValue];
    }
    
//    height = MIN(height, 300.0);
    self.heightConstraint.constant = height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    if (self.cascade == YES)
        row = [[self comments] count] - 1 - row;
    CGFloat height = [[self.rowHeights objectAtIndex:row] floatValue];
    NSLog(@"returning height %f for row %d", height, row);
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CommentCellIdentifier = @"CommentsCellIdentifier";
    static NSString *CommentsMoreButtonCellIdentifier = @"CommentsMoreButtonCellIdentifier";
    static NSString *CellNib = @"CommentTableViewCell";
    static NSString *CellMoreButtonNib = @"CommentMoreButtonCell";

    NSLog(@"cellForRowAtIndexPath %d", [indexPath row]);
    
    if (self.cascade && [indexPath row] == 0)
    {
        CommentsMoreButtonCell *cell = (CommentsMoreButtonCell *)[tableView dequeueReusableCellWithIdentifier:CommentsMoreButtonCellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellMoreButtonNib owner:self options:nil];
            if ([nib count] == 0)
            {
                return nil;
                NSLog(@"Greetings: can't find comment more buttons cell nib!");
            }
            
            cell = (CommentsMoreButtonCell *)[nib objectAtIndex:0];
        }
        
        if (cell)
        {
            [cell setTableView:tableView];
        }
        
        return cell;
    }
    else
    {
        CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
            if ([nib count] == 0)
            {
                return nil;
                NSLog(@"Greetings: can't find comment cell nib!");
            }
            
            cell = (CommentTableViewCell *)[nib objectAtIndex:0];
        }
        
        if (cell)
        {
            int row = self.cascade ? ([[self comments] count]) - [indexPath row] : [indexPath row];
            
            Comment *comment = [self.comments objectAtIndex:row];
            if (comment)
            {
                [cell initDataForIndexPath:indexPath forComment:comment];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            [cell setTableView:(CommentsTableView *)tableView];
        }
        
        return cell;
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
