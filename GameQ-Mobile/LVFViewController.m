//
//  LVFViewController.m
//  GameQ
//
//  Created by Ludvig Fröberg on 10/21/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import "LVFViewController.h"


@interface LVFViewController () <UITextFieldDelegate>


@end

@implementation LVFViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        
        UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
        UIColor *myTransWhite = [UIColor colorWithWhite:1 alpha:0.5];
        UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:0.9001];
        UIColor *myTransRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:0.6001];
//        UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
        
        
        
        _bolIsRegging = false;
        _bolIsUp = false;
        _imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sqt.png"]];
        
        _txtEmail = [[UITextField alloc] init];
        _txtPassword = [[UITextField alloc] init];
        _txtSecret = [[UITextField alloc] init];
        _txtSecretQ = [[UITextField alloc] init];
        
        _btnTop = [[UIButton alloc] init];
        _btnBot = [[UIButton alloc] init];
        _btnResignKeyboard = [[UIButton alloc] initWithFrame:self.view.frame];
        //[_imgBackground setFrame:self.view.frame];
        
        
        //trying without bkgrnd pic
        
        //and with bkgrnd color
        _imgBackgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
        
        [_imgBackgroundView setImage:[UIImage imageNamed:@"blurred.png"]];
        
        [self.view addSubview:_imgBackgroundView];
        
        
        if(self.view.frame.size.height < 568) {
            [_imgLogo setFrame:CGRectMake((self.view.frame.size.width-128)/2, 65, 128, 128)];
            
            [_txtEmail setFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 30)];
            [_txtPassword setFrame:CGRectMake(20, 238, self.view.frame.size.width-40, 30)];
            [_txtSecretQ setFrame:CGRectMake(20, 286, self.view.frame.size.width-40, 30)];
            [_txtSecret setFrame:CGRectMake(20, 324, self.view.frame.size.width-40, 30)];
            
            [_btnTop setFrame:CGRectMake(20, 370, self.view.frame.size.width-40, 40)];
            [_btnBot setFrame:CGRectMake(20, 418, self.view.frame.size.width-40, 40)];
            
        } else if (self.view.frame.size.height >= 568) {
            [_imgLogo setImage:[UIImage imageNamed:@"sqt@2x.png"]];
            [_imgLogo setFrame:CGRectMake((self.view.frame.size.width-128)/2, 65, 128, 128)];
            [_txtEmail setFrame:CGRectMake(20, 241, self.view.frame.size.width-40, 30)];
            [_txtPassword setFrame:CGRectMake(20, 279, self.view.frame.size.width-40, 30)];
            [_txtSecretQ setFrame:CGRectMake(20, 327, self.view.frame.size.width-40, 30)];
            [_txtSecret setFrame:CGRectMake(20, 365, self.view.frame.size.width-40, 30)];
            
            [_btnTop setFrame:CGRectMake(20, 460, self.view.frame.size.width-40, 40)];
            [_btnBot setFrame:CGRectMake(20, 508, self.view.frame.size.width-40, 40)];
        }
        
        [_btnTop addTarget:self action:@selector(topButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_btnBot addTarget:self action:@selector(botButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_btnResignKeyboard addTarget:self action:@selector(resignKeyboard:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_txtPassword setBackgroundColor:myWhite];
        [_txtEmail setBackgroundColor:myWhite];
        [_txtEmail setPlaceholder:@" E-mail"];
        [_txtPassword setPlaceholder:@" Password"];
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
        [_txtPassword setHidden:false];
        [_txtEmail setHidden:false];
        
        [_txtSecret setBackgroundColor:myWhite];
        [_txtSecret setPlaceholder:@" Secret"];
        [_txtSecret setFont:[UIFont systemFontOfSize:14]];
        [_txtSecret setBorderStyle:UITextBorderStyleRoundedRect];
        [_txtSecret setSecureTextEntry:YES];
        [_txtSecret setKeyboardType:UIKeyboardTypeAlphabet];
        [_txtSecret setReturnKeyType:UIReturnKeyDone];
        [_txtSecret setDelegate:self];
        [_txtSecret setEnabled:NO];
        [_txtSecret setAlpha:0];
        
        [_txtSecretQ setBackgroundColor:myWhite];
        [_txtSecretQ setPlaceholder:@" Secret Question / Hint"];
        [_txtSecretQ setFont:[UIFont systemFontOfSize:14]];
        [_txtSecretQ setBorderStyle:UITextBorderStyleRoundedRect];
        [_txtSecretQ setKeyboardType:UIKeyboardTypeAlphabet];
        [_txtSecretQ setReturnKeyType:UIReturnKeyDone];
        [_txtSecretQ setDelegate:self];
        [_txtSecretQ setEnabled:NO];
        [_txtSecretQ setAlpha:0];
        
        [[UITextField appearance] setKeyboardAppearance:UIKeyboardAppearanceDark];
        [[UITextField appearance] setTintColor:[UIColor blackColor]];
        
        [_btnTop setTitle:@"Sign In" forState:UIControlStateNormal];
        [_btnBot setTitle:@"Join GameQ" forState:UIControlStateNormal];
        [_btnTop setTitleColor:myRed forState:UIControlStateNormal];
        [_btnBot setTitleColor:myWhite forState:UIControlStateNormal];
        [_btnTop setTitleColor:myTransRed forState:UIControlStateHighlighted];
        [_btnBot setTitleColor:myTransWhite forState:UIControlStateHighlighted];
        [_btnBot setBackgroundColor:myRed];
        [_btnTop setBackgroundColor:myWhite];
        
        
        //[self.view addSubview:_imgBackground];
        [self.view addSubview:_imgLogo];
        [self.view addSubview:_btnResignKeyboard];
        [self.view addSubview:_txtEmail];
        [self.view addSubview:_txtPassword];
        [self.view addSubview:_txtSecretQ];
        [self.view addSubview:_txtSecret];
        [self.view addSubview:_btnTop];
        [self.view addSubview:_btnBot];
        
        /*
        UIButton *PullansKnapp = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
        [PullansKnapp setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [PullansKnapp setTitle:@"PullansKnapp" forState:UIControlStateNormal];
        [self.view addSubview:PullansKnapp];
        */
        
    }
    
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignKeyboard:nil];
    if ((_bolIsRegging && _bolIsUp) || (_bolIsUp && self.view.frame.size.height < 568) ){
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        /* should move views */
        if(self.view.frame.size.height < 568) {
            if (_bolIsRegging) {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
            } else {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
            }
        } else if (self.view.frame.size.height == 568) {
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 52);
        }
        [_btnTop setAlpha:1];
        [_btnBot setAlpha:1];
        
        [UIView commitAnimations];
    }
    
    if (_bolIsRegging) {
        [self reg];
    } else {
        [self log];
    }
    
    
    
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
        NSString *tmpEmail = [_dataHandler getEmail];
        NSString *tmpPass = [_dataHandler getPass];
        [_txtEmail setText:tmpEmail];
        [_txtPassword setText:tmpPass];
        [_connectionsHandler loginWithUser:tmpEmail andPass:tmpPass];
    }
    [_connectionsHandler chkVersion];
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    
    [self setupNothing];
