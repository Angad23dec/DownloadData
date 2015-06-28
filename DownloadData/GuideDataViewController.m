//
//  GuideDataViewController.m
//  DownloadData
//
//  Created by Angad Manchanda on 6/27/15.
//  Copyright (c) 2015 Angad Manchanda. All rights reserved.
//

#import "GuideDataViewController.h"
#import "AFNetworking.h"
#import "Guide.h"

#define URLSTRING @"https://www.guidebook.com/service/v2/upcomingGuides/"

@interface GuideDataViewController ()

@property(nonatomic, strong) NSMutableArray *guideDataArrayFromAFNetworking;

@end

@implementation GuideDataViewController

#pragma mark - ViewControllerLifeCycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self makeDataRequest];
}

#pragma mark - MakeDataRequest Method

- (void)makeDataRequest
{
    NSURL *url = [NSURL URLWithString:URLSTRING];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // MileStone 1 : Asynchronously fetch
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * arrayFromServer = [responseObject objectForKey:@"data"];
        self.guideDataArrayFromAFNetworking = [[NSMutableArray alloc] init];
        
        // MileStone 2 : parse the retrieved JSON data into an array of objects of class Guide
        for(NSDictionary *data in arrayFromServer)
        {
            Guide *guide = [[Guide alloc] initWithJSONData:data];
            [self.guideDataArrayFromAFNetworking addObject:guide];
        }
        
        // MileStone 4 , sorting by ascending order - start Date
        NSSortDescriptor *sortByStartDate = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES];
        [self.guideDataArrayFromAFNetworking sortUsingDescriptors:@[sortByStartDate]];
        
        // MileStone 1 , print (NSLog) the response data received from the API endpoint
        NSLog(@"Response Data = %@", arrayFromServer);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.guideDataArrayFromAFNetworking count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GuideData";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // MileStone 3, Displaying data from Guide model object
    
    if([self.guideDataArrayFromAFNetworking count] == 0){
        cell.textLabel.text = @"no data to show";
    }
    else
    {
        Guide *guide = [self.guideDataArrayFromAFNetworking objectAtIndex:indexPath.row];
        
        cell.textLabel.text = guide.name;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ : %@, %@", guide.startDate, guide.endDate, guide.city, guide.state];
        
    }
    return cell;
}

@end
