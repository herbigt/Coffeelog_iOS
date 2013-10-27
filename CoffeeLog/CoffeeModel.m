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

@end
