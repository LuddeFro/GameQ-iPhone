//
//  LVFDefinitions.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/23/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGameQServerURL @"http://server.gameq.io/GameQ_Server_Code/"
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
#define upMyGamesURL kGameQServerURL@"upMyGames.php"
#define getMyGamesURL kGameQServerURL@"getMyGames.php"
#define kAPPID @"GameQ"

#define versionURL kGameQServerURL@"versionControl.php"
#define URL_FACEBOOK @"fb://profile/304122193079686"
#define URL_TWITTER @"https://twitter.com/GameQApp"
#define URL_ABOUT @"http://www.gameQ.io#read-more"
#define kVersion @"1.0"



#define kNOGAME 0
#define kHEROES_OF_NEWERTH 1
#define kDOTA2 2
#define kCS_GO 3
#define kSMITE 4
#define kSTRIFE 5
#define kSC2 6
#define kTF2 7
#define kHOTS 8
#define kLOL 9
#define kNumGames 10

#define kOFF 4
#define kOFFLINE 0
#define kONLINE 1
#define kINGAME 2
#define kNOTTRACKING 3


@interface LVFDefinitions : NSObject

@end
