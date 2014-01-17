//
//  WeddingResultSelectionViewController.h
//  WeddingHelp
//
//  Created by MTG on 1/12/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeddingResultSelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *rehearsalDinnerPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rehearsalDinnerDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ceremonyDinnerPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ceremonyDinnerDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *brideNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *groomNameLabel;

@property (strong, nonatomic) NSString *groomFullName;
@property (strong, nonatomic) NSString *brideFullName;
@property (strong, nonatomic) NSString *rehearsalDinnerPlaceText;
@property (strong, nonatomic) NSString *rehearsalDinnerDateText;
@property (strong, nonatomic) NSString *ceremonyDinnerPlaceText;
@property (strong, nonatomic) NSString *ceremonyDinnerDateText;
@property (strong, nonatomic) UIImage  *image;

@end
