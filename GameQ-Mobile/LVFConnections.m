//
//  LVFConnections.m
//  NetMonitor
//
//  Created by Ludvig Fröberg on 10/19/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//


//search for addfeature
#import "LVFConnections.h"


@interface LVFConnections ()


@end


@implementation LVFConnections


- (id) initFromController:(LVFViewController*)controller
{
    self = [super init];
    if (self)
    {
        _gqConnect = [[LVFConnect alloc] initWithDelegate:self andController:controller];
        _mainController = controller;
    }
    return self;
    
}

- (void)loginWithUser:(NSString*)username andPass:(NSString*)losenord
{
    losenord = [losenord MD5];
    NSString *postString = [NSString stringWithFormat:@"email=%@&losenord=%@",username, losenord];
    NSString *postUrl = loginURL;
    [_gqConnect postNow:postString to:postUrl];
    NSLog(@"login posted");
}

//Log the client out
- (void)logoutPostFromToken:(NSString *)token
{
    NSString *postString = [NSString stringWithFormat:@"token=%@&device=iphone", token];
    NSString *postUrl = logoutURL;
    [_gqConnect postNow:postString to:postUrl];
    NSLog(@"logout posted");
}

//update table view
- (void)upAppPost
{
    NSString *email = [_mainController.dataHandler getEmail];
    NSString *postString = [NSString stringWithFormat:@"email=%@", email];
    NSString *postUrl = updateURL;
    [_gqConnect postNow:postString to:postUrl];
    NSLog(@"upapppost");
}

/* not implemented?!?!? directly called from appdell
- (void) upTokenWithToken:(NSString *)token andDeviceName:(NSString *)name andEmail:(NSString *)email
{
    [_gqConnect postNow:[NSString stringWithFormat:@"token=%@&device=%@&email=%@", token, name, email] to:updateTokenURL];
}*/



/** if registering in app ever happens
- (void)registerWithEmail:(NSString*)email andPass:(NSString*)losenord andSecretQuestion:(NSString*)secretQuestion andSecret:(NSString*)secret
{
    losenord = [losenord MD5];
    NSString *postString = [NSString stringWithFormat:@"email=%@&losenord=%@&secretq=%@&secret=%@",email, losenord, secretQuestion, secret];
    NSString *postUrl = registerURL;
    [gqConnect postNow:postString to:postUrl];
    NSLog(@"signup posted");
}
*/
/* following is computer method
//softPush a status update from a game to

- (void)UpdateStatusWithGame:(NSString*)game andStatus:(NSString*)status
{
    //get device on iOS
    //[[UIDevice currentDevice] name];
    //get on osx
    NSString *compName = [[NSHost currentHost] name];
    NSString *postString = [NSString stringWithFormat:@"game=%@&status=%@&compName=%@", game, status, compName];
    NSString *postUrl = softPushURL;
    [gqConnect postNow:postString to:postUrl];
    NSLog(@"status update posted");
}
 */

/* following is computer method
//Push notification, for now all pushes are sent for recieved queue, status arguemnt maintained for future purposes
- (void)pushNotificationForGame:(NSString*)game
{
    //get device on iOS
    //[[UIDevice currentDevice] name];
    //get on osx
    NSString *postString = [NSString stringWithFormat:@"game=%@", game];
    NSString *postUrl = pushURL;
    [gqConnect postNow:postString to:postUrl];
    NSLog(@"addonepost");
}
 */


/*
   following methods used if support is added in-app for forgotten passwords
    also see connectionDidFinishLoading method in Connect.m for commented out if statements
 
- (void) getSecretPost:(NSString*)email
{
    NSString *postString = [NSString stringWithFormat:@"email=%@", email];
    NSString *postUrl = getSecretURL;
    [gqConnect postNow:postString to:postUrl];
    NSLog(@"get secret posted");
}

 - (void) chkSecretForEmail:(NSString*)email withSecret:(NSString*)secret andSecretQuestion:(NSString*)secretq
{
    NSString *postString = [NSString stringWithFormat:@"secret=%@&secretQ=%@&email=%@", secret, secretq, email];
    NSString *postUrl = checkSecretURL;
    [gqConnect postNow:postString to:postUrl];
    NSLog(@"check secret posted");
}
*/







@end