/*    if(self.view.frame.size.height < 568) {
        
        [_imgLogo setFrame:CGRectMake(8, 34, 304, 90)];
        [_txtEmail setFrame:CGRectMake(78, 162, 165, 30)];
        [_txtPassword setFrame:CGRectMake(95, 200, 131, 30)];
        [_btnLog setFrame:CGRectMake(0, 240, self.view.frame.size.width, 30)];
        [_lblChanging setFrame:CGRectMake(33, 268, 254, 77)];
        [_lblNotChanging setFrame:CGRectMake(33, 353, 254, 67)];
        [_btnAbout setFrame:CGRectMake(0, 428, self.view.frame.size.width, 30)];
    }*/
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resignKeyboard:(id)sender {
    [self.view endEditing:YES];
    if ((_bolIsRegging && _bolIsUp) || (_bolIsUp && self.view.frame.size.height < 568) ){
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        /* should move views */
        if(self.view.frame.size.height < 568) {
            if (_bolIsRegging) {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
            } else {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 20);
            }
        } else if (self.view.frame.size.height == 568) {
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y + 52);
        }
        [_btnBot setAlpha:1];
        [_btnTop setAlpha:1];
        
        [UIView commitAnimations];
    }
    _bolIsUp = false;
}

- (IBAction)topButtonPressed:(id)sender
{
    if (!_bolIsRegging) {
        [self log];
    } else if (_bolIsRegging) {
        [self reg];
    }
}

