//
//  LVFConnections.h
//  NetMonitor
//
//  Created by Ludvig Fröberg on 10/19/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+SHA256.h"
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
- (void)registerWithEmail:(NSString*)email andPass:(NSString*)losenord andSecretQuestion:(NSString*)secretQuestion andSecret:(NSString*)secret;
//- (void) upTokenWithToken:(NSString *)token andDeviceName:(NSString *)name andEmail:(NSString *)email;

@end
