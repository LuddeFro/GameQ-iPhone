//
//  LVFTableView.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 07/11/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import "LVFTableView.h"

@implementation LVFTableView

- (id)initWithFrame:(CGRect)frame andController:(LVFTableViewController*)controller
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableController = controller;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
