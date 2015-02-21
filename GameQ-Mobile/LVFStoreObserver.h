//
//  LVFStoreObserver.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/10/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "LVFViewController.h"
#import "LVFDefinitions.h"
@class LVFViewController;

@interface LVFStoreObserver : NSObject <SKPaymentTransactionObserver>




@property LVFViewController *mainController;
@property NSMutableArray *finishedTransactions;
@property NSMutableDictionary *processingTrans;

-(id)initWithMainController:(LVFViewController*)mainC;
-(void) setPaymentFinishedForGamesTransactionWithGame:(NSString *)game;
-(void) finishAllPayments;
@end
