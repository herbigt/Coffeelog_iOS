//
//  CoffeeModel.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 06.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoffeeModel : NSObject

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *store;

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger weight;

@property (nonatomic) bool isFavorited;

@end
