//
//  ServerMessageTypes.h
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerMessageTypes : NSObject

enum CommandType
{
    SearchResults,
    GetAllJoinedWeddings,
    LikeGreeting,
    Registration
};

enum ResponseFromServer
{
    AOK
};

@end
