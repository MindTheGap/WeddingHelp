//
//  ServerMessageWeddingSearchResult.h
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ServerMessagesMisc.h"
#import "ServerMessagesPH.h"

@interface ServerMessageWeddingSearchResult : ServerMessageBase

@property (strong, nonatomic) NSMutableArray *results;


@end
