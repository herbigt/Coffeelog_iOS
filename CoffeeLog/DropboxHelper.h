//
//  DropboxHelper.h
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 11.12.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <DropboxSDK/DropboxSDK.h>

@interface DropboxHelper : NSObject <DBRestClientDelegate>

@property (nonatomic, copy) NSString *databasePath;

+(id)sharedHelper;

-(void)initSessionWithKey:(NSString*)key andSecret:(NSString*)secret;

-(void)linkFromController:(UIViewController*)controller;

-(bool)handleAuth:(NSURL*)url;

-(void)doBackup;

@end
