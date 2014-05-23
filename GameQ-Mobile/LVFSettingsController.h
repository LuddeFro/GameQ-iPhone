//
//  LVFSettingsController.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/03/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFDataModel.h"
#import "LVFViewController.h"
#import "LVFAboutController.h"

@class LVFViewController;
@class LVFDataModel;
@class LVFAboutController;

@interface LVFSettingsController : UIViewController

@property UIImageView *imgBackgroundImageView;
@property UIButton *btnToggleNotifications;
@property (strong, nonatomic) LVFViewController *mainController;
@property UIButton *btnBack;
@property UIButton *btnDummy;
@property UIButton *btnDummy2;
@property LVFDataModel *dataHandler;
@property UILabel *lblDynamic;
@property (strong, nonatomic) LVFAboutController *aboutController;


@property (strong, nonatomic) UIButton *btnTop;

@property (strong, nonatomic) UIButton *btnBot;

- (id)initWithMainController:(LVFViewController*)controller;

@end
