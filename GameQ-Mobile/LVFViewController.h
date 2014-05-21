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
#import "LVFViewControllerTwo.h"



@class LVFDataModel;
@class LVFTableViewController;
@class LVFConnections;
@class LVFViewControllerTwo;

@interface LVFViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *txtEmail;
@property (strong, nonatomic) UITextField *txtPassword;
@property (strong, nonatomic) UITextField *txtSecret;
@property (strong, nonatomic) UITextField *txtSecretQ;
@property BOOL bolIsRegging;
@property BOOL bolIsLogging;


@property (strong, nonatomic) UIButton *btnTop;

@property (strong, nonatomic) UIImageView *imgLogo;
@property (strong, nonatomic) UIImageView *imgBackground;
@property (strong, nonatomic) UIButton *btnBot;
@property (strong, nonatomic) UIButton *btnResignKeyboard;

@property bool bolLoggedIn;
@property (strong, nonatomic) LVFDataModel *dataHandler;
@property (strong, nonatomic) UINavigationController *navView;
@property (strong, nonatomic) LVFConnections* connectionsHandler;
@property (weak, nonatomic) IBOutlet UIButton *btnKeyboardDown;
@property (strong, nonatomic) LVFViewControllerTwo *secondViewController;
- (IBAction)resignKeyboard:(id)sender;
- (void) log;
- (void) setDisconnected;
- (void) setConnected;
-(void) popSecondViewController;

@end
