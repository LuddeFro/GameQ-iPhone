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
#define kOFFLINE 0
#define kONLINE 1
#define kINGAME 2

@interface LVFTableViewController ()

@end

@implementation LVFTableViewController

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
	// Do any additional setup after loading the view.
    _connectionsHandler = [[LVFConnections alloc] initFromController:_mainController];
    [self requestUpdate];
    CGRect frame = CGRectMake(0, 66, 320, [UIScreen mainScreen].bounds.size.height -66);
    _tableView = [[LVFTableView alloc] initWithFrame:frame andController:self];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    CGRect frame2 = CGRectMake(0, 22, 320, 44);
    _navBar = [[UINavigationBar alloc] initWithFrame:frame2];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Online Devices"];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(popController)];
    [item setRightBarButtonItem:button];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refreshDefault.png"] style:UIBarButtonItemStylePlain target:self action:@selector(requestUpdate)];
    [item setLeftBarButtonItem:refreshButton];
    [_navBar pushNavigationItem:item animated:YES];
    [self.view addSubview:_navBar];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self requestUpdate];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestUpdate
{
    [_connectionsHandler upAppPost];
}

- (void) receiveUpdate:(NSMutableArray*)array
{
    _deviceArray = array;
    [_tableView reloadData];
    
    NSLog(@"reloading table data");
}

-(void) popController
{
    [_mainController.connectionsHandler logoutPost];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [_deviceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int row = [indexPath row];
    NSString *item = [_deviceArray objectAtIndex:row];
    
    UIImageView *imgCellImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 43, 43)];
    UILabel *lblDeviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 03, 180, 21)];
    UILabel *lblStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 19
                                                                        , 180, 21)];
    
    [lblStatusLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    [imgCellImage setImage:[UIImage imageNamed:@"GQHomeScreen.png"]];
    
    NSString *gameString = nil;
    
    switch ([[item substringToIndex:2] intValue]) {
        case kNOGAME:
            gameString = Nil;
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
        case kOFFLINE:
            lblStatusLabel.text = @"Not gaming";
            break;
        case kONLINE:
            lblStatusLabel.text = [NSString stringWithFormat:@"Online on %@", gameString];
            break;
        case kINGAME:
            lblStatusLabel.text = [NSString stringWithFormat:@"Currently Playing %@", gameString];
            break;
            
        default:
            break;
    }
    
    
    
    
    lblDeviceLabel.text = [item substringFromIndex:4];
    
    
    [cell.contentView addSubview:imgCellImage];
    [cell.contentView addSubview:lblStatusLabel];
    [cell.contentView addSubview:lblDeviceLabel];
    
    
    
    NSLog(@"statuslabel: %@",lblStatusLabel.text);
    NSLog(@"devicelabel: %@",lblDeviceLabel.text);
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














