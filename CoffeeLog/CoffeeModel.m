//
//  CoffeeModel.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "CoffeeModel.h"

@implementation CoffeeModel

@synthesize worksWith=_worksWith;
@synthesize imagePath=_imagePath;

-(id)init {
    self = [super init];
    if(self) {
        self.storeType = CoffeeStoreTypeWeb;
        self.worksWith = nil;
    }
    
    return self;
}

+ (NSInteger)count {
    return [[CoffeeModel firstValueFromQuery:@"SELECT COUNT(*) FROM $T"] integerValue];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%d, %d) From %@, prize: %d, weight: %d, fav: %d", self.name, self.type, self.state, self.store, self.price, self.weight, self.isFavorited];
}

- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;

    self.image = [UIImage imageWithContentsOfFile:imagePath];
}

- (NSString *)imagePath {
    
    if([_imagePath isEqualToString:@""]) {
        return _imagePath;
    }

    static NSString *documentsDirectory = nil;
    if(!documentsDirectory) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
    }
        
    return [documentsDirectory stringByAppendingPathComponent:[_imagePath lastPathComponent]];
}

- (void)setWorksWith:(NSArray *)worksWith {
    _worksWith = worksWith;
    
    if(worksWith == nil) {
        return;
    }
    
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:worksWith options:0 error:&error];
    
    self.worksWithTypes = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

- (NSArray *)worksWith {
    if(_worksWith == nil) {
        if(self.worksWithTypes == nil || [self.worksWithTypes isEqualToString:@""]) {
            return [NSArray array];
        }
        
        NSError *error;
        _worksWith = [NSJSONSerialization JSONObjectWithData:[self.worksWithTypes dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    }
    
    return _worksWith;
}


- (void)saveImage:(UIImage *)image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"image_%f.jpg", [[NSDate date] timeIntervalSince1970]]];
    
    // Resize it.
    CGSize newSize = CGSizeMake(640, 640);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *webData = UIImageJPEGRepresentation(newImage, 85);
    [webData writeToFile:imagePath atomically:YES];

    self.imagePath = imagePath;
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
        types = @[@(CoffeeTypeEspresso), @(CoffeeTypeEspressoBlend), @(CoffeeTypeCoffee), @(CoffeeTypeBlend)];
    }
    
    return types;
}

+ (NSArray *)coffeeWorksWith {
    static NSArray *worksWiths = nil;
    if(!worksWiths) {
        worksWiths = @[@(CoffeeWorksWithAeropress), @(CoffeeWorksWithFilter), @(CoffeeWorksWithFrenchpress), @(CoffeeWorksWithSieb), @(CoffeeWorksWithTurkish), @(CoffeeWorksWithChemex), @(CoffeeWorksWithEspresskocher), @(CoffeeWorksWithSyphon)];
    }
    
    return worksWiths;
}

+(NSString *)labelForCoffeeState:(CoffeeState)state {
    static NSArray *states = nil;
    if(!states) {
        states = @[NSLocalizedString(@"Grinded", nil), NSLocalizedString(@"Beans (roasted)", @"CoffeeState"), NSLocalizedString(@"Beans (unroasted)", nil)];
    }
    
    return states[state];
}

+(NSString *)labelForCoffeeType:(CoffeeType)type {
    static NSArray *types = nil;
    if(!types) {
        types = @[NSLocalizedString(@"Espresso", nil), NSLocalizedString(@"Coffee", nil), NSLocalizedString(@"Coffee Blend", nil), NSLocalizedString(@"Espresso Blend", nil)];
    }
    
    return types[type];
}

+(NSString *)labelForWorksWith:(CoffeeWorksWith)worksWith {
    static NSArray *worksWiths = nil;
    if(!worksWiths) {
        worksWiths = @[NSLocalizedString(@"aero", nil), NSLocalizedString(@"filter", nil), NSLocalizedString(@"frenchpress", nil), NSLocalizedString(@"sieb", nil), NSLocalizedString(@"turkish", nil), NSLocalizedString(@"syphon", nil), NSLocalizedString(@"espressokocher", nil), NSLocalizedString(@"chemex", nil)];
    }
    
    return worksWiths[worksWith];
}

@end
