//
//  FoursquareVenueProvider.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FoursquareVenueProvider : NSObject

+ (instancetype) defaultProvider;

- (void) searchVenuesWithTerm:(NSString*)searchTerm andLocation:(CLLocation*)location andCompletionBlock:(void (^)(NSError *error, NSArray *venues))completionBlock;

@end
