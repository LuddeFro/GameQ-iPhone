//
//  LVFViewControllerTwo.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 22/02/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFViewControllerTwo.h"

@interface LVFViewControllerTwo ()

@end

@implementation LVFViewControllerTwo

- (id)initWithMainController:(LVFViewController*)controller
{
    self = [super init];
    if (self) {
        // Custom initialization
        _mainController = controller;
    }
    return self;
}

- (void)viewDidLoad
{
    _imgBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
    _imgLogoImageView = [[UIImageView alloc] init];
    [_imgLogoImageView setImage:[UIImage imageNamed:@"GQLogo.png"]];
    
    
    
    if(self.view.frame.size.height < 568) {
        [_imgLogoImageView setFrame:CGRectMake(7, 35, 306, 87)];
        
    } else if (self.view.frame.size.height == 568) {
        [_imgLogoImageView setFrame:CGRectMake(7, 65, 306, 87)];
        
    }
    
    
    _btnMyDevices = [[UIButton alloc] initWithFrame:CGRectMake(0, 194, self.view.frame.size.width, 30)];
    _btnSettings = [[UIButton alloc] initWithFrame:CGRectMake(0, 232, self.view.frame.size.width, 30)];
    _btnAbout = [[UIButton alloc] initWithFrame:CGRectMake(0, 270, self.view.frame.size.width, 30)];
    _btnLog = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 30)];
    
    
    
    
    
    
    [_btnMyDevices setTitle:@"My Devices" forState:UIControlStateNormal];
    [_btnSettings setTitle:@"Settings" forState:UIControlStateNormal];
    [_btnAbout setTitle:@"About" forState:UIControlStateNormal];
    [_btnLog setTitle:@"Log Out" forState:UIControlStateNormal];
    
    [_btnMyDevices setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    [_btnSettings setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    [_btnAbout setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    [_btnLog setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    
    [_btnMyDevices setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [_btnSettings setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [_btnAbout setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [_btnLog setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    
    
    
    [_btnMyDevices setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnSettings setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnAbout setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [_btnLog setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    
    [_btnMyDevices addTarget:self action:@selector(pushTableViewController) forControlEvents:UIControlEventTouchUpInside];
    [_btnSettings addTarget:self action:@selector(pushSettingsController) forControlEvents:UIControlEventTouchUpInside];
    [_btnAbout addTarget:self action:@selector(pushAboutController) forControlEvents:UIControlEventTouchUpInside];
    [_btnLog addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_imgBackgroundImageView];
    [self.view addSubview:_imgLogoImageView];
    [self.view addSubview:_btnMyDevices];
    [self.view addSubview:_btnSettings];
    [self.view addSubview:_btnAbout];
    [self.view addSubview:_btnLog];
    
}


-(void)pushAboutController
{
    [_mainController visitPage:nil];
}

-(void)pushSettingsController
{
    
}

-(void) popController
{
    [_mainController.btnLog setEnabled:NO];
    [_mainController.connectionsHandler logoutPostFromToken:[_mainController.dataHandler getToken]];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if(self.view.frame.size.height < 568) {
        [_mainController.imgLogo setFrame:CGRectMake(8, 34, 304, 90)];
        [_mainController.txtEmail setFrame:CGRectMake(78, 162, 165, 30)];
        [_mainController.txtPassword setFrame:CGRectMake(95, 200, 131, 30)];
        [_mainController.btnLog setFrame:CGRectMake(0, 240, self.view.frame.size.width, 30)];
        [_mainController.lblChanging setFrame:CGRectMake(33, 268, 254, 77)];
        [_mainController.lblNotChanging setFrame:CGRectMake(33, 353, 254, 67)];
        [_mainController.btnAbout setFrame:CGRectMake(0, 428, self.view.frame.size.width, 30)];
    }
    
}

- (IBAction)pushTableViewController
{
    _tableViewController = [[LVFTableViewController alloc] initWithMainController:_mainController];
    [self presentViewController:_tableViewController animated:YES completion:NULL];
}


@end
