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
-(void) viewDidAppear:(BOOL)animated
{
    _mainController.secondViewController.currentIndex = 0;
    [_mainController.secondViewController animateAppearance];
}

-(void) viewWillAppear:(BOOL)animated
{
    _mainController.secondViewController.currentIndex = 0;
    [_mainController.secondViewController animateDisappearance];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    UIColor *myTransWhite = [UIColor colorWithWhite:1 alpha:0.5];
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
  //  UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
    
    
    
    
    
    
    
    _btnTop = [[UIButton alloc] init];
    _btnBot = [[UIButton alloc] init];
    
    CGRect frameImgLogo;
    if(self.view.frame.size.height < 568) {
        
        [_btnTop setFrame:CGRectMake(20, 400, self.view.frame.size.width-40, 30)];
        [_btnBot setFrame:CGRectMake(20, 438, self.view.frame.size.width-40, 30)];
         _btnToggleNotifications = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, self.view.frame.size.width-40, 30)];
        frameImgLogo = CGRectMake(70, 136, 180, 180);
        
    } else if (self.view.frame.size.height == 568) {
        [_btnTop setFrame:CGRectMake(20, 490, self.view.frame.size.width-40, 30)];
        [_btnBot setFrame:CGRectMake(20, 528, self.view.frame.size.width-40, 30)];
        _btnToggleNotifications = [[UIButton alloc] initWithFrame:CGRectMake(20, 90, self.view.frame.size.width-40, 30)];
        frameImgLogo = CGRectMake(40, 136, 240, 240);
    } else {frameImgLogo = CGRectMake(40, 136, 240, 240);} //should never be called
    
    [_btnTop addTarget:self action:@selector(topButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_btnBot addTarget:self action:@selector(botButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_btnTop setTitle:@"About" forState:UIControlStateNormal];
    [_btnBot setTitle:@"Sign Out" forState:UIControlStateNormal];
    [_btnTop setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnBot setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnTop setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnBot setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnBot setBackgroundColor:myRed];
    [_btnTop setBackgroundColor:myRed];
    
    
    _imgGameLogo = [[UIImageView alloc] initWithFrame:frameImgLogo];
    _imgGameLogo.layer.cornerRadius = 20.0;
    _imgGameLogo.layer.masksToBounds = YES;
    [_imgGameLogo setImage:[UIImage imageNamed:@"sqt.png"]];
    _imgGameLogo.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:_imgGameFrame];
    [self.view addSubview:_imgGameLogo];
    
    
    
    _lblLikeUs = [[UILabel alloc] init];
    [_lblLikeUs setFrame:CGRectMake(20, self.view.frame.size.height-190, self.view.frame.size.width-40, 50)];
    [_lblLikeUs setTextAlignment:NSTextAlignmentCenter];
    [_lblLikeUs setNumberOfLines:0];
    [_lblLikeUs setText:@"Follow/Like us on..."];
    [_lblLikeUs setTextColor:myWhite];
    [self.view addSubview:_lblLikeUs];
    
    _btnFacebook = [[UIButton alloc] initWithFrame:CGRectMake(100, _lblLikeUs.frame.origin.y + 45, 48, 48)];
    [_btnFacebook setTitle:@"" forState:UIControlStateNormal];
    [_btnFacebook setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [_btnFacebook setEnabled:YES];
    [_btnFacebook setBackgroundImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
    [_btnFacebook addTarget:self action:@selector(facebookSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnFacebook];
    
    _btnTwitter = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-(48+100), _lblLikeUs.frame.origin.y + 45, 48, 48)];
    [_btnTwitter setTitle:@"" forState:UIControlStateNormal];
    [_btnTwitter setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [_btnTwitter setEnabled:YES];
    [_btnTwitter setBackgroundImage:[UIImage imageNamed:@"tw.png"] forState:UIControlStateNormal];
    [_btnTwitter addTarget:self action:@selector(twitterSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnTwitter];
    
    
 
    
    
    
    
    //_imgBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
    //[_imgBackgroundImageView setFrame:self.view.frame];
    //[self.view addSubview:_imgBackgroundImageView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    
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
    
    //_btnToggleNotifications = [[UIButton alloc] initWithFrame:CGRectMake(20, 184, self.view.frame.size.width-40, 30)];
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
    
//    _lblDynamic = [[UILabel alloc] init];
//    [_lblDynamic setFrame:CGRectMake(20, 209, self.view.frame.size.width-40, 30)];
//    [_lblDynamic setNumberOfLines:1];
//    if ([[_dataHandler getBolRegisteredForNotifications] boolValue]) {
//        [_lblDynamic setText:@"Notifications are enabled"];
//    } else {
//        [_lblDynamic setText:@"Notifications are disabled"];
//    }
//    [_lblDynamic setTextAlignment:NSTextAlignmentCenter];
//    [_lblDynamic setTextColor:myWhite];
//    [self.view addSubview:_lblDynamic];
    
    
    [self.view addSubview:_btnTop];
    [self.view addSubview:_btnBot];
    
    _lblTitle = [[UILabel alloc] init];
    [_lblTitle setFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
    [_lblTitle setNumberOfLines:1];
    [_lblTitle setText:@"Settings"];
    [_lblTitle setTextAlignment:NSTextAlignmentCenter];
    [_lblTitle setTextColor:myWhite];
    [_lblTitle setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:_lblTitle];
    
    
}

-(void) reload{
    return;
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

-(void)facebookSelected
{
    NSLog(@"Facebook selected");
    [self.view endEditing:YES];
    NSURL *urlAbout = [[NSURL alloc] initWithString:URL_FACEBOOK];
    [[UIApplication sharedApplication] openURL:urlAbout];
}
-(void)twitterSelected
{
    NSLog(@"Twitter selected");
    [self.view endEditing:YES];
    NSURL *urlAbout = [[NSURL alloc] initWithString:URL_TWITTER];
    [[UIApplication sharedApplication] openURL:urlAbout];
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
