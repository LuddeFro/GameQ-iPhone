//
//  LVFdataModel.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/23/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LVFAppDelegate.h"

@interface LVFDataModel : NSObject

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchRequest *request;

- (void) setToken:(NSString *)token;
- (void) setEmail:(NSString *)email;
- (void) setBolIsLoggedIn:(NSNumber *)isLoggedIn;
- (void) setDeviceID:(NSString *)devID;
- (void) setPass:(NSString *)pass;
- (NSString *) getToken;
- (NSString *) getEmail;
- (NSNumber *) getBolIsLoggedIn;
- (NSString *) getDeviceID;
- (NSString *) getPass;

@end
