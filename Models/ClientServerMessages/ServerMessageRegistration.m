//
//  ServerMessageRegistration.m
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "ServerMessageRegistration.h"

@implementation ServerMessageRegistration

-(id) init
{
    self.type = Registration;
    
    return self;
}


- (void) encodeWithCoder:(NSCoder *)encoder
{
//    [encoder encodeObject:self.results          forKey:kResultsKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
//    NSMutableArray *results = [decoder decodeObjectForKey:kResultsKey];
    return [self initWithResults:nil];
}

- (id)initWithResults:(NSMutableArray *)results
{
    return self;
}


@end
