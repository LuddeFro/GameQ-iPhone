//
//  LVFProduct.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 03/10/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


@interface LVFProduct : NSObject


@property SKProduct* product;
@property UIImage* image;
@property int tag;


@end
