//
//  LVFResponses.h
//  NetMonitor
//
//  Created by Ludvig Fröberg on 10/19/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LVFConnections.h"
#import "LVFAppDelegate.h"
#import "LVFViewController.h"
#import "LVFDefinitions.h"
#import "LVFStoreHandler.h"
@class LVFStoreHandler;
@class LVFConnections;
@class LVFViewController;
@interface LVFConnect : NSObject
@property LVFStoreHandler *store;

- (void)postNow:(NSString *)toPost to:(NSString *)link;
- (id) initWithDelegate:(LVFConnections *)del andController:(LVFViewController *)controller;
@end
