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


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
    UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
    UIColor *myLightGray = [UIColor colorWithRed:0.2 green:0.2 blue:0.22 alpha:1];
    [self.view setBackgroundColor:myDarkGray];
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.backgroundColor = myDarkGray;
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageController.dataSource = self;
    _pageController.delegate = self;
    [[_pageController view] setFrame:[[self view] bounds]];
    //[[_pageController view] setFrame:[[self view] bounds]];
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
    [self startTimer];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    
    _listView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"listIcon.png"]];
    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteQ.png"]];
    _gearView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kuggDefault.png"]];
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
    [_navBar setBackgroundColor:myLightGray];
    [_navBar setTintColor:myWhite];
    [_navBar setBarTintColor:myLightGray];
    [_navBar setTranslucent:NO];
    [_navBar pushNavigationItem:item animated:YES];
    
    
    UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0,_navBar.frame.size.height-1,_navBar.frame.size.width, 1)];
    
    // Change the frame size to suit yours //
    
    [navBorder setBackgroundColor:myWhite];
    [navBorder setOpaque:YES];
    [_navBar addSubview:navBorder];
    
    
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
}
- (void) stopTimer {
    [_refreshTimer invalidate];
    //[countdownSlowTimer invalidate];
}

- (void)requestUpdate
{
    NSLog(@"refreshing");
    [_connectionsHandler upAppPost];
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
        for (int i = 0; i < _deviceArray.count; i++) {
            NSLog(@"counting 1");
            switch ([[_deviceArray objectAtIndex:i] substringWithRange:NSMakeRange(2, 2)].integerValue) {
                case 0: //Offline
                    [_array0 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 0");
                    break;
                case 1: //Online
                    [_array1 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 1");
                    break;
                case 2: //In-Game
                    [_array2 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 2");
                    break;
                case 4: //Off / disconnected
                    [_array4 addObject:[_deviceArray objectAtIndex:i]];
                    NSLog(@"added to 4");
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
- (void) animateDisappearance
{
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

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
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
