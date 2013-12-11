//
//  DropboxHelper.m
//  CoffeeLog
//
//  Created by Philipp Waldhauer on 11.12.13.
//  Copyright (c) 2013 CoffeeLog. All rights reserved.
//

#import "DropboxHelper.h"

@implementation DropboxHelper

+(id)sharedHelper {
    static DropboxHelper *sharedHelper = nil;
    if(sharedHelper == nil) {
        sharedHelper = [[DropboxHelper alloc] init];
    }
    
    return sharedHelper;
}


-(void)initSessionWithKey:(NSString *)key andSecret:(NSString *)secret {
    DBSession* dbSession = [[DBSession alloc] initWithAppKey:key appSecret:secret root:kDBRootAppFolder];
    [DBSession setSharedSession:dbSession];
}

-(void)linkFromController:(UIViewController *)controller {
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:controller];
    }
}

-(bool)handleAuth:(NSURL*)url {
    if([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            return YES;
        }
    }
    
    return NO;
}

-(void)doBackup {
    if (![[DBSession sharedSession] isLinked]) {
        NSLog(@"Cannot perform backup, not linked");
    }
    
    static DBRestClient *restClient = nil;
    if(!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    
    NSString *filename = [self.databasePath lastPathComponent];
    NSString *destinationDirectory = @"/";
    
    [restClient loadRevisionsForFile:[destinationDirectory stringByAppendingPathComponent:filename] limit:1];
}

- (void)restClient:(DBRestClient *)client loadedRevisions:(NSArray *)revisions forFile:(NSString *)path {    
    NSString *rev = nil;
    if(revisions.count > 0) {
        DBMetadata *metadata = [revisions lastObject];
        rev = metadata.rev;
    }
    
    [client uploadFile:[self.databasePath lastPathComponent] toPath:@"/" withParentRev:rev fromPath:self.databasePath];
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
    NSLog(@"File upload failed with error - %@", error);
}

@end