- (IBAction)botButtonPressed:(id)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    
    if (_bolIsRegging) {
        [self setupNothing];
    } else {
        [self setupRegging];
    }
    [UIView commitAnimations];
}

- (void)log {
    [self.view endEditing:YES];
    [_dataHandler setEmail:_txtEmail.text.lowercaseString];
    
    //checks if any text exists in the fields
    if (![_txtEmail.text isEqual:@""] && ![_txtPassword.text isEqual:@""]) {
        if (_txtEmail.text.length > 2 && _txtPassword.text.length > 5) {
            if ([_txtEmail.text rangeOfString:@"@"].location != NSNotFound) {
                
                
                
                if ([_txtEmail.text rangeOfString:@"\""].location == NSNotFound && [_txtPassword.text rangeOfString:@"\""].location == NSNotFound &&
                    [_txtEmail.text rangeOfString:@"\\"].location == NSNotFound && [_txtPassword.text rangeOfString:@"\\"].location == NSNotFound) {
                    //what we wanna do
                    [_connectionsHandler loginWithUser:_txtEmail.text.lowercaseString andPass:_txtPassword.text];
                    [_btnTop setEnabled:NO];
                    [_btnBot setEnabled:NO];
                    
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"The specified email or password uses illegal characters!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"The specified email is invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"Your password must contain a minimum of 6 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"Please enter a valid email address and password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    
    
    
    
    
    
    
    
    
    
}

- (void)reg {
    
    
    
    //checks if any text exists in the fields
    if (![_txtEmail.text isEqual:@""] && ![_txtPassword.text isEqual:@""]) {
        if (_txtEmail.text.length > 2 && _txtPassword.text.length > 5 && _txtSecret .text.length > 5) {
            if ([_txtEmail.text rangeOfString:@"@"].location != NSNotFound) {
                
                
                
                if ([_txtEmail.text rangeOfString:@"\""].location == NSNotFound && [_txtPassword.text rangeOfString:@"\""].location == NSNotFound &&
                    [_txtEmail.text rangeOfString:@"\\"].location == NSNotFound && [_txtPassword.text rangeOfString:@"\\"].location == NSNotFound && [_txtSecret.text rangeOfString:@"\""].location == NSNotFound && [_txtSecretQ.text rangeOfString:@"\""].location == NSNotFound &&
                    [_txtSecretQ.text rangeOfString:@"\\"].location == NSNotFound && [_txtSecret.text rangeOfString:@"\\"].location == NSNotFound) {
                    //what we wanna do
                    [self.view endEditing:YES];
                    [_connectionsHandler registerWithEmail:_txtEmail.text.lowercaseString andPass:_txtPassword.text andSecretQuestion:_txtSecretQ.text andSecret:_txtSecret.text];
                    [_btnTop setEnabled:NO];
                    [_btnBot setEnabled:NO];
                    
                } else {
                    [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"The details provided contain illegal characters!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                }
            } else {
                [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"The specified email is invalid" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"Your password and Secret must contain a minimum of 6 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Invalid Details" message:@"Please enter valid details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    
    
    
    
    
    
    
    
}

-(void) setupRegging
{
    _bolIsRegging = true;
    
    [_txtEmail setEnabled:true];
    [_txtPassword setEnabled:true];
    [_txtSecretQ setEnabled:true];
    [_txtSecret setEnabled:true];
    
    [_txtEmail setAlpha:1];
    [_txtPassword setAlpha:1];
    [_txtSecret setAlpha:1];
    [_txtSecretQ setAlpha:1];
    
    [_btnTop setTitle:@"Create Account" forState:UIControlStateNormal];
    [_btnBot setTitle:@"Cancel" forState:UIControlStateNormal];
}

-(void) setupLogging
{
    _bolIsRegging = false;
    
    [_txtEmail setEnabled:true];
    [_txtPassword setEnabled:true];
    [_txtSecretQ setEnabled:false];
    [_txtSecret setEnabled:false];
    
    [_txtEmail setAlpha:1];
    [_txtPassword setAlpha:1];
    [_txtSecret setAlpha:0];
    [_txtSecretQ setAlpha:0];
    
    [_btnTop setTitle:@"Sign In" forState:UIControlStateNormal];
    [_btnBot setTitle:@"Cancel" forState:UIControlStateNormal];
}

-(void) setupNothing
{
    _bolIsRegging = false;
    
    
    [_txtEmail setEnabled:true];
    [_txtPassword setEnabled:true];
    [_txtSecretQ setEnabled:false];
    [_txtSecret setEnabled:false];
    
    [_txtEmail setAlpha:1];
    [_txtPassword setAlpha:1];
    [_txtSecret setAlpha:0];
    [_txtSecretQ setAlpha:0];
    
    [_btnTop setTitle:@"Sign In" forState:UIControlStateNormal];
    [_btnBot setTitle:@"Join GameQ" forState:UIControlStateNormal];
    
    
    
}

-(void) setConnected
{
    
    [_txtEmail setEnabled:NO];
    [_txtPassword setEnabled:NO];
    
    [_txtEmail setTextColor:[UIColor grayColor]];
    _bolLoggedIn = YES;
    [_dataHandler setBolIsLoggedIn:[NSNumber numberWithBool:_bolLoggedIn]];
    [_dataHandler setEmail:_txtEmail.text];
    [_dataHandler setPass:_txtPassword.text];
    [_txtPassword setText:@""];
    NSLog(@"changes saved");
    [_connectionsHandler.gqConnect postNow:[NSString stringWithFormat:@"token=%@&deviceName=%@&email=%@", [_dataHandler getToken], [_dataHandler getDeviceID], [_dataHandler getEmail]] to:updateTokenURL];
    NSLog(@"stored data:\r\nloggedin: %@\r\nemail: %@\r\ntoken: %@\r\npassword: like I would tell you  :P \r\ndeviceID:%@", [_dataHandler getBolIsLoggedIn], [_dataHandler getEmail], [_dataHandler getToken],  [_dataHandler getDeviceID]);
    [self pushSecondViewController];
}

- (IBAction)pushSecondViewController
{
    /*
    _tableViewController = [[LVFTableViewController alloc] initWithMainController: self];
    [self presentViewController:_tableViewController animated:YES completion:NULL];
     */
    NSLog(@"pushing pageView");
    _secondViewController = [[LVFMasterViewController alloc] initWithMainController:self];
    [self presentViewController:_secondViewController animated:YES completion:NULL];
}

-(void) popSecondViewController
{
    NSLog(@"popping");
}

- (void) setDisconnected
{
    [_txtPassword setText:@""];
    [[self btnTop] setTitle:@"Sign In" forState:UIControlStateNormal];
    
    _bolLoggedIn = NO;
    [_dataHandler setBolIsLoggedIn:[NSNumber numberWithBool:_bolLoggedIn]];
    [_dataHandler setEmail:_txtEmail.text];
    [_dataHandler setPass:@""];
    NSLog(@"popping");
}

- (void)textFieldDidBeginEditing:(UITextField *)ga1
{
    if ((_bolIsRegging && !_bolIsUp) || (!_bolIsUp && self.view.frame.size.height < 568) ) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        /* should move views */
        if(self.view.frame.size.height < 568) {
            if (_bolIsRegging) {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
            } else {
                self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 20);
            }
        } else if (self.view.frame.size.height == 568) {
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y - 52);
        }
        [_btnTop setAlpha:0];
        [_btnBot setAlpha:0];
        [UIView commitAnimations];
    }
    _bolIsUp = true;
    
}

- (void) popControllers
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}






@end














