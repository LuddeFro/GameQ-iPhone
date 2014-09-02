//
//  LVFViewControllerTwo.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 20/08/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFViewControllerTwo.h"

#define kNOGAME 0
#define kHEROES_OF_NEWERTH 1
#define kDOTA2 2
#define kCS_GO 3
#define kOFF 4
#define kOFFLINE 0
#define kONLINE 1
#define kINGAME 2

@interface LVFViewControllerTwo ()

@end

@implementation LVFViewControllerTwo


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (id)initWithMainController:(LVFViewController*)controller
{
    self = [super init];
    if (self) {
        // Custom initialization
        _mainController = controller;
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    
    _mainController.secondViewController.currentIndex = 1;
    [_mainController.secondViewController animateAppearance];
}

-(void) viewWillAppear:(BOOL)animated
{
    [_mainController.secondViewController requestUpdate];
    _mainController.secondViewController.currentIndex = 1;
    [_mainController.secondViewController animateDisappearance];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _displayItem = @"";
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
//    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
//    UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
//    UIColor *myLightGray = [UIColor colorWithRed:0.2 green:0.2 blue:0.22 alpha:1];
	// Do any additional setup after loading the view.
    
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    
    CGRect frameImgLogo = CGRectMake(40, 136, 240, 240);
    
    CGRect framelblCountdown = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70, 320, 25);
    CGRect framelblApprox = CGRectMake(0, framelblCountdown.origin.y-45, 320, 35);
    CGRect framelblGame = CGRectMake(0, frameImgLogo.origin.y+frameImgLogo.size.height+10, 320, 45);
    CGRect framelblStatus = CGRectMake(0, frameImgLogo.origin.y - 55, 320, 45);
    
    
    CGRect frameImgGameFrame = CGRectMake(20, 90, 280, 316);
    
    
    _imgGameLogo = [[UIImageView alloc] initWithFrame:frameImgLogo];
    _lblApproxTime = [[UILabel alloc] initWithFrame:framelblApprox];
    _lblCountdown = [[UILabel alloc] initWithFrame:framelblCountdown];
    _lblStatus = [[UILabel alloc] initWithFrame:framelblStatus];
    _lblGame = [[UILabel alloc] initWithFrame:framelblGame];
    _imgGameFrame = [[UIImageView alloc] initWithFrame:frameImgGameFrame];
    
    
    _imgGameLogo.layer.cornerRadius = 20.0;
    _imgGameLogo.layer.masksToBounds = YES;
    [_imgGameLogo setImage:[UIImage imageNamed:@"sqt.png"]];
    _imgGameLogo.contentMode = UIViewContentModeScaleAspectFit;
    
    [_lblApproxTime setText:@"Approximate time to accept queue:"];
    [_lblApproxTime setAlpha:0];
    [_lblStatus setText:@"Connect a computer"];
    [_lblGame setText:@""];
    [_lblGame setAlpha:0];
    [_lblCountdown setText:@"00:00"];
    [_lblCountdown setAlpha:0];
    
    [_lblCountdown setTextAlignment:NSTextAlignmentCenter];
    [_lblApproxTime setTextAlignment:NSTextAlignmentCenter];
    [_lblStatus setTextAlignment:NSTextAlignmentCenter];
    [_lblGame setTextAlignment:NSTextAlignmentCenter];
    
    [_lblCountdown setFont:[UIFont fontWithName:@"helvetica neue" size:30]];
    [_lblApproxTime setFont:[UIFont fontWithName:@"helvetica neue" size:15]];
    [_lblStatus setFont:[UIFont fontWithName:@"helvetica neue" size:20]];
    [_lblGame setFont:[UIFont fontWithName:@"helvetica neue" size:20]];;
    
    [_lblApproxTime setTextColor:myWhite];
    [_lblCountdown setTextColor:myWhite];
    [_lblGame setTextColor:myWhite];
    [_lblStatus setTextColor:myWhite];
    
    [_lblGame setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.2]];
    [_lblStatus setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.2]];
    
    [self.view addSubview:_imgGameFrame];
    [self.view addSubview:_lblStatus];
    [self.view addSubview:_lblCountdown];
    [self.view addSubview:_lblApproxTime];
    [self.view addSubview:_imgGameLogo];
    [self.view addSubview:_lblGame];
    /*
    _imgGameFrame.layer.cornerRadius = 25;
    _imgGameFrame.layer.masksToBounds = YES;
    _imgGameFrame.layer.borderColor = myWhite.CGColor;
    _imgGameFrame.layer.borderWidth = 1;
    [_imgGameFrame setBackgroundColor:myDarkGray];
    */
    [self reload];
    
    if(self.view.frame.size.height < 568) { //if less than 4 inch (== 3.5 inch)
        [_imgGameLogo setFrame:CGRectMake(_imgGameLogo.frame.origin.x + 10, _imgGameLogo.frame.origin.y -10, _imgGameLogo.frame.size.width-20, _imgGameLogo.frame.size.height-20)];
        [_lblCountdown setFont:[UIFont fontWithName:@"helvetica neue" size:30]];
        [_lblApproxTime setFont:[UIFont fontWithName:@"helvetica neue" size:18]];
        [_lblStatus setFont:[UIFont fontWithName:@"helvetica neue" size:20]];
        [_lblGame setFont:[UIFont fontWithName:@"helvetica neue" size:20]];
        
        CGRect framelblCountdown = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-45, 320, 35);
        CGRect framelblApprox = CGRectMake(0, framelblCountdown.origin.y-30, 320, 25);
        CGRect framelblStatus = CGRectMake(0, frameImgLogo.origin.y+frameImgLogo.size.height-10, 320, 35);
        CGRect framelblGame = CGRectMake(0, frameImgLogo.origin.y - 55, 320, 35);
        
        [_lblCountdown setFrame:framelblCountdown];
        [_lblApproxTime setFrame:framelblApprox];
        [_lblGame setFrame:framelblGame];
        [_lblStatus setFrame:framelblStatus];
        
        
    }
    
}

