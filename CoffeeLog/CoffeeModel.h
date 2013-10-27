//
//  CoffeeModel.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CoffeeStoreType) {
    CoffeeStoreTypeWeb = 0, // Website URL
    CoffeeStoreTypeLocation // Foursquare location
};

@interface CoffeeModel : NSObject

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *state;
@property (nonatomic) CoffeeStoreType storeType;
@property (strong, nonatomic) NSString *store;
@property (strong, nonatomic) NSString *foursquareID;

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger weight;

@property (nonatomic) bool isFavorited;

@end
