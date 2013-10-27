//
//  UserSettings.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettings : NSObject

@property (strong, nonatomic) NSString *currency;
@property (strong, nonatomic) NSString *weight;
@property (nonatomic) BOOL dropboxEnabled;

+(instancetype)defaultSettings;

- (void)loadSettings;
- (void)saveSettings;

@end
