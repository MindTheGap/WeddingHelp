//
//  ServerMessageGetAllJoinedWeddings.m
//  WeddingHelp
//
//  Created by MTG on 1/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "ServerMessageGetAllJoinedWeddings.h"

@implementation ServerMessageGetAllJoinedWeddings

#define kWeddingsKey         @"Weddings"

-(id) init
{
    self.type = GetAllJoinedWeddings;
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.weddings          forKey:kWeddingsKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    NSMutableArray *weddings = [decoder decodeObjectForKey:kWeddingsKey];
    return [self initWithWeddings:weddings];
}

- (id)initWithWeddings:(NSMutableArray *)weddings
{
    self.weddings = weddings;
    return self;
}


@end
