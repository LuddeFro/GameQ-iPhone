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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    UIColor *myTransWhite = [UIColor colorWithWhite:1 alpha:0.5];
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
   // UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
    
   // UIColor *myLightGray = [UIColor colorWithRed:0.2 green:0.2 blue:0.22 alpha:1];
    
    //_imgBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
    //[self.view addSubview:_imgBackgroundImageView];
    
    
    //and with bkgrnd color
    _imgBackgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    [_imgBackgroundView setImage:[UIImage imageNamed:@"blurred.png"]];
    
    [self.view addSubview:_imgBackgroundView];
    
    
    
    
 
    
    
    
    
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
    _lblStatic = [[UILabel alloc] init];
    [_lblStatic setFrame:CGRectMake(20, 40, self.view.frame.size.width-40, self.view.frame.size.height-105)];
    [_lblStatic setNumberOfLines:0];
    [_lblStatic setText:@"GameQ is the first and only App that allows you to leave your computer while queuing for your favourite games! No more worrying about bad starts and leaver stats! GameQ checks your queue for you and sends a notification to your smartphone when the game starts!\r\n\r\nSimply download and install desktop client from www.gameq.io. Log in to your GameQ account and let GameQ revolutionize your gaming experience! Take a bathroom break, enjoy a pre-game snack or call a friend - GameQ will take care of the rest!"];
    [_lblStatic setTextColor:myWhite];
    [self.view addSubview:_lblStatic];
    
    
    
    _btnAbout = [[UIButton alloc] init];
    [_btnAbout setFrame:CGRectMake(20, self.view.frame.size.height-50, self.view.frame.size.width-40, 30)];
    [_btnAbout setTitle:@"www.GameQ.io" forState:UIControlStateNormal];
    [_btnAbout setTitleColor:myWhite forState:UIControlStateNormal];
    [_btnAbout setTitleColor:myTransWhite forState:UIControlStateHighlighted];
    [_btnAbout setBackgroundColor:myRed];
    [_btnAbout addTarget:self action:@selector(visitPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnAbout];
    
    _lblTitle = [[UILabel alloc] init];
    [_lblTitle setFrame:CGRectMake(0, 30, self.view.frame.size.width, 30)];
    [_lblTitle setNumberOfLines:1];
    [_lblTitle setText:@"About"];
    [_lblTitle setTextAlignment:NSTextAlignmentCenter];
    [_lblTitle setTextColor:myWhite];
    [_lblTitle setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:_lblTitle];
    
    if(self.view.frame.size.height < 568) { //if less than 4 inch (== 3.5 inch)
        [_lblStatic setFont:[UIFont systemFontOfSize:15]];
        [_lblStatic setFrame:CGRectMake(_lblStatic.frame.origin.x, _lblStatic.frame.origin.y, _lblStatic.frame.size.width, _lblStatic.frame.size.height+15)];
        
    }
    
    
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
