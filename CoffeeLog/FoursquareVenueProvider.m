//
//  FoursquareVenueProvider.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "FoursquareVenueProvider.h"

#import <AFNetworking/AFNetworking.h>

@implementation FoursquareVenueProvider

+ (instancetype)defaultProvider {
    static FoursquareVenueProvider *defaultProvider = nil;
    if(!defaultProvider) {
        defaultProvider = [[FoursquareVenueProvider alloc] init];
    }
    
    return defaultProvider;
}

- (void)searchVenuesWithTerm:(NSString *)searchTerm andLocation:(CLLocation *)location andCompletionBlock:(void (^)(NSError *, NSArray *))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *params = @{
                             @"client_id": @"MQHRP0XYN5YKVA1NZSBR2HMGZQPR2CUUZHESKVNM0ZDAGGP4",
                             @"client_secret": @"EJ3524XZ5SKAFQNQFJJINNUQN3NYM1UASLEFAJ2P11OYJFE1",
                             @"v": @"20131120",
                             @"ll": [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude],
                             @"query": searchTerm,
                             @"radius": @(5000)
    };
    
    [manager GET:@"https://api.foursquare.com/v2/venues/search" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if(!responseObject[@"meta"]) {
            completionBlock([NSError errorWithDomain:@"Coffeelog" code:900 userInfo:nil], nil);
            return;
        }
        
        NSArray *results = [NSArray arrayWithArray:responseObject[@"response"][@"venues"]];
        completionBlock(nil, results);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(error, [NSArray array]);
    }];
}


@end
