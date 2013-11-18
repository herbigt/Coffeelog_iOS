//
//  CoffeeModel.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "CoffeeModel.h"

@implementation CoffeeModel

-(id)init {
    self = [super init];
    if(self) {
        self.storeType = CoffeeStoreTypeWeb;
        self.worksWith = [NSArray array];
    }
    
    return self;
}

+ (NSArray *)coffeeStates {
    static NSArray *states = nil;
    if(!states) {
        states = @[@(CoffeeStateGrinded), @(CoffeeStateBeansRoasted), @(CoffeeStateBeansUnroasted)];
    }
    
    return states;
}

+ (NSArray *)coffeeTypes {
    static NSArray *types = nil;
    if(!types) {
        types = @[@(CoffeeTypeEspresso), @(CoffeeTypeCoffee), @(CoffeeTypeBlend)];
    }
    
    return types;
}

+ (NSArray *)coffeeWorksWith {
    static NSArray *worksWiths = nil;
    if(!worksWiths) {
        worksWiths = @[@(CoffeeWorksWithAeropress), @(CoffeeWorksWithFilter), @(CoffeeWorksWithFrenchpress), @(CoffeeWorksWithSieb), @(CoffeeWorksWithTurkish)];
    }
    
    return worksWiths;
}

+(NSString *)labelForCoffeeState:(CoffeeState)state {
    static NSArray *states = nil;
    if(!states) {
        states = @[NSLocalizedString(@"Grinded", nil), NSLocalizedString(@"Beans (roasted)", nil), NSLocalizedString(@"Beans (unroasted)", nil)];
    }
    
    return states[state];
}

+(NSString *)labelForCoffeeType:(CoffeeType)type {
    static NSArray *types = nil;
    if(!types) {
        types = @[NSLocalizedString(@"Espresso", nil), NSLocalizedString(@"Coffee", nil), NSLocalizedString(@"Blend", nil)];
    }
    
    return types[type];
}

+(NSString *)labelForWorksWith:(CoffeeWorksWith)worksWith {
    static NSArray *worksWiths = nil;
    if(!worksWiths) {
        worksWiths = @[NSLocalizedString(@"aero", nil), NSLocalizedString(@"filter", nil), NSLocalizedString(@"frenchpress", nil), NSLocalizedString(@"sieb", nil), NSLocalizedString(@"turkish", nil)];
    }
    
    return worksWiths[worksWith];
}

@end
