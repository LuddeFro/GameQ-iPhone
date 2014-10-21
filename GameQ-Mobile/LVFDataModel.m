//
//  LVFdataModel.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/23/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import "LVFDataModel.h"

@implementation LVFDataModel

-(id) init
{
    self = [super init];
    if (self)
    {
        LVFAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        _context = [appDelegate managedObjectContext];
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"LoginEntity" inManagedObjectContext:_context];
        _request = [[NSFetchRequest alloc] init];
        [_request setEntity:entityDescription];
    }
    return self;
}


- (NSString *) getToken
{
    NSError *error;
    NSArray *objects = [_context executeFetchRequest:_request error:&error];
    if (objects == Nil) {
        NSLog(@"Storage files not found");
    }

    
    for (NSManagedObject *oneObject in objects) {
        return [oneObject valueForKey:@"token"];
    }
    return nil;
}
- (NSString *) getEmail
{
    NSError *error;
    NSArray *objects = [_context executeFetchRequest:_request error:&error];
    if (objects == Nil) {
        NSLog(@"Storage files not found");
    }
    
    
    for (NSManagedObject *oneObject in objects) {
        return [oneObject valueForKey:@"email"];
    }
    return nil;

}
- (NSNumber *) getBolIsLoggedIn
{
    NSError *error;
    NSArray *objects = [_context executeFetchRequest:_request error:&error];
    if (objects == Nil) {
        NSLog(@"Storage files not found");
    }
    
    
    for (NSManagedObject *oneObject in objects) {
        return [oneObject valueForKey:@"bolIsLoggedIn"];
    }
    return nil;

}
- (NSNumber *) getDeviceID
{
    NSError *error;
    NSArray *objects = [_context executeFetchRequest:_request error:&error];
    if (objects == Nil) {
        NSLog(@"Storage files not found");
    }
    for (NSManagedObject *oneObject in objects) {
        return [oneObject valueForKey:@"deviceID"];
    }
    return nil;
    
}
- (NSString *) getPass
{
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:kAPPID accessGroup:nil];
    NSString *passString = [keyChain objectForKey:(__bridge id)kSecValueData];
    return passString;
    
}
- (NSNumber *) getBolRegisteredForNotifications
{
    NSError *error;
    NSArray *objects = [_context executeFetchRequest:_request error:&error];
    if (objects == Nil) {
        NSLog(@"Storage files not found");
    }
    for (NSManagedObject *oneObject in objects) {
        return [oneObject valueForKey:@"bolIsRegisteredForNotifications"];
    }
    return nil;
    
}
- (void) setBolRegisteredForNotifications:(NSNumber *)isRegistered
{
    [self setSomething:isRegistered forField:@"bolIsRegisteredForNotifications"];
}
- (void) setDeviceID:(NSString *)devID
{
    [self setSomething:devID forField:@"deviceID"];
}
- (void) setPass:(NSString *)pass
{
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:kAPPID accessGroup:nil];
    [keyChain setObject:pass forKey:(__bridge id)kSecValueData];
}
- (void) setToken:(NSString *)token
{
    [self setSomething:token forField:@"token"];
}
- (void) setEmail:(NSString *)email
{
    [self setSomething:email.lowercaseString forField:@"email"];
}
- (void) setBolIsLoggedIn:(NSNumber *)isLoggedIn
{
    [self setSomething:isLoggedIn forField:@"bolIsLoggedIn"];
}
- (void) setSomething:(id)value forField:(NSString *)field
{
    NSManagedObject *anObject = nil;
    NSError *error;
    NSArray *objects = [_context executeFetchRequest:_request error:&error];
    if (objects == nil) {
        NSLog(@"objects == nil  ......    (error)");
        //code should be unreachable
    }
    
    if ([objects count] > 0){
        NSLog(@"for loop is called - datamodel objects > 0");
        for (int i = 0; i < objects.count; i++) {
            anObject = [objects objectAtIndex:i];
            [anObject setValue:value forKey:field];
        }
    } else {
        NSLog(@"for loop isn't called - datamodel objects <= 0");
        anObject = [NSEntityDescription insertNewObjectForEntityForName:@"LoginEntity" inManagedObjectContext:_context];
        [anObject setValue:value forKey:field];
    }
    [_context save:&error];
}
@end
