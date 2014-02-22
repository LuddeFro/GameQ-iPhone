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

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        
        _imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQLogo.png"]];
        _imgBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
        _txtEmail = [[UITextField alloc] init];
        _txtPassword = [[UITextField alloc] init];
        _btnLog = [[UIButton alloc] init];
        _lblChanging = [[UILabel alloc] init];
        _lblNotChanging = [[UILabel alloc] init];
        _btnAbout = [[UIButton alloc] init];
        _btnResignKeyboard = [[UIButton alloc] initWithFrame:self.view.frame];
        
        
        
        if(self.view.frame.size.height < 568) {
            [_imgLogo setFrame:CGRectMake(8, 34, 304, 90)];
            [_txtEmail setFrame:CGRectMake(78, 162, 165, 30)];
            [_txtPassword setFrame:CGRectMake(95, 200, 131, 30)];
            [_btnLog setFrame:CGRectMake(0, 240, self.view.frame.size.width, 30)];
            [_lblChanging setFrame:CGRectMake(33, 268, 254, 77)];
            [_lblNotChanging setFrame:CGRectMake(33, 353, 254, 67)];
            [_btnAbout setFrame:CGRectMake(0, 428, self.view.frame.size.width, 30)];
        } else if (self.view.frame.size.height == 568) {
            [_imgLogo setFrame:CGRectMake(8, 64, 304, 90)];
            [_txtEmail setFrame:CGRectMake(78, 203, 165, 30)];
            [_txtPassword setFrame:CGRectMake(95, 241, 131, 30)];
            [_btnLog setFrame:CGRectMake(0, 279, self.view.frame.size.width, 30)];
            [_lblChanging setFrame:CGRectMake(33, 327, 254, 77)];
            [_lblNotChanging setFrame:CGRectMake(33, 417, 254, 67)];
            [_btnAbout setFrame:CGRectMake(0, 518, self.view.frame.size.width, 30)];
        }
        
        [_btnLog addTarget:self action:@selector(log:) forControlEvents:UIControlEventTouchUpInside];
        [_btnAbout addTarget:self action:@selector(visitPage:) forControlEvents:UIControlEventTouchUpInside];
        [_btnResignKeyboard addTarget:self action:@selector(resignKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_txtPassword setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        [_txtEmail setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        [_txtEmail setPlaceholder:@"E-mail"];
        [_txtPassword setPlaceholder:@"Password"];
        [_txtPassword setFont:[UIFont systemFontOfSize:14]];
        [_txtEmail setFont:[UIFont systemFontOfSize:14]];
        [_txtPassword setBorderStyle:UITextBorderStyleRoundedRect];
        [_txtEmail setBorderStyle:UITextBorderStyleRoundedRect];
        [_txtPassword setSecureTextEntry:YES];
        [_txtPassword setKeyboardType:UIKeyboardTypeAlphabet];
        [_txtEmail setKeyboardType:UIKeyboardTypeEmailAddress];
        [_txtPassword setReturnKeyType:UIReturnKeyDone];
        [_txtEmail setReturnKeyType:UIReturnKeyDone];
        [_txtEmail setDelegate:self];
        [_txtPassword setDelegate:self];
        
        
        [_btnLog setTitle:@"Log In" forState:UIControlStateNormal];
        [_btnAbout setTitle:@"www.GameQ.com/about" forState:UIControlStateNormal];
        [_btnLog setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
        [_btnAbout setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
        [_btnLog setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
        [_btnAbout setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
        [_btnAbout setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
        [_btnLog setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
        
        [_lblChanging setText:@"Log in to receive notifications from your other connected devices!"];
        [_lblNotChanging setText:@"To learn more about connecting devices and what this service provides, please visit:"];
        [_lblChanging setTextColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]];
        [_lblNotChanging setTextColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1]];
        [_lblChanging setFont:[UIFont systemFontOfSize:17]];
        [_lblNotChanging setFont:[UIFont systemFontOfSize:17]];
        [_lblNotChanging setNumberOfLines:0];
        [_lblChanging setNumberOfLines:0];
        
        
        [self.view addSubview:_imgBackground];
        [self.view addSubview:_imgLogo];
        [self.view addSubview:_lblChanging];
        [self.view addSubview:_lblNotChanging];
        [self.view addSubview:_btnResignKeyboard];
        [self.view addSubview:_txtEmail];
        [self.view addSubview:_txtPassword];
        [self.view addSubview:_btnLog];
        [self.view addSubview:_btnAbout];
        
        
        
        
        
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignKeyboard:nil];
    return YES;
}




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

-(void) viewDidAppear:(BOOL)animated
{
    if(self.view.frame.size.height < 568) {
        [_imgLogo setFrame:CGRectMake(8, 34, 304, 90)];
        [_txtEmail setFrame:CGRectMake(78, 162, 165, 30)];
        [_txtPassword setFrame:CGRectMake(95, 200, 131, 30)];
        [_btnLog setFrame:CGRectMake(0, 240, self.view.frame.size.width, 30)];
        [_lblChanging setFrame:CGRectMake(33, 268, 254, 77)];
        [_lblNotChanging setFrame:CGRectMake(33, 353, 254, 67)];
        [_btnAbout setFrame:CGRectMake(0, 428, self.view.frame.size.width, 30)];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resignKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)log:(id)sender {
    [self.view endEditing:YES];
        [_dataHandler setEmail:_txtEmail.text];
        [_connectionsHandler loginWithUser:_txtEmail.text andPass:_txtPassword.text];
        [_btnLog setEnabled:NO];
    
    
    
}

-(void) setConnected
{
    
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
    [_connectionsHandler.gqConnect postNow:[NSString stringWithFormat:@"token=%@&deviceName=%@&email=%@", [_dataHandler getToken], [_dataHandler getDeviceID], [_dataHandler getEmail]] to:updateTokenURL];
    NSLog(@"stored data:\r\nloggedin: %@\r\nemail: %@\r\ntoken: %@\r\npassword: like I would tell you :P \r\ndeviceID:%@", [_dataHandler getBolIsLoggedIn], [_dataHandler getEmail], [_dataHandler getToken], [_dataHandler getDeviceID]);
    [self pushSecondViewController];
}

- (IBAction)pushSecondViewController
{
    
    _secondViewController = [[LVFViewControllerTwo alloc] initWithMainController:self];
    [self presentViewController:_secondViewController animated:YES completion:NULL];
}

-(void) popSecondViewController
{
    NSLog(@"popping");
}

- (void) setDisconnected
{
    [_txtPassword setText:@""];
    [[self btnLog] setTitle:@"Log In" forState:UIControlStateNormal];
    [_lblChanging setText:@"Log in to receive notifications from your other connected devices"];
    
    _bolLoggedIn = NO;
    [_dataHandler setBolIsLoggedIn:[NSNumber numberWithBool:_bolLoggedIn]];
    [_dataHandler setEmail:_txtEmail.text];
    [_dataHandler setPass:@""];
}

- (IBAction)visitPage:(id)sender {
    [self.view endEditing:YES];
    NSURL *urlAbout = [[NSURL alloc] initWithString:URL_ABOUT];
    [[UIApplication sharedApplication] openURL:urlAbout];
    
}



@end














