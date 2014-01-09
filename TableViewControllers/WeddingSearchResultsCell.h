//
//  WeddingSearchResultsCell.h
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeddingSearchResultsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *groomName;
@property (weak, nonatomic) IBOutlet UILabel *brideName;
@property (weak, nonatomic) IBOutlet UILabel *weddingDate;
@property (weak, nonatomic) IBOutlet UILabel *place;

@end
