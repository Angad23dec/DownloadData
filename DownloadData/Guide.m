//
//  Guide.m
//  DownloadData
//
//  Created by Angad Manchanda on 6/27/15.
//  Copyright (c) 2015 Angad Manchanda. All rights reserved.
//

#import "Guide.h"

@implementation Guide

-(id)initWithJSONData:(NSDictionary*)data
{
    if(self == [super init])
    {
        self.name = [data objectForKey:@"name"];
        self.city = [[data objectForKey:@"venue"] objectForKey:@"city"];
        self.state = [[data objectForKey:@"venue"] objectForKey:@"state"];
        self.startDate = [data objectForKey:@"startDate"];
        self.endDate = [data objectForKey:@"endDate"];
    }
    return self;
}

@end
