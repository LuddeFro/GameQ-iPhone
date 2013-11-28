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

#import "LVFTableView.h"

@class LVFConnections;
@class LVFViewController;
@class LVFTableView;

@interface LVFTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) LVFConnections *connectionsHandler;
@property (strong, nonatomic) LVFViewController *mainController;
@property (strong, nonatomic) LVFTableView *tableView;
@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) NSMutableArray *deviceArray;

- (id)initWithMainController:(LVFViewController*)controller;
- (void) requestUpdate;
- (void) receiveUpdate:(NSMutableArray*)array;

@end