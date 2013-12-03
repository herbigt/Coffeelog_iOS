//
//  CoffeeModel.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FCModel/FCModel.h>

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

@interface CoffeeModel : FCModel

@property (nonatomic, assign) int64_t id;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imagePath;

@property (nonatomic) CoffeeType type;
@property (nonatomic) CoffeeState state;
@property (nonatomic) CoffeeStoreType storeType;

@property (strong, nonatomic) NSString *store;
@property (nonatomic) double storeLatitude;
@property (nonatomic) double storeLongitude;

@property (strong, nonatomic) NSString *foursquareID;
@property (strong, nonatomic) NSString *worksWithTypes;
@property (strong, nonatomic) NSArray *worksWith;

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger weight;

@property (nonatomic) bool isFavorited;

@property (strong, nonatomic) NSDate *created;

+ (NSArray*)coffeeTypes;
+ (NSArray*)coffeeStates;
+ (NSArray*)coffeeWorksWith;

+ (NSString*)labelForCoffeeType:(CoffeeType)type;
+ (NSString*)labelForCoffeeState:(CoffeeState)state;
+ (NSString*)labelForWorksWith:(CoffeeWorksWith)worksWith;

- (void)saveImage:(UIImage*)image;

+ (NSInteger)count;

@end
