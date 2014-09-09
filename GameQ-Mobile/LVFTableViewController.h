//
//  LVFTableController.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 07/11/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
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

@interface LVFTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) LVFConnections *connectionsHandler;
@property (strong, nonatomic) LVFSettingsController *settingsController;
@property (strong, nonatomic) LVFViewController *mainController;
@property (strong, nonatomic) LVFTableView *tableView;
@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) NSMutableArray *deviceArray;
@property (strong, nonatomic) NSMutableArray *array0;
@property (strong, nonatomic) NSMutableArray *array1;
@property (strong, nonatomic) NSMutableArray *array2;
@property (strong, nonatomic) NSMutableArray *array3;
@property (strong, nonatomic) NSMutableArray *array4;



@property (strong, nonatomic) NSTimer *refreshTimer;

- (id)initWithMainController:(LVFViewController*)controller;
- (void) requestUpdate;
- (void) receiveUpdate:(NSMutableArray*)array;
- (void) popController;
- (void) reload;
@end
