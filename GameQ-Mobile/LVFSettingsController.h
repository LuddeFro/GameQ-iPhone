//
//  LVFSettingsController.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/03/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFDataModel.h"

@class LVFDataModel;

@interface LVFSettingsController : UIViewController

@property UIImageView *imgBackgroundImageView;
@property UIButton *btnToggleNotifications;
@property UIButton *btnBack;
@property UIButton *btnDummy;
@property UIButton *btnDummy2;
@property LVFDataModel *dataHandler;
@property UILabel *lblDynamic;
@property UILabel *lblStatic;

@end
