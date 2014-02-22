//
//  LVFViewControllerTwo.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 22/02/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFTableViewController.h"
#import "LVFViewController.h"

@class LVFDataModel;
@class LVFTableViewController;
@class LVFConnections;
@class LVFViewController;

@interface LVFViewControllerTwo : UIViewController





@property (strong, nonatomic) LVFTableViewController *tableViewController;
@property (strong, nonatomic) LVFViewController *mainController;

@property UIImageView *imgBackgroundImageView;
@property UIImageView *imgLogoImageView;
@property UIButton *btnMyDevices;
@property UIButton *btnSettings;
@property UIButton *btnAbout;
@property UIButton *btnLog;

- (id)initWithMainController:(LVFViewController*)controller;


@end
