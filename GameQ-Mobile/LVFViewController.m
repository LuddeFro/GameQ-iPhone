//
//  LVFViewController.m
//  GameQ
//
//  Created by Ludvig Fröberg on 10/21/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import "LVFViewController.h"


@interface LVFViewController ()


@end

@implementation LVFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _connectionsHandler = [[LVFConnections alloc] initFromController:self];
    _dataHandler = [[LVFDataModel alloc] init];
    
    // get saved data
    NSNumber *aNumber = [_dataHandler getBolIsLoggedIn];
    _txtEmail.text = [_dataHandler getEmail];
    _bolLoggedIn = [aNumber boolValue];
    if ([_dataHandler getDeviceID] == NULL) {
        [_dataHandler setDeviceID:[[UIDevice currentDevice] name]];
    }
    NSLog(@"stored data:\r\nloggedin: %@\r\nemail: %@\r\ntoken: %@\r\npassword: like I would tell you :P \r\ndeviceID:%@", [_dataHandler getBolIsLoggedIn], [_dataHandler getEmail], [_dataHandler getToken], [_dataHandler getDeviceID]);
    if (_bolLoggedIn) {
        [_connectionsHandler loginWithUser:[_dataHandler getEmail] andPass:[_dataHandler getPass]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)log:(id)sender {
    if (_bolLoggedIn) {
        [_connectionsHandler logoutPost];
        _bolLoggedIn = 0;
    } else {
        [_connectionsHandler loginWithUser:_txtEmail.text andPass:_txtPassword.text];
    }
    
    
}

-(void) setConnected
{
    [_btnLog setTitle:@"Log Out" forState:UIControlStateNormal];
    [_txtEmail setEnabled:NO];
    [_txtPassword setEnabled:NO];
    [_lblChanging setText:@"This device will now receive notifications from your other connected devices"];
    [_txtEmail setTextColor:[UIColor grayColor]];
    _bolLoggedIn = YES;
    [_dataHandler setBolIsLoggedIn:[NSNumber numberWithBool:_bolLoggedIn]];
    [_dataHandler setEmail:_txtEmail.text];
    [_dataHandler setPass:_txtPassword.text];
    [_txtPassword setText:@""];
    NSLog(@"changes saved");
    [_connectionsHandler.gqConnect postNow:[NSString stringWithFormat:@"token=%@&device=%@", [_dataHandler getToken], [_dataHandler getDeviceID]] to:updateTokenURL];
    NSLog(@"stored data:\r\nloggedin: %@\r\nemail: %@\r\ntoken: %@\r\npassword: like I would tell you :P \r\ndeviceID:%@", [_dataHandler getBolIsLoggedIn], [_dataHandler getEmail], [_dataHandler getToken], [_dataHandler getDeviceID]);
    [self pushTableViewController];
}

- (IBAction)pushTableViewController
{
    _tableViewController = [[LVFTableViewController alloc] initWithMainController:self];
    [self presentViewController:_tableViewController animated:YES completion:NULL];
    
    
}

-(void) popTableViewController
{
    NSLog(@"popping");
}

- (void) setDisconnected
{
    [_txtPassword setText:@""];
    [[self btnLog] setTitle:@"Log In" forState:UIControlStateNormal];
    [[self txtEmail] setEnabled:YES];
    [[self txtPassword] setEnabled:YES];
    [[self lblChanging] setText:@"Log in to receive notifications from your other connected devices"];
    [_txtEmail setTextColor:[UIColor blackColor]];
    _bolLoggedIn = NO;
    [_dataHandler setBolIsLoggedIn:[NSNumber numberWithBool:_bolLoggedIn]];
    [_dataHandler setEmail:_txtEmail.text];
    [_dataHandler setPass:@""];
}

- (IBAction)visitPage:(id)sender {
    NSURL *urlAbout = [[NSURL alloc] initWithString:URL_ABOUT];
    [[UIApplication sharedApplication] openURL:urlAbout];
    
}

@end














