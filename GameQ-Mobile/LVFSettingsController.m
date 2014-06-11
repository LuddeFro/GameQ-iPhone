//
//  LVFSettingsController.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/03/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFSettingsController.h"

@interface LVFSettingsController ()

@end

@implementation LVFSettingsController

- (id)initWithMainController:(LVFViewController*)controller
{
    self = [super init];
    if (self) {
        // Custom initialization
        _mainController = controller;
        _dataHandler = [[LVFDataModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    UIColor *myTransWhite = [UIColor colorWithWhite:1 alpha:0.5];
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
    UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
    
    
    
    
    
    
    
    _btnTop = [[UIButton alloc] init];
    _btnBot = [[UIButton alloc] init];
    
    
    if(self.view.frame.size.height < 568) {
        
        [_btnTop setFrame:CGRectMake(20, 390, self.view.frame.size.width-40, 30)];
        [_btnBot setFrame:CGRectMake(20, 428, self.view.frame.size.width-40, 30)];
        
    } else if (self.view.frame.size.height == 568) {
        [_btnTop setFrame:CGRectMake(20, 480, self.view.frame.size.width-40, 30)];
        [_btnBot setFrame:CGRectMake(20, 518, self.view.frame.size.width-40, 30)];
    }
    
    [_btnTop addTarget:self action:@selector(topButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_btnBot addTarget:self action:@selector(botButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_btnTop setTitle:@"About" forState:UIControlStateNormal];
    [_btnBot setTitle:@"Log Out" forState:UIControlStateNormal];
    [_btnTop setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnBot setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnTop setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnBot setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnBot setBackgroundColor:myRed];
    [_btnTop setBackgroundColor:myRed];
    
    
    
    
    
    
    
    
    //_imgBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
    //[_imgBackgroundImageView setFrame:self.view.frame];
    //[self.view addSubview:_imgBackgroundImageView];
    [self.view setBackgroundColor:myDarkGray];
    
    _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
    [_btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [_btnBack setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnBack setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnBack setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [_btnBack addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    
    
    _btnDummy = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_btnDummy setTitle:@"" forState:UIControlStateNormal];
    [_btnDummy setBackgroundColor:myRed];
    [_btnDummy setEnabled:NO];
    [self.view addSubview:_btnDummy];
    [self.view addSubview:_btnBack];
    /*
    _btnDummy2 = [[UIButton alloc] initWithFrame:CGRectMake(_btnBack.frame.origin.x+_btnBack.frame.size.width+2, _btnBack.frame.origin.y, self.view.frame.size.width - (_btnBack.frame.origin.x+_btnBack.frame.size.width+2), _btnBack.frame.size.height)];
    [_btnDummy2 setTitle:@"" forState:UIControlStateNormal];
    [_btnDummy2 setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnDummy2 setEnabled:NO];
    [self.view addSubview:_btnDummy2];
    */
    
    _btnToggleNotifications = [[UIButton alloc] initWithFrame:CGRectMake(20, 184, self.view.frame.size.width-40, 30)];
    if ([[_dataHandler getBolRegisteredForNotifications] boolValue]) {
        [_btnToggleNotifications setTitle:@"Disable Notifications" forState:UIControlStateNormal];
    } else {
        [_btnToggleNotifications setTitle:@"Enable Notifications" forState:UIControlStateNormal];
    }
    [_btnToggleNotifications setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnToggleNotifications setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnToggleNotifications setBackgroundColor:myRed];
    [_btnToggleNotifications addTarget:self action:@selector(toggleNotifications) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnToggleNotifications];
    
    _lblDynamic = [[UILabel alloc] init];
    [_lblDynamic setFrame:CGRectMake(20, 209, self.view.frame.size.width-40, 30)];
    [_lblDynamic setNumberOfLines:1];
    if ([[_dataHandler getBolRegisteredForNotifications] boolValue]) {
        [_lblDynamic setText:@"Notifications are enabled"];
    } else {
        [_lblDynamic setText:@"Notifications are disabled"];
    }
    [_lblDynamic setTextAlignment:NSTextAlignmentCenter];
    [_lblDynamic setTextColor:myWhite];
    [self.view addSubview:_lblDynamic];
    
    
    [self.view addSubview:_btnTop];
    [self.view addSubview:_btnBot];
    
    _lblTitle = [[UILabel alloc] init];
    [_lblTitle setFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
    [_lblTitle setNumberOfLines:1];
    [_lblTitle setText:@"Settings"];
    [_lblTitle setTextAlignment:NSTextAlignmentCenter];
    [_lblTitle setTextColor:myWhite];
    [_lblTitle setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:_lblTitle];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}




-(void) toggleNotifications
{
    if ([[_dataHandler getBolRegisteredForNotifications] boolValue]) {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        [_dataHandler setBolRegisteredForNotifications:[NSNumber numberWithBool:NO]];
        [_btnToggleNotifications setTitle:@"Enable Notifications" forState:UIControlStateNormal];
        [_lblDynamic setText:@"Notifications are disabled"];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        [_dataHandler setBolRegisteredForNotifications:[NSNumber numberWithBool:YES]];
        [_btnToggleNotifications setTitle:@"Disable Notifications" forState:UIControlStateNormal];
        [_lblDynamic setText:@"Notifications are enabled"];
    }
}

-(void) popController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void) topButtonPressed {
    _aboutController = [[LVFAboutController alloc] init];
    [self presentViewController:_aboutController animated:YES completion:NULL];
}

-(void) botButtonPressed {
    [_mainController.btnTop setEnabled:NO];
    [_mainController.btnBot setEnabled:NO];
    [_mainController.connectionsHandler logoutPostFromToken:[_mainController.dataHandler getToken]];
    [_mainController setupNothing];
    //[self popController];
    //[self dismissViewControllerAnimated:YES completion:NULL];
    [_mainController popControllers];
    
}




@end
