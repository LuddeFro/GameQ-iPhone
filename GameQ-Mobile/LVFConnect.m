//
//  LVFResponses.m
//  NetMonitor
//
//  Created by Ludvig Fröberg on 10/19/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import "LVFConnect.h"

@interface LVFConnect ()

@property NSMutableData *returnData;
@property NSMutableURLRequest *request;
@property BOOL disconnected;
@property LVFConnections *delegate;
@property LVFViewController *mainController;

@end

@implementation LVFConnect
@synthesize disconnected;
@synthesize request;
@synthesize returnData;
@synthesize delegate;


- (id) initWithDelegate:(LVFConnections *)del andController:(LVFViewController*)controller
{
    self = [super init];
    if (self) {
        delegate = del;
        _mainController = controller;
    }
    return self;
}

- (void)postNow:(NSString*)toPost to:(NSString*)link
{
    NSLog(@"posting now: %@", toPost);
    NSString *postString = toPost;
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:link]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content_Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (postConnection)
    {
        returnData = [NSMutableData data];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"GameQ could not establish a connection, please check your internet connection and try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        //osx alert below
        //[[NSAlert alertWithMessageText:@"GameQ could not establish a connection" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Please check you network connections and try again!"] runModal];
        NSLog(@"login connection failed");
    }
    NSLog(@"postNow method has finished executing");
}

// setting up the connection and error handling
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [returnData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [returnData appendData:data];
}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    [_mainController.btnTop setEnabled:YES];
    [_mainController.btnBot setEnabled:YES];
    [_mainController.txtEmail setEnabled:YES];
    [_mainController.txtPassword setEnabled:YES];
    [_mainController.txtEmail setTextColor:[UIColor blackColor]];
    [_mainController.txtPassword setTextColor:[UIColor blackColor]];
    returnData = NULL;
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

