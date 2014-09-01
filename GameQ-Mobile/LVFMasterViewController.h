//
//  LVFMasterViewController.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 20/08/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFViewControllerTwo.h"
#import "LVFTableViewController.h"

@class LVFTableViewController;
@class LVFViewControllerTwo;

@interface LVFMasterViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
//@property (strong, nonatomic) UIPageControl *pcDots;

@property (strong, nonatomic) LVFConnections *connectionsHandler;
@property (strong, nonatomic) LVFViewController *mainController;
@property (strong, nonatomic) NSMutableArray *deviceArray;
@property (strong, nonatomic) NSMutableArray *array0;
@property (strong, nonatomic) NSMutableArray *array1;
@property (strong, nonatomic) NSMutableArray *array2;
@property (strong, nonatomic) NSMutableArray *array4;

@property (strong, nonatomic) LVFSettingsController *settingsController;
@property (strong, nonatomic) UINavigationBar *navBar;

@property (strong, nonatomic) LVFTableViewController *tableViewController;
@property (strong, nonatomic) LVFViewControllerTwo *simpleViewController;

@property int currentIndex;
@property CGRect leftItemRect;
@property CGRect rightItemRect;
@property CGRect centerItemRect;
@property CGRect outLeftItemRect;
@property CGRect outRightItemRect;
@property (strong, nonatomic) UIButton *listView;
@property (strong, nonatomic) UIButton *logoView;
@property (strong, nonatomic) UIButton *gearView;
@property bool bolButtonPressed;
@property bool bolButtonPressedHelper;
@property (strong, nonatomic) UIImageView *imgBackgroundView;

@property bool bolFoundScrollView;
@property (strong, nonatomic) NSTimer *refreshTimer;

@property int intIndex;
@property (strong, nonatomic) NSTimer *countdownTimer;
@property bool bolAlreadyCounting;
@property bool bolSkipIt;
- (id)initWithMainController:(LVFViewController*)controller;
- (void) requestUpdate;
- (void) receiveUpdate:(NSMutableArray*)array;
- (void) popController;
- (NSString *) getDisplayItem;
- (void) animateAppearance;
- (void) animateDisappearance;
@end
