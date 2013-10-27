//
//  FoursquareVenueProvider.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoursquareVenueProvider : NSObject

+ (instancetype) defaultProvider;

- (void) searchVenuesWithTerm:(NSString*)searchTerm andCompletionBlock:(void (^)(NSError *error, NSDictionary *venues))completionBlock;

@end
