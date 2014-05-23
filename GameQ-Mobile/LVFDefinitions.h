//
//  LVFDefinitions.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/23/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGameQServerURL @"http://185.2.155.172/GameQ_Server_Code/"
#define serverURL kGameQServerURL
#define loginURL kGameQServerURL@"signing.php"
#define registerURL kGameQServerURL@"regging.php"
#define logoutURL kGameQServerURL@"logging.php"
//NSString *const pushURL = kGameQServerURL@"push.php"
//NSString *const softPushURL = kGameQServerURL@"softpush.php"
#define updateURL kGameQServerURL@"updateDraw.php"
//NSString *const getSecretURL = kGameQServerURL@"getSecret.php"
//NSString *const checkSecretURL = kGameQServerURL@"chkSecret.php"
#define updateTokenURL kGameQServerURL@"upToken.php"
#define kAPPID @"GameQ"

#define URL_ABOUT @"http://www.gameQ.io#read-more"

@interface LVFDefinitions : NSObject

@end
