//
//  ServerMessageGetAllJoinedWeddings.h
//  WeddingHelp
//
//  Created by MTG on 1/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ServerMessagesMisc.h"
#import "ServerMessagesPH.h"


@interface ServerMessageGetAllJoinedWeddings : ServerMessageBase

@property (strong, nonatomic) NSMutableArray *weddings;

@end
