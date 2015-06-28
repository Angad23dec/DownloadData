//
//  Guide.h
//  DownloadData
//
//  Created by Angad Manchanda on 6/27/15.
//  Copyright (c) 2015 Angad Manchanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Guide : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

-(id)initWithJSONData:(NSDictionary*)data;

@end
