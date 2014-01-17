//
//  CommManager.m
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "CommManager.h"
#import "ServerMessagesMisc.h"
#import "ServerMessagesPH.h"

#define SERVER_HOST @"http://192.168.94.1:4296/"


@implementation CommManager

- (void)sendCommandString:(NSString *)jsonString completion:(CompletionBlock)callback
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SERVER_HOST]];
    [request setValue:jsonString forHTTPHeaderField:@"json"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSLog(@"Sending command message: %@", jsonString);
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
         {
             NSLog(@"Got response from server. calling callback");
             
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             
             callback(json);
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"data length is zero and no error");
         }
         else if (error != nil && error.code == NSURLErrorTimedOut)
         {
             NSLog(@"error code is timed out");
         }
         else if (error != nil)
         {
             NSLog(@"error is: %@" , [error localizedDescription]);
         }
     }];
}



- (void)sendCommand:(enum CommandType)commandType completion:(CompletionBlock)callback
{
    switch (commandType)
    {
        case Registration:
        {
            ServerMessageRegistration *serverMessageRegistration = [[ServerMessageRegistration alloc] init];
            NSString *jsonString = [serverMessageRegistration toJSONString];
            [self sendCommandString:jsonString completion:callback];
        }
        case SearchResults:
        {
            ServerMessageWeddingSearchResult *serverMessageResults = [[ServerMessageWeddingSearchResult alloc] init];
            NSString *jsonString = [serverMessageResults toJSONString];
            [self sendCommandString:jsonString completion:callback];
        }
        case GetAllJoinedWeddings:
        {
            ServerMessageGetAllJoinedWeddings *serverMessageResults = [[ServerMessageGetAllJoinedWeddings alloc] init];
            NSString *jsonString = [serverMessageResults toJSONString];
            [self sendCommandString:jsonString completion:callback];
        }
            
    }
}



@end
