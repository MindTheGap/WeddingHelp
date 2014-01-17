//
//  WeddingResultSelectionViewController.m
//  WeddingHelp
//
//  Created by MTG on 1/12/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "WeddingResultSelectionViewController.h"

@interface WeddingResultSelectionViewController ()

@end

@implementation WeddingResultSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.groomNameLabel setText:self.groomFullName];
    [self.brideNameLabel setText:self.brideFullName];
    [self.rehearsalDinnerDateLabel setText:self.rehearsalDinnerDateText];
    [self.rehearsalDinnerPlaceLabel setText:self.rehearsalDinnerPlaceText];
    [self.imageView setImage:self.image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
