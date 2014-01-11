//
//  ServerMessageWeddingSearchResult.m
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "ServerMessageWeddingSearchResult.h"

@implementation ServerMessageWeddingSearchResult

#define kResultsKey         @"Results"

-(id) init
{
    self.type = SearchResults;
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.results          forKey:kResultsKey];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    NSMutableArray *results = [decoder decodeObjectForKey:kResultsKey];
    return [self initWithResults:results];
}

- (id)initWithResults:(NSMutableArray *)results
{
    self.results = results;
    return self;
}


@end
