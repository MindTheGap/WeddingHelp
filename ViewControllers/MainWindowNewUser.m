//
//  MainWindow.m
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "MainWindowNewUser.h"
#import "MFSideMenu.h"

@interface MainWindowNewUser()

@property (assign, nonatomic) BOOL sideMenuOpen;

@end

@implementation MainWindowNewUser

- (void)viewDidLoad
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sideMenuClicked)];
    [singleTap setNumberOfTapsRequired:1];
    [self.sideMenuImageView addGestureRecognizer:singleTap];
    
    self.sideMenuOpen = NO;
    
    self.delegate = (WeddingHelpAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)sideMenuClicked
{
    NSLog(@"single Tap on imageview");
    
    [[self.delegate container] toggleLeftSideMenuCompletion:nil];
}

@end
