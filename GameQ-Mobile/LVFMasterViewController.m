//
//  LVFMasterViewController.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 20/08/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFMasterViewController.h"

@interface LVFMasterViewController ()

@end

@implementation LVFMasterViewController

- (id)initWithMainController:(LVFViewController*)controller
{
    self = [super init];
    if (self) {
        // Custom initialization
        _mainController = controller;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self startTimer];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self stopTimer];
}

- (void)viewDidLoad
{
    _coverUp = [[UIButton alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_coverUp setTitle:@"" forState:UIControlStateNormal];
    [_coverUp setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    [_mainController.connectionsHandler getMyGamesForEmail:_mainController.dataHandler.getEmail];
    _bolButtonPressed = false;
    _bolButtonPressedHelper = false;
    _bolAlreadyCounting = false;
    _bolSkipIt = false;
    [super viewDidLoad];
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
//    UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
//    UIColor *myLightGray = [UIColor colorWithRed:0.2 green:0.2 blue:0.22 alpha:1];
    //[self.view setBackgroundColor:myDarkGray];
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageController.dataSource = self;
    _pageController.delegate = self;
    [[_pageController view] setFrame:CGRectMake(0, 0, [[self view] bounds].size.width, [[self view] bounds].size.height + 37)];
    
    
    
    _imgBackgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    [_imgBackgroundView setImage:[UIImage imageNamed:@"blurred.png"]];
    
    [self.view addSubview:_imgBackgroundView];
    
    
    LVFViewControllerTwo *impleViewController = [[LVFViewControllerTwo alloc] initWithMainController:_mainController];
    //temp_simpleViewController = [[LVFViewControllerTwo alloc] initWithMainController:_mainController];
    //temp_tableViewController = [[LVFTableViewController alloc] initWithMainController:_mainController];
    NSArray *viewControllers = [NSArray arrayWithObjects:impleViewController, nil];
    
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [_pageController didMoveToParentViewController:self];
    
    
    
    //--------------
    _connectionsHandler = [[LVFConnections alloc] initFromController:_mainController];
    [self requestUpdate];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    
    _listView = [[UIButton alloc] init];
    _logoView = [[UIButton alloc] init];
    _gearView = [[UIButton alloc] init];
    [_listView setAlpha:0.4];
    [_gearView setAlpha:0.4];
    _leftItemRect = CGRectMake(15, 29, 30, 30);
    _rightItemRect = CGRectMake(275, 29, 30, 30);
    _centerItemRect = CGRectMake(145, 29, 30, 30);
    _outLeftItemRect = CGRectMake(-30, 29, 30, 30);
    _outRightItemRect = CGRectMake(320, 29, 30, 30);
    [_listView setFrame:_rightItemRect];
    [_logoView setFrame:_centerItemRect];
    [_gearView setFrame:_leftItemRect];
    
    CGRect frame2 = CGRectMake(0, 00, 320, 66);
    _navBar = [[UINavigationBar alloc] initWithFrame:frame2];
    [_navBar addSubview:_logoView];
    [_navBar addSubview:_listView];
    [_navBar addSubview:_gearView];
    [self.view addSubview:_navBar];
    [_navBar setBarStyle:UIBarStyleDefault];
    [_navBar setBackgroundColor:myRed];
    [_navBar setTintColor:myWhite];
    [_navBar setBarTintColor:myRed];
    [_navBar setTranslucent:NO];
    [_navBar pushNavigationItem:item animated:YES];
    
    [_listView setBackgroundImage:[UIImage imageNamed:@"listIcon.png"] forState:UIControlStateNormal];
    [_gearView setBackgroundImage:[UIImage imageNamed:@"kuggDefault.png"] forState:UIControlStateNormal];
    [_logoView setBackgroundImage:[UIImage imageNamed:@"sq-nb.png"] forState:UIControlStateNormal];
    
    [_listView addTarget:self action:@selector(pressedList) forControlEvents:UIControlEventTouchUpInside];
    [_gearView addTarget:self action:@selector(pressedGear) forControlEvents:UIControlEventTouchUpInside];
    [_logoView addTarget:self action:@selector(pressedLogo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_coverUp];
    
   // UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,_navBar.frame.size.height-1,_navBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    //[navBorder setBackgroundColor:myWhite];
    //[navBorder setOpaque:YES];
    //
    //[_navBar addSubview:navBorder];
    
    /*
    _pcDots = [[UIPageControl alloc] initWithFrame:CGRectMake(141, [[UIScreen mainScreen] bounds].size.height-35, 39, 37)];
    _pcDots.backgroundColor = [UIColor clearColor];
    [_pcDots setCurrentPageIndicatorTintColor:myWhite];
    [_pcDots setPageIndicatorTintColor:myLightGray];
    [[self view] addSubview:_pcDots];
    [_pcDots setNumberOfPages:3];
    [_pcDots setCurrentPage:_intIndex];*/
    _intIndex = 1;
    
    _bolFoundScrollView = false;
    for (UIView *view in _pageController.view.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            [((UIScrollView *)view) setDelegate:self];
            _bolFoundScrollView = true;
            
        }
    }
    
    
    
}

-(void) pressedList {
    if (_intIndex == 2) {
        return;
    }
    _bolButtonPressed = true;
    _intIndex = 2;
    
    LVFTableViewController *impleViewController = [[LVFTableViewController alloc] initWithMainController:_mainController];
    NSArray *viewControllers = nil;
    
    viewControllers = [NSArray arrayWithObjects:impleViewController, nil];
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
}

-(void) pressedGear {
    if (_intIndex == 0) {
        return;
    }
    _bolButtonPressed = true;
    _intIndex = 0;
    LVFSettingsController *impleViewController = [[LVFSettingsController alloc] initWithMainController:_mainController];
    NSArray *viewControllers = nil;
    
    viewControllers = [NSArray arrayWithObjects:impleViewController, nil];
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
    
}
                          


-(void) pressedLogo {
    if (_intIndex == 1) {
        return;
    }
    _bolButtonPressed = true;
    
    LVFViewControllerTwo *impleViewController = [[LVFViewControllerTwo alloc] initWithMainController:_mainController];
    NSArray *viewControllers = nil;
    
    viewControllers = [NSArray arrayWithObjects:impleViewController, nil];
    if (_intIndex == 0) {
        _intIndex = 1;
        [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    } else {
        _intIndex = 1;
        [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
    }
    
    
}
                          
                          
                          
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_bolButtonPressed) {
        return;
    }
    CGFloat percentage = scrollView.contentOffset.x / scrollView.contentSize.width;
    

    percentage -= 0.333333;
    percentage *= 3;
    
    
    float x1;
    float x2;
    float x3;
    
    
    if (_intIndex == 0) {
        x1 = 15 + 130 - (130*percentage);
        x2 = 145 + 130 - (130*percentage);
        x3 = 275 + 130 - (130*percentage);
    } else if (_intIndex == 1) {
        x1 = 15 - (130*percentage);
        x2 = 145 - (130*percentage);
        x3 = 275 - (130*percentage);
    } else if (_intIndex == 2) {
        x1 = 15 - 130 - (130*percentage);
        x2 = 145 - 130 - (130*percentage);
        x3 = 275 - 130 - (130*percentage);
    } else {
        x1 = 0;
        x2 = 0;
        x3 = 0;
    }
    int y = 29;
    int w = 30;
    int h = 30;
    [_gearView setFrame:CGRectMake(x1, y, w, h)];
    [_logoView setFrame:CGRectMake(x2, y, w, h)];
    [_listView setFrame:CGRectMake(x3, y, w, h)];
    float absPercentage = percentage;
    
    if (percentage < 0.0f) {
        absPercentage = 0 - percentage;
    }
    
    
    if (_intIndex == 0) {
        [_gearView setAlpha:(1-absPercentage*0.6)];
        [_logoView setAlpha:(0.4 + percentage*0.6)];
        [_listView setAlpha:(-0.2 + percentage*0.6)];
    } else if (_intIndex == 1) {
        [_gearView setAlpha:(0.4 - percentage*0.6)];
        [_logoView setAlpha:(1-absPercentage*0.6)];
        [_listView setAlpha:(0.4 + percentage*0.6)];
    } else if (_intIndex == 2) {
        [_gearView setAlpha:(-0.2 - percentage*0.6)];
        [_logoView setAlpha:(0.4 - percentage*0.6)];
        [_listView setAlpha:(1-absPercentage*0.6)];
    } else {
        
    }
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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



//------------- DATA PRESENTATION -------------------------


- (void) startTimer {
    _refreshTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(requestUpdate) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_refreshTimer forMode:NSDefaultRunLoopMode];
    _countdownTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(tickDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_countdownTimer forMode:NSDefaultRunLoopMode];
}
- (void) stopTimer {
    [_refreshTimer invalidate];
    [_countdownTimer invalidate];
    //[countdownSlowTimer invalidate];
}

- (void)requestUpdate
{
    NSLog(@"refreshing");
    [_connectionsHandler upAppPost];
}

-(void) tickDown
{
    if ([[_pageController.viewControllers objectAtIndex:0] isKindOfClass:[LVFViewControllerTwo class]]) {
        [(LVFViewControllerTwo *)[_pageController.viewControllers objectAtIndex:0] tickDown];
    }
}

- (void) receiveUpdate:(NSMutableArray*)array
{
    NSLog(@"reloading table data?");
    if (![_deviceArray isEqualToArray:array]) {
        NSLog(@"reloading!");
        _deviceArray = array;
        [_array0 removeAllObjects];
        [_array1 removeAllObjects];
        [_array2 removeAllObjects];
        [_array4 removeAllObjects];
        int isOnline= 0;
        int isOffline= 0;
        int isIngame= 0;
        int isDisconnected= 0;
        for (int i = 0; i < _deviceArray.count; i++) {
            NSLog(@"counting 1");
            switch ([[_deviceArray objectAtIndex:i] substringWithRange:NSMakeRange(2, 2)].integerValue) {
                case 0: //Offline
                    [_array0 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 0");
                    isOffline++;
                    break;
                case 1: //Online
                    [_array1 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 1");
                    isOnline++;
                    break;
                case 2: //In-Game
                    [_array2 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 2");
                    isIngame++;
                    break;
                case 4: //Off / disconnected
                    [_array4 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 4");
                    isDisconnected++;
                    break;
                default:
                    break;
            }
        }
    }
    if ([[_pageController.viewControllers objectAtIndex:0] isKindOfClass:[LVFTableViewController class]]) {
        [(LVFTableViewController *)[_pageController.viewControllers objectAtIndex:0] reload];
    } else if ([[_pageController.viewControllers objectAtIndex:0] isKindOfClass:[LVFViewControllerTwo class]]) {
        [(LVFViewControllerTwo *)[_pageController.viewControllers objectAtIndex:0] reload];
    } else if ([[_pageController.viewControllers objectAtIndex:0] isKindOfClass:[LVFSettingsController class]]) {
        [(LVFSettingsController *)[_pageController.viewControllers objectAtIndex:0] reload];
    }
    
    /*
    _tableViewController.deviceArray = array;
    [_tableViewController.tableView reloadData];
    [_simpleViewController reloadData];
    */
    
    
}







































//----------------- PROTOCOL METHODS -------------------------

- (void) animateAppearance
{
    if (!_bolButtonPressed) {
        if (_bolFoundScrollView) {
            return;
        } else {
            if (_currentIndex == 0) {
                [_logoView setFrame:_rightItemRect];
                [_listView setFrame:_outRightItemRect];
                [_gearView setFrame:_centerItemRect];
            } else if (_currentIndex == 1) {
                [_logoView setFrame:_centerItemRect];
                [_listView setFrame:_rightItemRect];
                [_gearView setFrame:_leftItemRect];
            } else if (_currentIndex == 2) {
                [_logoView setFrame:_leftItemRect];
                [_listView setFrame:_centerItemRect];
                [_gearView setFrame:_outLeftItemRect];
            }
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            
            if (_logoView.frame.origin.x == _centerItemRect.origin.x) {
                [_logoView setAlpha:1];
                [_listView setAlpha:0.4];
                [_gearView setAlpha:0.4];
            } else if (_listView.frame.origin.x == _centerItemRect.origin.x) {
                [_logoView setAlpha:0.4];
                [_listView setAlpha:1];
                [_gearView setAlpha:0.4];
            } else if (_gearView.frame.origin.x == _centerItemRect.origin.x) {
                [_logoView setAlpha:0.4];
                [_listView setAlpha:0.4];
                [_gearView setAlpha:1];
            }
            [UIView commitAnimations];
        }
    } else if (!_bolButtonPressedHelper) {
        return;
    }
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if (_currentIndex == 0) {
        [_logoView setFrame:_rightItemRect];
        [_listView setFrame:_outRightItemRect];
        [_gearView setFrame:_centerItemRect];
    } else if (_currentIndex == 1) {
        [_logoView setFrame:_centerItemRect];
        [_listView setFrame:_rightItemRect];
        [_gearView setFrame:_leftItemRect];
    } else if (_currentIndex == 2) {
        [_logoView setFrame:_leftItemRect];
        [_listView setFrame:_centerItemRect];
        [_gearView setFrame:_outLeftItemRect];
    }
    if (_logoView.frame.origin.x == _centerItemRect.origin.x) {
        [_logoView setAlpha:1];
        [_listView setAlpha:0.4];
        [_gearView setAlpha:0.4];
    } else if (_listView.frame.origin.x == _centerItemRect.origin.x) {
        [_logoView setAlpha:0.4];
        [_listView setAlpha:1];
        [_gearView setAlpha:0.4];
    } else if (_gearView.frame.origin.x == _centerItemRect.origin.x) {
        [_logoView setAlpha:0.4];
        [_listView setAlpha:0.4];
        [_gearView setAlpha:1];
    }
    [UIView commitAnimations];
    
    if (_bolAlreadyCounting) {
        _bolSkipIt = true;
    }
    _bolAlreadyCounting = true;
    NSTimer *tempTimer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(buttonTransDone) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:tempTimer forMode:NSDefaultRunLoopMode];
    
}

-(void) buttonTransDone
{
    if (_bolSkipIt) {
        _bolSkipIt = false;
        return;
    }
    _bolButtonPressed = false;
    _bolButtonPressedHelper = false;
    _bolAlreadyCounting = false;
}

- (void) animateDisappearance
{
    if (_bolButtonPressed) {
        _bolButtonPressedHelper = true;
        [self animateAppearance];
    }
    if (_bolFoundScrollView) {
        return;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [_logoView setAlpha:0];
    [_listView setAlpha:0];
    [_gearView setAlpha:0];
    [UIView commitAnimations];
    
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    UIViewController* currentViewController = [_pageController.viewControllers objectAtIndex:0];
    if ([currentViewController isMemberOfClass:[LVFTableViewController class]]) {
        _intIndex = 2;
    } else if ([currentViewController isMemberOfClass:[LVFViewControllerTwo class]]) {
        _intIndex = 1;
    } else if ([currentViewController isMemberOfClass:[LVFSettingsController class]]) {
        _intIndex = 0;
    }
    
    
    
    //[_pcDots setCurrentPage:_intIndex];
}




- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if ([viewController isMemberOfClass:[LVFViewControllerTwo class]]) {
        
        LVFSettingsController *impleViewController = [[LVFSettingsController alloc] initWithMainController:_mainController];
        return impleViewController;
    } else if ([viewController isMemberOfClass:[LVFTableViewController class]]) {
        LVFViewControllerTwo *impleViewController = [[LVFViewControllerTwo alloc] initWithMainController:_mainController];
        
        return impleViewController;
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    if ([viewController isMemberOfClass:[LVFViewControllerTwo class]]) {
        LVFTableViewController *impleViewController = [[LVFTableViewController alloc] initWithMainController:_mainController];
        
        return impleViewController;
    } else if ([viewController isMemberOfClass:[LVFSettingsController class]]) {
        
        LVFViewControllerTwo *impleViewController = [[LVFViewControllerTwo alloc] initWithMainController:_mainController];
        return impleViewController;
    } else {
        return nil;
    }
    
}





- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 1;
}

@end