-(void)tickDown
{
    if ([_displayItem isEqualToString:@""]) {
        [_lblCountdown setText:@""];
        [_lblApproxTime setAlpha:0];
        return;
    }
    NSDate *dateValue = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Stockholm"]];
    NSString *date = [dateFormatter stringFromDate:dateValue];
    long currentTime = date.longLongValue;
    long queueTime = [_displayItem substringWithRange:NSMakeRange(_displayItem.length-14, 14)].longLongValue;
    NSLog(@"date:%ld, date2:%ld", currentTime, queueTime);
    bool bolCSGO = ([_displayItem substringWithRange:NSMakeRange(0, 2)].intValue == 3);
    bool bolDota = ([_displayItem substringWithRange:NSMakeRange(0, 2)].intValue == 2);
    
    if (((currentTime - queueTime < 42 && bolDota) ||
        (currentTime - queueTime < 15 && bolCSGO)) &&
        ((currentTime - queueTime) > 0)) {
        if (bolCSGO) {
            [_lblCountdown setText:[NSString stringWithFormat:@"%ld", 15-(currentTime - queueTime)]];
        } else if (bolDota) {
            [_lblCountdown setText:[NSString stringWithFormat:@"%ld", 42-(currentTime - queueTime)]];
        }
        
        [_lblApproxTime setAlpha:1];
    } else {
        [_lblCountdown setText:@""];
        [_lblApproxTime setAlpha:0];
    }
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reload
{
    int a = -1;
    int b = 0;
    int c = 0;
    NSArray *array = self.mainController.secondViewController.deviceArray;
    _displayItem = @"";
    for (int i = 0; i < array.count; i++) {
        NSString *object = [array objectAtIndex:i];
        int queueTime = [object substringWithRange:NSMakeRange(object.length-14, 14)].intValue;
        switch ([object substringWithRange:NSMakeRange(2, 2)].integerValue) {
            case 0: //Offline
                if (a < 0) {
                    a = 0;
                    b = i;
                }
                break;
            case 1: //Online
                if (a < 1) {
                    a = 1;
                    b = i;
                }
                break;
            case 2: //In-Game
                if (a < 2) {
                    a = 2;
                    b = i;
                    c = queueTime;
                } else if (queueTime > c) {
                    b=i;
                    c=queueTime;
                }
                break;
            case 4: //Off / disconnected
                if (a < 0) {
                    b = i;
                }
                break;
            default:
                break;
        }
    }
    if (array.count != 0) {
        _displayItem = [array objectAtIndex:b];
    }
    NSLog(@"%@", _displayItem);
    if ([_displayItem isEqualToString:@""]) {
        NSLog(@"controller2 displayitem empty");
        [_lblStatus setText:@"Start GameQ on a computer"];
        [_imgGameLogo setImage:[UIImage imageNamed:@"sqt.png"]];
        _lblGame.text = @"Not Connected";
        _displayItem = @"";
        [_lblCountdown setText:@""];
        
    } else {
        int tempInt;
        
        switch ([[_displayItem substringToIndex:2] intValue]) {
            case kNOGAME:
                tempInt = kNOGAME;
                _lblStatus.text = @"Not Gaming";
                _lblGame.text = @"Connected to GameQ";
                break;
            case kHEROES_OF_NEWERTH:
                tempInt = kHEROES_OF_NEWERTH;
                _lblGame.text = @"Heroes of Newerth";
                
                break;
            case kDOTA2:
                tempInt = kDOTA2;
                _lblGame.text = @"Dota 2";
                break;
            case kCS_GO:
                tempInt = kCS_GO;
                _lblGame.text = @"Counter Strike: Global Offensive";
                break;
                
            default:
                break;
        }
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        switch ([[_displayItem substringWithRange:NSMakeRange(2, 2)] intValue]) {
            case kONLINE:
                _lblStatus.text = [NSString stringWithFormat:@"In Lobby"];
                [_lblStatus setTextColor:[UIColor whiteColor]];
                NSLog(@"tjorren");
                [_lblGame setAlpha:1];
                break;
                
            case kINGAME:
                _lblStatus.text = [NSString stringWithFormat:@"In Game"];
                [_lblStatus setTextColor:[UIColor whiteColor]];
                NSLog(@"tjorrtvå");
                [_lblGame setAlpha:1];
                break;
                
            case kOFF:
                tempInt = kNOGAME;
                _lblStatus.text = @"Not Connected to GameQ";
                [_lblStatus setTextColor:[UIColor whiteColor]];
                _lblGame.text = @"Start GameQ on your Computer";
                 [_lblGame setAlpha:1];
                NSLog(@"tjorrtre");
                
                break;
            case kOFFLINE:
                _lblStatus.text = @"Connected to GameQ";
                tempInt = kNOGAME;
                _lblGame.text = @"Not Gaming";
                [_lblStatus setTextColor:[UIColor whiteColor]];
                NSLog(@"tjorrfyra");
                 [_lblGame setAlpha:1];
                break;
            default:
                NSLog(@"status not found: %d", [[_displayItem substringWithRange:NSMakeRange(2, 2)] intValue]);
                break;
        }
        bool bolChanging = false;
        if (tempInt != _lastPic) {
            bolChanging = true;
            _lastPic = tempInt;
            [_imgGameLogo setAlpha:0];
            NSTimer *aTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(showImage) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:aTimer forMode:NSDefaultRunLoopMode];
        }
        [UIView commitAnimations];
        
    }
}

-(void)showImage
{
    switch (_lastPic) {
        case kNOGAME:
            [_imgGameLogo setImage:[UIImage imageNamed:@"sqt.png"]];
            break;
        case kHEROES_OF_NEWERTH:
            [_imgGameLogo setImage:[UIImage imageNamed:@"honlogo.png"]];
            break;
        case kDOTA2:
            [_imgGameLogo setImage:[UIImage imageNamed:@"dotalogo.png"]];
            break;
        case kCS_GO:
            [_imgGameLogo setImage:[UIImage imageNamed:@"cslogo.png"]];
            break;
        default:
            [_imgGameLogo setImage:[UIImage imageNamed:@"sqt.png"]];
            break;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [_imgGameLogo setAlpha:1];
    [UIView commitAnimations];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
