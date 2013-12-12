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
        return;
    }
    
    static DBRestClient *restClient = nil;
    if(!restClient) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }

    NSString *destinationDirectory = @"/";
    NSString *basePath = [self.databasePath stringByDeletingLastPathComponent];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *images = [[fileManager enumeratorAtPath:basePath] allObjects];
    
    for(NSString *image in images) {
        [restClient loadRevisionsForFile:[destinationDirectory stringByAppendingPathComponent:image] limit:1];
    }
    
}

- (void)restClient:(DBRestClient *)client loadedRevisions:(NSArray *)revisions forFile:(NSString *)path {
    // Don't re-upload images
    if([[path pathExtension] isEqualToString:@"jpg"]) {
        NSLog(@"Image already exists. skipping");
        return;
    }
    
    NSString *rev = nil;
    if(revisions.count > 0) {
        DBMetadata *metadata = [revisions lastObject];
        rev = metadata.rev;
    }
    
    NSString *basePath = [self.databasePath stringByDeletingLastPathComponent];
    [client uploadFile:path toPath:@"/" withParentRev:rev fromPath:[basePath stringByAppendingPathComponent:path]];
}

- (void)restClient:(DBRestClient*)client uploadedFile:(NSString*)destPath from:(NSString*)srcPath metadata:(DBMetadata*)metadata {
    NSLog(@"File uploaded successfully to path: %@", metadata.path);
}

- (void)restClient:(DBRestClient *)client loadRevisionsFailedWithError:(NSError *)error {
    NSString *basePath = [[self.databasePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[error.userInfo[@"path"] lastPathComponent]];
    [client uploadFile:[error.userInfo[@"path"] lastPathComponent] toPath:@"/" withParentRev:nil fromPath:basePath];
}

- (void)restClient:(DBRestClient*)client uploadFileFailedWithError:(NSError*)error {
     NSLog(@"File upload failed with error - %@", error);
}

@end
