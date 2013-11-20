//
//  UserSettings.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 27.10.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

+ (instancetype)defaultSettings {
    static UserSettings *defaultSettings = nil;
    if(!defaultSettings) {
        defaultSettings = [[UserSettings alloc] init];
    }
    
    return defaultSettings;
}

- (id)init {
    self = [super init];
    if(self) {
        self.currency = @"EUR";
        self.weight = @"g";
        self.dropboxEnabled = NO;
    }
    
    return self;
}

- (NSString *)currencyString:(NSInteger)price {
    return [NSString stringWithFormat:@"%.2f%@", price/100.f, self.currency];
}

- (NSString *)weightString:(NSInteger)weight {
    return [NSString stringWithFormat:@"%.0f%@", weight/100.f, self.weight];
}

- (void)loadSettings {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if([ud objectForKey:kSettingsCurrencySetting]) {
        self.currency = [ud objectForKey:kSettingsCurrencySetting];
    }
    
    if([ud objectForKey:kSettingsWeightSetting]) {
        self.weight = [ud objectForKey:kSettingsWeightSetting];
    }
    
    if([ud boolForKey:kSettingsDropboxEnabledSetting]) {
        self.dropboxEnabled = [ud boolForKey:kSettingsDropboxEnabledSetting];
    }
}

- (void)saveSettings {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setObject:self.currency forKey:kSettingsCurrencySetting];
    [ud setObject:self.weight forKey:kSettingsWeightSetting];
    [ud setBool:self.dropboxEnabled forKey:kSettingsDropboxEnabledSetting];
    
    [ud synchronize];
}

@end
