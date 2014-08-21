//
//  LVFTableController.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 07/11/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import "LVFTableViewController.h"

#define kNOGAME 0
#define kHEROES_OF_NEWERTH 1
#define kDOTA2 2
#define kCS_GO 3
#define kOFF 4
#define kOFFLINE 0
#define kONLINE 1
#define kINGAME 2

@interface LVFTableViewController ()

@end

@implementation LVFTableViewController

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
    _mainController.secondViewController.currentIndex = 2;
    [_mainController.secondViewController animateAppearance];
}

-(void) viewWillAppear:(BOOL)animated
{
    [_mainController.secondViewController requestUpdate];
    _mainController.secondViewController.currentIndex = 2;
    [_mainController.secondViewController animateDisappearance];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
    UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
    
	// Do any additional setup after loading the view.
    _connectionsHandler = [[LVFConnections alloc] initFromController:_mainController];
    [self requestUpdate];
    CGRect frame = CGRectMake(0, 66, 320, [UIScreen mainScreen].bounds.size.height -66);
    _tableView = [[LVFTableView alloc] initWithFrame:frame andController:self];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view setBackgroundColor:myWhite];
    CGRect frame2 = CGRectMake(0, 22, 320, 44);
    _navBar = [[UINavigationBar alloc] initWithFrame:frame2];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setShadowColor:[UIColor colorWithWhite:1 alpha:0]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"My Devices"];
    [titleLabel sizeToFit];
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.titleView = titleLabel;
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"kuggDefault.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushSettingsController:)];
    [item setRightBarButtonItem:button];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteQ.png"]];
    [logoView setFrame:CGRectMake(15, 7, 30, 30)];
    [_navBar addSubview:logoView];
    
    
    
    
    [_navBar pushNavigationItem:item animated:YES];
    [self.view addSubview:_navBar];
    [self.view setBackgroundColor:myRed];
    [_tableView setBackgroundColor:myDarkGray];
    [_navBar setBarStyle:UIBarStyleDefault];
    [_navBar setBackgroundColor:myRed];
    [_navBar setTintColor:myWhite];
    [_navBar setBarTintColor:myRed];
    [_navBar setTranslucent:NO];
    [self startTimer];
    
    _array0 = [[NSMutableArray alloc] init];
    _array1 = [[NSMutableArray alloc] init];
    _array2 = [[NSMutableArray alloc] init];
    _array4 = [[NSMutableArray alloc] init];
    
    
}



-(void)dummy
{
    return;
}

-(IBAction)pushSettingsController:(id)sender
{
    _settingsController = [[LVFSettingsController alloc] initWithMainController:_mainController];
    [self presentViewController:_settingsController animated:YES completion:NULL];
}



