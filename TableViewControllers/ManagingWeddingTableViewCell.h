//
//  ManagingWeddingTableViewCell.h
//  WeddingHelp
//
//  Created by MTG on 1/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagingWeddingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *groomNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brideNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (strong, nonatomic) NSString *groomNameText;
@property (strong, nonatomic) NSString *brideNameText;
@property (strong, nonatomic) NSString *dateAndPlaceText;

@end
