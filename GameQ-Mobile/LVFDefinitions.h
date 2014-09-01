//
//  LVFDefinitions.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/23/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGameQServerURL @"http://54.76.41.235/GameQ_Server_Code/"
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

#define versionURL kGameQServerURL@"versionControl.php"
#define URL_FACEBOOK @"https://www.facebook.com/GameQApp"
#define URL_TWITTER @"https://twitter.com/GameQApp"
#define URL_ABOUT @"http://www.gameQ.io#read-more"
#define kVersion @"1.0"
@interface LVFDefinitions : NSObject

@end
