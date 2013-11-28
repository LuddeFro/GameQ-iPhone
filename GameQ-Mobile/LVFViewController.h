//
//  LVFViewController.h
//  GameQ
//
//  Created by Ludvig Fröberg on 10/21/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFConnections.h"
#import "LVFDataModel.h"
#import "LVFAppDelegate.h"
#import "LVFConnect.h"
#import "LVFDefinitions.h"
#import "LVFTableViewController.h"


@class LVFDataModel;
@class LVFTableViewController;
@class LVFConnections;

@interface LVFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLog;
@property (weak, nonatomic) IBOutlet UILabel *lblChanging;
@property bool bolLoggedIn;
@property (strong, nonatomic) LVFDataModel *dataHandler;
@property (strong, nonatomic) LVFTableViewController *tableViewController;
@property (strong, nonatomic) UINavigationController *navView;
@property (strong, nonatomic) LVFConnections* connectionsHandler;
- (IBAction) log:(id)sender;
- (IBAction) visitPage:(id)sender;
- (void) setDisconnected;
- (void) setConnected;
-(void) popTableViewController;

@end