//connection was successful, handle response here
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_mainController.btnTop setEnabled:YES];
    [_mainController.btnBot setEnabled:YES];
    [_mainController.txtEmail setEnabled:YES];
    [_mainController.txtPassword setEnabled:YES];
    [_mainController.txtEmail setTextColor:[UIColor blackColor]];
    [_mainController.txtPassword setTextColor:[UIColor blackColor]];
    NSLog(@"received data length:%lu", (unsigned long)[returnData length]);
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", returnString);
    NSLog(@"return string above");
    
    
    
    if (returnString.length>=8) {
        if([[returnString substringToIndex:8] isEqualToString:@"updating"]) {
            NSLog(@"updating");
            returnString = [returnString substringFromIndex:8];
            int items = [[returnString substringToIndex:2] intValue];
            if (items == 0) {
                [_mainController.secondViewController receiveUpdate:NULL];
                return;
            }
            
            returnString = [returnString substringFromIndex:2];
            NSMutableArray *deviceArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<items; i++) {
                int len = [[returnString substringToIndex:2] intValue];
                returnString = [returnString substringFromIndex:2];
                NSLog(@"%@", returnString);
                NSString *itemString = [returnString substringToIndex:(len+18)];
                [deviceArray addObject:itemString];
                NSLog(@"%@",itemString);
                
                NSLog(@"i : %d", i);
                NSLog(@"items: %d", items);
                
                if (i == (items-1)) {
                    returnString = NULL;
                    NSLog(@"nulled");
                }
                else {
                    NSLog(@"more items");
                    returnString = [returnString substringFromIndex:len+18];
                }
            }
            NSLog(@"sending it to the view controller");
            [_mainController.secondViewController receiveUpdate:deviceArray];
            return;
        }
    }
    
    
    //check if newer version exists
    if (returnString.length >= 7) {
        if ([[returnString substringWithRange:NSMakeRange(0, 7)] isEqualToString:@"version"])
        {
            if (![[returnString substringFromIndex:7] isEqualToString:kVersion])
            {
                [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"A newer version of GameQ is available. Get it in the appstore or at GameQ.io" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
            return;
            
        }
    }
    
    
    if (returnString.length>=7) {
        if([[returnString substringToIndex:7] isEqualToString:@"mygames"]) {
            NSLog(@"myGames Detected");
            returnString = [returnString substringFromIndex:7];
            NSArray *tmpArray = [returnString componentsSeparatedByString:@";"];
            _mainController.lastGames = tmpArray;
            if ([[tmpArray objectAtIndex:0] isEqualToString:@"0"]) {
                if (_mainController.storeHandler == NULL) {
                    _store = [[LVFStoreHandler alloc] initWithMainController:_mainController settingsController:NULL andContentView:_mainController.secondViewController.view forPurchase:NO];
                } else {
                    
                    if (!_store.showing) {
                        NSLog(@"store not showing");
                        _store = [[LVFStoreHandler alloc] initWithMainController:_mainController settingsController:NULL andContentView:_mainController.secondViewController.view forPurchase:NO];
                    } else {
                        NSLog(@"store showing");
                    }
                }
            } else {
                [_mainController.secondViewController.coverUp removeFromSuperview];
                NSLog(@"updateForGames");
                [_mainController.storeHandler updateForGames:[tmpArray objectAtIndex:0]];
            }
        
        }
    }
    
    
    if([returnString isEqualToString:@"gamesUp"]) {
        if (_mainController.storeHandler.isPurchasing) {
            [_mainController.connectionsHandler getMyGamesForEmail:_mainController.dataHandler.getEmail];
        } else {
            _mainController.storeHandler.showing = false;
            [_mainController.storeHandler.backgroundButton removeFromSuperview];
            [_mainController.secondViewController.coverUp removeFromSuperview];
        }
    }
    if([returnString isEqualToString:@"upGameFail"]) {
        
    }
    if([returnString isEqualToString:@"piracy"]) {
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Something went wrong, contact GameQ support at: support@gameq.io" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    
    
    /* following statements used if support is added in-app for forgotten passwords
     also see getSecret and chkSecret methods in LVFConnections.m
     
    //secret question has been retrieved, response syntax "secQ%@", secretQuestion
    if ([[returnString substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"secQ"])
    {
        
        txtSecretQ.text = [returnString substringFromIndex:4];
        if (btnInvis.enabled == true)
        {
     
        }
        else
        {
     
        }
        btnForget.enabled = true;
        
    }
     
    if ([returnString isEqualToString:@"wronguser"])
    {
        [[[UIAlertView alloc] initWithTitle:@"Free Lottery" message:@"Invalid e-mail address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        btnForget.enabled = true;
        return;
    }
    if ([returnString isEqualToString:@"wrongsecret"])
    {
        [[[UIAlertView alloc] initWithTitle:@"Free Lottery" message:@"Wrong secret" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        btnSave.enabled = true;
        return;
    }
    
     
    if ([returnString isEqualToString:@"pwdreset"])
    {
        [self loginRight];
        [self secRight];
        if (btnInvis.enabled == true)
        {
            [self completeAnimationsDelayed];
            [self rollRightDelayed];
            [self toggleKeyboard:btnInvis];
        }
        else
        {
            [self completeAnimations];
            [self rollRight];
            [self toggleKeyboard:btnInvis];
        }
        [[[UIAlertView alloc] initWithTitle:@"Free Lottery" message:@"Your password has been  reset, a temporary password has been sent to your e-mail address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        btnSave.enabled = true;
        return;
    }
     */
    
    
    if ([returnString  isEqualToString:@"postedDevice"]) {
        NSLog(@"updated token and device name");
        return;
    }
        
    
    
    
    // if sign in was successful
    if ([returnString isEqualToString:@"sign in success"])
    {
        /* addfeature in mobile version
         comment out this method from LVFConnections.h/m
        [delegate upAppPost];
         */
        //-------------- start pCap on background thread
        
        NSLog(@"sign in success");
        [_mainController setConnected];
        return;
    }
    
    
    if ([returnString isEqualToString:@"signing upmailerr"])
    {
        //ios alert
        [_mainController setupNothing];
        [_mainController.txtPassword setText:@""];
        [_mainController.btnTop setEnabled:YES];
        [_mainController.btnBot setEnabled:YES];
        [_mainController.txtSecret setText:@""];
        [_mainController.txtSecretQ setText:@""];
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Welcome to GameQ, you can sign in immediately!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    
    if ([returnString isEqualToString:@"signing upmailerrno"])
    {
        //ios alert
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"A critical error has occured, please contact support, or sign up with a different e-mail address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [_mainController setupNothing];
        [_mainController.txtPassword setText:@""];
        [_mainController.btnTop setEnabled:YES];
        [_mainController.btnBot setEnabled:YES];
        [_mainController.txtSecret setText:@""];
        [_mainController.txtSecretQ setText:@""];
        return;
    }
    
    
    if ([returnString isEqualToString:@"mailerr"])
    {
        //ios alert
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Something went wrong, the GameQ servers may be down" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    // if sign in failed
    if ([returnString isEqualToString:@"sign in failed"])
    {
        //ios alert
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Invalid log in details, Please try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [_mainController.connectionsHandler logoutPostFromToken:[_mainController.dataHandler getToken]];
        //osx alert
        //[[NSAlert alertWithMessageText:@"Invalid login details" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You entered an invalid password - username combination, please try again.\r\n\r\nToo many failed attempts may lock your account for up to 2 hours."] runModal];
        return;
    }
    
    //if you just logged out
    if ([returnString isEqualToString:@"loggedOut"])
    {
        
        if (!disconnected)
        {
            //if you logged out manually
            NSLog(@"logged out");
            [_mainController setDisconnected];
            

            return;
        }
        else {
            //if you got "badsession" already sends an alert, this method is simply here for future use
            disconnected = false;
            NSLog(@"badsession");
        }
        return;
    }
    /* if forgotten password support is added in-app
    if ([returnString isEqualToString:@"updated me"])
    {
        if (btnInvis.enabled == true)
            [self myProfileFinTransitDelayed];
        else
            [self myProfileFinTransit];
        btnSave.enabled = true;
        return;
    }
    if ([returnString isEqualToString:@"wrongpassword"])
    {
        [[[UIAlertView alloc] initWithTitle:@"Free Lottery" message:@"A correct current password is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        lastName.text = @"";
    }
     */
     
    
    if ([returnString isEqualToString:@"signing up"])
    {
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Welcome to GameQ, a temporary password has been sent to your email address for your first sign in. You are required to use it only once to activate your account!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [_mainController setupNothing];
        [_mainController.txtPassword setText:@""];
        [_mainController.btnTop setEnabled:YES];
        [_mainController.btnBot setEnabled:YES];
        [_mainController.txtSecret setText:@""];
        [_mainController.txtSecretQ setText:@""];
        return;
    }
    if ([returnString isEqualToString:@"duplicate"])
    {
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"An account with that e-mail address already exists" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [_mainController.btnTop setEnabled:YES];
        [_mainController.btnBot setEnabled:YES];
        return;
    }
    
    if ([returnString isEqualToString:@"badsession"])
    {
        //attempt to reconnect? or record disconnection and logout
        disconnected = true;
        [delegate logoutPostFromToken:([_mainController.dataHandler getToken])];
        [_mainController setDisconnected];
       
        // mobile alert
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"You were disconnected from the server, please try reconnecting!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        //stationary alert
        //[[NSAlert alertWithMessageText:@"GameQ Disconnected" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You have been disconnected from the GameQ servers, please try reconnecting!"] runModal];
        
        
        return;
    }
    if ([returnString isEqualToString: @"no"] /*|| ![returnString isEqualToString: @"no"]*/)
    {
        //should be unreachable, disconnect the bastard!
        disconnected = true;
        [delegate logoutPostFromToken:([_mainController.dataHandler getToken])];
        [_mainController setDisconnected];
        
        
        // mobile alert
        [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Connection error, please try again in a minute" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        //statioanry alert
        //[[NSAlert alertWithMessageText:@"GameQ Connection Error" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Connection error, please try again in a minute!"] runModal];
    }
}

@end
