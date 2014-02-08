//
//  LVFConnections.h
//  NetMonitor
//
//  Created by Ludvig Fröberg on 10/19/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"
#import "LVFConnect.h"
#import "LVFAppDelegate.h"
#import "LVFDefinitions.h"
@class LVFViewController;
@class LVFConnect;

@interface LVFConnections : NSObject

@property LVFConnect *gqConnect;
@property LVFViewController *mainController;

- (void)logoutPostFromToken:(NSString *)token;
- (void)loginWithUser:(NSString*)username andPass:(NSString*)losenord;
- (id) initFromController:(LVFViewController *)controller;
- (void)upAppPost;

@end
