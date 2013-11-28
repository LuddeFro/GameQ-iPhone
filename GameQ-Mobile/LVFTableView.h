//
//  LVFTableView.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 07/11/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFTableViewController.h"
#import "LVFViewController.h"
@class  LVFTableViewController;

@interface LVFTableView : UITableView 

@property (strong, nonatomic) LVFTableViewController *tableController;

- (id)initWithFrame:(CGRect)frame andController:(LVFTableViewController*)controller;


@end
