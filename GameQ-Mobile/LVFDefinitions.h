//
//  LVFDefinitions.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/23/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGameQServerURL @"http://www-student.it.uts.edu.au/~lfroberg/servTest/"
#define serverURL kGameQServerURL
#define loginURL kGameQServerURL@"signing.php"
//NSString *const registerURL = kGameQServerURL@"regging.php"
#define logoutURL kGameQServerURL@"logging.php"
//NSString *const pushURL = kGameQServerURL@"push.php"
//NSString *const softPushURL = kGameQServerURL@"softpush.php"
#define updateURL kGameQServerURL@"updateDraw.php"
//NSString *const getSecretURL = kGameQServerURL@"getSecret.php"
//NSString *const checkSecretURL = kGameQServerURL@"chkSecret.php"
#define updateTokenURL kGameQServerURL@"upToken.php"

#define URL_ABOUT @"https://www.gameQ.com/about"

@interface LVFDefinitions : NSObject

@end
