//
//  ServerMessageBase.m
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "ServerMessageBase.h"

@implementation ServerMessageBase

#define kTypeKey         @"Type"

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[[NSNumber alloc] initWithInt:self.type] forKey:kTypeKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    NSNumber *typeNumber = [decoder decodeObjectForKey:kTypeKey];
    return [self initWithType:[typeNumber intValue]];
}

- (id)initWithType:(enum CommandType )type
{
    self.type = type;
    return self;
}


@end
