//
//  LVFStoreHandler.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 03/10/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LVFViewController.h"
#import "LVFProduct.h"
#import <StoreKit/StoreKit.h>
#import "LVFSettingsController.h"
#import <CommonCrypto/CommonCrypto.h>
#import "LVFAppDelegate.h"
#import "LVFTableViewController.h"

#define productDota @"dota2Access"
#define productCsgo @"csgoAccess"
#define productHon @"honAccess"

@class LVFSettingsController;
@class LVFViewController;
@class LVFTableViewController;

@interface LVFStoreHandler : NSObject <SKProductsRequestDelegate>


@property LVFViewController* mainController;
@property UIView* mainView;
@property NSArray* productArray;
@property NSArray* productIdentifiers;
@property NSMutableArray* displayArray;
@property BOOL isPurchasing;
@property NSMutableArray* orderedTagList;
@property LVFSettingsController* settingsController;
@property LVFTableViewController* tableController;
@property UIButton* backgroundButton;
@property NSMutableArray* buttons;
@property NSMutableArray* prices;
@property BOOL checkedOwnedGames;
@property BOOL showing;
@property NSString* reUpdateString;
- (id)initWithMainController:(LVFViewController*)controller settingsController:(LVFSettingsController*)settingsCon andContentView:(UIView*)view forPurchase:(BOOL)isPurchasing;
- (id)initWithMainController:(LVFViewController*)controller tableController:(LVFTableViewController*)tableCon andContentView:(UIView*)view forPurchase:(BOOL)isPurchasing;
-(void) updateForGames:(NSString*)string;
-(void) stopProcessing:(NSString*)string;
- (void) displayStoreUI;
@end
