//
//  LVFAboutController.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/03/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFAboutController.h"

@interface LVFAboutController ()

@end

@implementation LVFAboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
    
    _lblStatic = [[UILabel alloc] init];
    [_lblStatic setFrame:CGRectMake(20, 55, self.view.frame.size.width-40, self.view.frame.size.height-105)];
    [_lblStatic setNumberOfLines:0];
    [_lblStatic setText:@"GameQ is an application designed to help you save time while gaming. No longer do you have to fret leaving the screen for a second in fear of missing the queue pop. Whenever a queue ends on one of your connected computers, all your mobile devices will be notified, and so will you!\r\n\r\nFor more info or if you wish to download the app to your other devices, Game Q is available on the AppStore, GooglePlay, the Android Market and on our website at:"];
    [_lblStatic setTextColor:[UIColor colorWithWhite:1 alpha:1]];
    [self.view addSubview:_lblStatic];
    
    _btnAbout = [[UIButton alloc] init];
    [_btnAbout setFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 30)];
    [_btnAbout setTitle:@"www.GameQ.com/about" forState:UIControlStateNormal];
    [_btnAbout setTitleColor:[UIColor colorWithRed:0 green:0.48 blue:1 alpha:1] forState:UIControlStateNormal];
    [_btnAbout setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
    [_btnAbout setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    
    [self.view addSubview:_btnAbout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)visitPage:(id)sender {
    [self.view endEditing:YES];
    NSURL *urlAbout = [[NSURL alloc] initWithString:URL_ABOUT];
    [[UIApplication sharedApplication] openURL:urlAbout];
    
}

-(void) popController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
