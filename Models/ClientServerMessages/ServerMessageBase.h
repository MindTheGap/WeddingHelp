//
//  ServerMessageBase.h
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ServerMessagesMisc.h"

@interface ServerMessageBase : JSONModel <NSCoding>

@property (assign, nonatomic) enum CommandType type;

@end