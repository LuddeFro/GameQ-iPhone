//
//  LVFViewControllerTwo.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 20/08/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFConnections.h"
#import "LVFViewController.h"
#import "LVFTableViewController.h"
#import "LVFSettingsController.h"

#import "LVFTableView.h"
#import "LVFCell.h"

@class LVFConnections;
@class LVFViewController;
@class LVFTableView;
@class LVFSettingsController;

@interface LVFViewControllerTwo : UIViewController



@property (strong, nonatomic) LVFViewController *mainController;

@property (strong, nonatomic) UIImageView *imgGameFrame;
@property (strong, nonatomic) UIImageView *imgGameLogo;
@property (strong, nonatomic) UILabel *lblApproxTime;
@property (strong, nonatomic) UILabel *lblStatus;
@property (strong, nonatomic) UILabel *lblGame;
@property (strong, nonatomic) UILabel *lblCountdown;

@property (assign, nonatomic) NSInteger index;

@property int lastPic;
@property (strong, nonatomic) NSString *displayItem;

- (id)initWithMainController:(LVFViewController*)controller;
- (void)reload;
- (void)tickDown;
@end
