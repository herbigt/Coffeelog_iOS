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

- (void)searchVenuesWithTerm:(NSString *)searchTerm andCompletionBlock:(void (^)(NSError *, NSDictionary *))completionBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
