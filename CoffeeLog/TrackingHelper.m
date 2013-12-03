//
//  TrackingHelper.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 03.12.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "TrackingHelper.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>
#import <GoogleAnalytics-iOS-SDK/GAIFields.h>

NSString *const kTrackingScreenListView = @"ListView";
NSString *const kTrackingScreenDetailView = @"DetailView";
NSString *const kTrackingScreenAddEditView = @"AddEditView";
NSString *const kTrackingScreenVenueSearchView = @"VenueSearchView";
NSString *const kTrackingScreenSettingsView = @"SettingsView";

// Events
NSString *const kTrackingEventCoffeeEvent = @"CoffeeEvent";
NSString *const kTrackingEventSettingsEvent = @"SettingsEvent";
NSString *const kTrackingEventCoffeeShareEvent = @"CoffeeShareEvent";

// Event Labels
NSString *const kTrackingEventCoffeeEventAddFirst = @"AddFirst";
NSString *const kTrackingEventCoffeeEventSaveFirst = @"SaveFirst";
NSString *const kTrackingEventCoffeeEventAdd = @"EventAdd";
NSString *const kTrackingEventCoffeeEventSaveNew = @"SaveNew";
NSString *const kTrackingEventCoffeeEventSaveExisting = @"SaveExisting";
NSString *const kTrackingEventCoffeeEventDelete = @"Delete";

NSString *const kTrackingEventSettingsEventChooseCurrency = @"ChooseCurrency";
NSString *const kTrackingEventSettingsEventChooseUnit = @"ChooseUnit";
NSString *const kTrackingEventSettingsEventChooseDropbox = @"ChooseDropbox";
NSString *const kTrackingEventSettingsEventFollow = @"Follow";

NSString *const kTrackingEventCoffeeShareEventFacebook = @"Facebook";
NSString *const kTrackingEventCoffeeShareEventTwitter = @"Twitter";
NSString *const kTrackingEventCoffeeShareEventInstagram = @"Instagram";

@implementation TrackingHelper

+ (void)initTrackingWithID:(NSString *)identifier {
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[GAI sharedInstance] trackerWithTrackingId:identifier];
    [[[GAI sharedInstance] defaultTracker] set:kGAIAnonymizeIp value:[@YES stringValue]];
}

+ (void)trackEvent:(NSString *)event withLabel:(NSString *)label {
    [TrackingHelper trackEvent:event withLabel:label andValue:@(0)];
}

+ (void)trackEvent:(NSString *)event withLabel:(NSString *)label andValue:(NSNumber *)value {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action" action:event label:label value:value] build]];
}

+ (void)trackScreen:(NSString *)name {
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:name];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}



@end
