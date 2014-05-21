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

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _dataHandler = [[LVFDataModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    _imgBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
    [self.view addSubview:_imgBackgroundImageView];
    
    
    _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-70, 25, 50, 30)];
    [_btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [_btnBack setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    [_btnBack setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [_btnBack setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnBack addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBack];
    
    _btnDummy = [[UIButton alloc] initWithFrame:CGRectMake(0, _btnBack.frame.origin.y, _btnBack.frame.origin.x-2, _btnBack.frame.size.height)];
    [_btnDummy setTitle:@"" forState:UIControlStateNormal];
    [_btnDummy setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnDummy setEnabled:NO];
    [self.view addSubview:_btnDummy];
    
    _btnDummy2 = [[UIButton alloc] initWithFrame:CGRectMake(_btnBack.frame.origin.x+_btnBack.frame.size.width+2, _btnBack.frame.origin.y, self.view.frame.size.width - (_btnBack.frame.origin.x+_btnBack.frame.size.width+2), _btnBack.frame.size.height)];
    [_btnDummy2 setTitle:@"" forState:UIControlStateNormal];
    [_btnDummy2 setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnDummy2 setEnabled:NO];
    [self.view addSubview:_btnDummy2];
    
    
    _btnToggleNotifications = [[UIButton alloc] initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, 30)];
    if ([[_dataHandler getBolRegisteredForNotifications] boolValue]) {
        [_btnToggleNotifications setTitle:@"Disable Notifications" forState:UIControlStateNormal];
    } else {
        [_btnToggleNotifications setTitle:@"Enable Notifications" forState:UIControlStateNormal];
    }
    [_btnToggleNotifications setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    [_btnToggleNotifications setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [_btnToggleNotifications setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnToggleNotifications addTarget:self action:@selector(toggleNotifications) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnToggleNotifications];
    
    _lblDynamic = [[UILabel alloc] init];
    [_lblDynamic setFrame:CGRectMake(20, 169, self.view.frame.size.width-40, 30)];
    [_lblDynamic setNumberOfLines:1];
    if ([[_dataHandler getBolRegisteredForNotifications] boolValue]) {
        [_lblDynamic setText:@"Notifications are enabled"];
    } else {
        [_lblDynamic setText:@"Notifications are disabled"];
    }
    [_lblDynamic setTextAlignment:NSTextAlignmentCenter];
    [_lblDynamic setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [self.view addSubview:_lblDynamic];
    
    _lblStatic = [[UILabel alloc] init];
    [_lblStatic setFrame:CGRectMake(20, 199, self.view.frame.size.width-40, self.view.frame.size.height-244)];
    [_lblStatic setNumberOfLines:0];
    [_lblStatic setText:@"More notification options can be accessed in the notifications-center section of your \"Settings\" application!"];
    [_lblStatic setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [self.view addSubview:_lblStatic];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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




@end
