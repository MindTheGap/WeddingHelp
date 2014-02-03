//
//  MyLabel.h
//  WeddingHelp
//
//  Created by MTG on 2/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface MyLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
