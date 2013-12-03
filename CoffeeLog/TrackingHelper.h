//
//  TrackingHelper.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 03.12.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>

// Screens
extern NSString *const kTrackingScreenListView;
extern NSString *const kTrackingScreenDetailView;
extern NSString *const kTrackingScreenAddEditView;
extern NSString *const kTrackingScreenVenueSearchView;
extern NSString *const kTrackingScreenSettingsView;

// Events
extern NSString *const kTrackingEventCoffeeEvent;
extern NSString *const kTrackingEventSettingsEvent;
extern NSString *const kTrackingEventCoffeeShareEvent;

// Event Labels
extern NSString *const kTrackingEventCoffeeEventAddFirst;
extern NSString *const kTrackingEventCoffeeEventSaveFirst;
extern NSString *const kTrackingEventCoffeeEventAdd;
extern NSString *const kTrackingEventCoffeeEventSaveNew;
extern NSString *const kTrackingEventCoffeeEventSaveExisting;
extern NSString *const kTrackingEventCoffeeEventDelete;

extern NSString *const kTrackingEventSettingsEventChooseCurrency;
extern NSString *const kTrackingEventSettingsEventChooseUnit;
extern NSString *const kTrackingEventSettingsEventChooseDropbox;
extern NSString *const kTrackingEventSettingsEventFollow;

extern NSString *const kTrackingEventCoffeeShareEventFacebook;
extern NSString *const kTrackingEventCoffeeShareEventTwitter;
extern NSString *const kTrackingEventCoffeeShareEventInstagram;

@interface TrackingHelper : NSObject

+(void)initTrackingWithID:(NSString*)identifier;

+(void)trackEvent:(NSString*)event withLabel:(NSString*)label;
+(void)trackEvent:(NSString*)event withLabel:(NSString*)label andValue:(NSNumber*)value;

+(void)trackScreen:(NSString*)name;

@end