- (void) startTimer {
    _refreshTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(requestUpdate) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_refreshTimer forMode:NSDefaultRunLoopMode];
    
    
}
- (void) stopTimer {
    [_refreshTimer invalidate];
    //[countdownSlowTimer invalidate];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (_array2.count == 0 && _deviceArray.count != 0) {
            return 0;
        }
    } else if (section == 1) {
        if (_array1.count == 0) {
            return 0;
        }
    } else if (section == 2) {
        if (_array0.count == 0) {
            return 0;
        }
    } else if (section == 3) {
        if (_array4.count == 0) {
            return 0;
        }
    } else {
        return 15.0f;
    }
    return 15.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    UIColor *myDarkGray = [UIColor colorWithRed:0.1333 green:0.1333 blue:0.1333 alpha:1];
    UIColor *myWhite = [UIColor colorWithWhite:1 alpha:1];
    [label setBackgroundColor:myDarkGray];
    [label setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [label setShadowColor:[UIColor colorWithWhite:1 alpha:0]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:myWhite];
    [label sizeToFit];
    if (section == 0) {
        if (_array2.count == 0) {
            [label setText:@"No Devices"];
        } else {
            [label setText:@"In-Game"];
        }
    } else if (section == 1) {
        if (_array1.count == 0) {
            return nil;
        }
        [label setText:@"Online"];
    } else if (section == 2) {
        if (_array0.count == 0) {
            return nil;
        }
        [label setText:@"Offline"];
    } else if (section == 3) {
        if (_array4.count == 0) {
            return nil;
        }
        [label setText:@"Disconnected"];
    } else {
        return nil;
    }
    return label;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestUpdate
{
    NSLog(@"refreshing");
    [_connectionsHandler upAppPost];
}

- (void) reload
{
    [self receiveUpdate:self.mainController.secondViewController.deviceArray];
}

- (void) receiveUpdate:(NSMutableArray*)array
{
    NSLog(@"reloading table data");
    _deviceArray = array;
    [_array0 removeAllObjects];
    [_array1 removeAllObjects];
    [_array2 removeAllObjects];
    [_array4 removeAllObjects];
    for (int i = 0; i < _deviceArray.count; i++) {
        
            switch ([[_deviceArray objectAtIndex:i] substringWithRange:NSMakeRange(2, 2)].integerValue) {
                case 0: //Offline
                    [_array0 addObject:[_deviceArray objectAtIndex:i]];
                    break;
                case 1: //Online
                    [_array1 addObject:[_deviceArray objectAtIndex:i]];
                    break;
                case 2: //In-Game
                    [_array2 addObject:[_deviceArray objectAtIndex:i]];
                    break;
                case 4: //Off / disconnected
                    [_array4 addObject:[_deviceArray objectAtIndex:i]];
                    break;
                default:
                    break;
            }
    }
    
    [_tableView reloadData];
    
}

-(void) popController
{
    NSLog(@"popTable");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (_deviceArray.count == 0 && section == 0) {
        return 1;
    } else if (section == 0) { //ingame == 2
        return [_array2 count];
    } else if (section == 1) { //online == 1
        return [_array1 count];
    } else if (section == 2) { //offline == 0
        return [_array0 count];
    } else if (section == 3) { //off /disconnected =0 4
        return [_array4 count];
    } else {
        return 0;
    }
}

- (LVFCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"celling up");
    static NSString *CellIdentifier = @"Cell";
    [_tableView registerClass:[LVFCell class] forCellReuseIdentifier:CellIdentifier];
    LVFCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == Nil) {
        
        cell = [[LVFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSString *item;
    int row = (int)[indexPath row];
    
    



    
    NSString *gameString = nil;
    [cell.lblStatusLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    
    if (_deviceArray.count == 0) {
        [cell.lblDeviceLabel setText:@"You have no connected computers"];
        [cell.lblStatusLabel setText:@"Install GameQ on your other devices!"];
        [cell.lblDeviceLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.lblStatusLabel setTextAlignment:NSTextAlignmentCenter];
        [cell.imgCellImage setAlpha:0];
        
    } else {
        if (indexPath.section == 0) { //in-game == 2
            item = [_array2 objectAtIndex:row];
        } else if (indexPath.section == 1) { //online == 1
            item = [_array1 objectAtIndex:row];
        } else if (indexPath.section == 2) { // offline == 0
            item = [_array0 objectAtIndex:row];
        } else if (indexPath.section == 3) { // off / disconnected = 4
            item = [_array4 objectAtIndex:row];
        }
        
        
        
        [cell.imgCellImage setAlpha:1];
        [cell.lblDeviceLabel setTextAlignment:NSTextAlignmentLeft];
        [cell.lblStatusLabel setTextAlignment:NSTextAlignmentLeft];
        switch ([[item substringToIndex:2] intValue]) {
            case kNOGAME:
                gameString = Nil;
                [cell.imgCellImage setImage:[UIImage imageNamed:@"redLight.png"]];
                cell.lblStatusLabel.text = @"Not gaming";
                break;
            case kHEROES_OF_NEWERTH:
                gameString = @"Heroes of Newerth";
                break;
            case kDOTA2:
                gameString = @"Dota 2";
                break;
            case kCS_GO:
                gameString = @"CS: GO";
                break;
                
                
            default:
                break;
        }
        
        
            switch ([[item substringWithRange:NSMakeRange(2, 2)] intValue]) {
                case kONLINE:
                    cell.lblStatusLabel.text = [NSString stringWithFormat:@"Online on %@", gameString];
                    [cell.imgCellImage setImage:[UIImage imageNamed:@"yellowLight.png"]];
                    NSLog(@"tjorren");
                    break;
                    
                case kINGAME:
                    cell.lblStatusLabel.text = [NSString stringWithFormat:@"Currently playing %@", gameString];
                    [cell.imgCellImage setImage:[UIImage imageNamed:@"greenLight.png"]];
                    NSLog(@"tjorrtvå");
                    break;
                    
                case kOFF:
                    [cell.imgCellImage setImage:[UIImage imageNamed:@"greyLight.png"]];
                    cell.lblStatusLabel.text = @"This device is offline";
                    
                    NSLog(@"tjorrtre");
                    break;
                    
                case kOFFLINE:
                    cell.lblStatusLabel.text = @"Not gaming";
                    gameString = Nil;
                    [cell.imgCellImage setImage:[UIImage imageNamed:@"redLight.png"]];
                    NSLog(@"tjorrfyra");
                    break;
                default:
                    NSLog(@"status not found: %d", [[item substringWithRange:NSMakeRange(2, 2)] intValue]);
                    break;
            }
        
        
        cell.lblDeviceLabel.text = [item substringWithRange:NSMakeRange(4, item.length-18)];

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    NSLog(@"statuslabel: %@",cell.lblStatusLabel.text);
    NSLog(@"devicelabel: %@",cell.lblDeviceLabel.text);
    NSLog(@"item: %@",item);
    
    
    
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */








@end














