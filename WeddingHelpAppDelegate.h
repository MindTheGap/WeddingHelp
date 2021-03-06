//
//  WeddingHelpAppDelegate.h
//  WeddingHelp
//
//  Created by MTG on 1/9/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommManager.h"
#import "MFSideMenu.h"

@interface WeddingHelpAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CommManager *commManager;

@property (strong, nonatomic) MFSideMenuContainerViewController *container;

@property (strong, nonatomic) NSString *email;

@end
