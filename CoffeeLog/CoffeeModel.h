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

typedef NS_ENUM(NSInteger, CoffeeType) {
    CoffeeTypeEspresso,
    CoffeeTypeCoffee,
    CoffeeTypeBlend
};

typedef NS_ENUM(NSInteger, CoffeeState) {
    CoffeeStateGrinded,
    CoffeeStateBeansRoasted,
    CoffeeStateBeansUnroasted
};

typedef NS_ENUM(NSInteger, CoffeeWorksWith) {
    CoffeeWorksWithAeropress,
    CoffeeWorksWithFilter,
    CoffeeWorksWithFrenchpress,
    CoffeeWorksWithSieb,
    CoffeeWorksWithTurkish
};

@interface CoffeeModel : NSObject

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *name;
@property (nonatomic) CoffeeType type;
@property (nonatomic) CoffeeState state;
@property (nonatomic) CoffeeStoreType storeType;
@property (strong, nonatomic) NSString *store;
@property (strong, nonatomic) NSString *foursquareID;
@property (strong, nonatomic) NSArray *worksWith;

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger weight;

@property (nonatomic) bool isFavorited;

+ (NSArray*)coffeeTypes;
+ (NSArray*)coffeeStates;
+ (NSArray*)coffeeWorksWith;

+ (NSString*)labelForCoffeeType:(CoffeeType)type;
+ (NSString*)labelForCoffeeState:(CoffeeState)state;
+ (NSString*)labelForWorksWith:(CoffeeWorksWith)worksWith;

@end
