//
//  LVFCell.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/03/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFCell.h"

@implementation LVFCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imgCellImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 43, 11, 21, 21)];
        _lblDeviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 03, self.frame.size.width-50, 21)];
        _lblStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 19
                                                                   , self.frame.size.width-50, 21)];
        [self.contentView addSubview:_imgCellImage];
        [self.contentView addSubview:_lblStatusLabel];
        [self.contentView addSubview:_lblDeviceLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
