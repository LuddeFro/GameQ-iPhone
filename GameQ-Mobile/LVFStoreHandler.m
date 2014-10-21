//
//  LVFStoreHandler.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 03/10/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFStoreHandler.h"

@implementation LVFStoreHandler


- (id)initWithMainController:(LVFViewController*)controller settingsController:(LVFSettingsController*)settingsCon andContentView:(UIView*)view forPurchase:(BOOL)isPurchasing
{
    self = [super init];
    if (self) {
        // Custom initialization
        _displayArray = [[NSMutableArray alloc] init];
        _buttons = [[NSMutableArray alloc] init];
        _prices = [[NSMutableArray alloc] init];
        
        if(isPurchasing) {
            _checkedOwnedGames = false;
        } else {
            _checkedOwnedGames = true;
        }
        _mainController = controller;
        _mainView = view;
        _isPurchasing = isPurchasing;
        _productIdentifiers = [[NSArray alloc] initWithObjects:productCsgo, productDota, productHon, nil];
        _settingsController = settingsCon;
        _mainController.storeHandler = self;
        [self validateProductIdentifiers:_productIdentifiers];
        if (isPurchasing) {
            [_mainController.connectionsHandler getMyGamesForEmail:_mainController.dataHandler.getEmail];
        }
        
        
    }
    return self;
}



// Custom method
- (void)validateProductIdentifiers:(NSArray *)productIdentifiers
{
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    productsRequest.delegate = self;
    [productsRequest start];
}

// SKProductsRequestDelegate protocol method
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    _productArray = response.products;
    
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        // Handle any invalid product identifiers.
        NSLog(@"invalid product identifier: '%@' !!!!!!", invalidIdentifier);
    }
    
    [self displayStoreUI]; // Custom method
}


- (void) displayStoreUI
{
    UIImage *tmpImage;
    
    UIColor *myRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:1];
    UIColor *myTransRed = [UIColor colorWithRed:0.905 green:0.298 blue:0.235 alpha:0.5];
    for (SKProduct* product in _productArray) {
        
        LVFProduct* newProd = [[LVFProduct alloc] init];
        newProd.image = tmpImage;
        newProd.product = product;
        [_displayArray addObject:newProd];
        
    }
    
    CGRect scrollFrame = CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height-290)/2 - 20, [[UIScreen mainScreen] bounds].size.width, 290);
    UIScrollView* storeView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    [storeView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    
    CGRect titleFrame = CGRectMake(0, ([[UIScreen mainScreen] bounds].size.height-290)/2 - 10, [[UIScreen mainScreen] bounds].size.width, 40);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:30]];
    if (_isPurchasing) {
        [titleLabel setText:@"Add Games"];
    } else {
        [titleLabel setText:@"Select Game"];
    }
    
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    _backgroundButton = [[UIButton alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_mainView addSubview:_backgroundButton];
    [_backgroundButton setTitle:@"" forState:UIControlStateNormal];
    [_backgroundButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [_backgroundButton addTarget:self action:@selector(quitStore:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundButton addSubview:storeView];
    [_backgroundButton addSubview:titleLabel];
    
    int i = 0;
    for (LVFProduct* product in _displayArray) {
        
        int gameI = 0;
        if ([product.product.productIdentifier isEqualToString:productCsgo]) {
            tmpImage = [UIImage imageNamed:@"cslogo.png"];
            gameI = 3;
        } else if ([product.product.productIdentifier isEqualToString:productDota]) {
            tmpImage = [UIImage imageNamed:@"dotalogo.png"];
            gameI = 2;
        } else if ([product.product.productIdentifier isEqualToString:productHon]) {
            tmpImage = [UIImage imageNamed:@"honlogo.png"];
            gameI = 1;
        }
        
        NSString *formattedPrice;
        if (_isPurchasing) {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [numberFormatter setLocale:product.product.priceLocale];
            formattedPrice = [NSString stringWithFormat:@"Price: %@", [numberFormatter stringFromNumber:product.product.price]];
        } else {
            formattedPrice = @"";
        }
        
        CGRect imgFrame = CGRectMake(50 + (228*i), 50, 128, 128);
        CGRect descFrame = CGRectMake(22.5 + (228*i), 175, 180, 55);
        CGRect priceFrame = CGRectMake(53 + (228*i), 228, 120, 21);
        CGRect buyFrame =  CGRectMake(63.5 + (228*i), 243, 100, 30);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgFrame];
        UILabel *lblDesc = [[UILabel alloc] initWithFrame:descFrame];
        UILabel *lblPrice = [[UILabel alloc] initWithFrame:priceFrame];
        UIButton *btnBuy = [[UIButton alloc] initWithFrame:buyFrame];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [lblDesc setText: [product product].localizedDescription ];
        [lblPrice setText:formattedPrice];
        if (_isPurchasing) {
            [btnBuy setTitle:@"Buy" forState:UIControlStateNormal];
        } else {
            [btnBuy setTitle:@"Select" forState:UIControlStateNormal];
        }
        [imageView setImage:tmpImage];
        
        [lblDesc setFont:[UIFont systemFontOfSize:12]];
        [lblPrice setFont:[UIFont systemFontOfSize:15]];
        [btnBuy.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [lblDesc setTextColor:[UIColor whiteColor]];
        [lblPrice setTextColor:[UIColor whiteColor]];
        [[btnBuy titleLabel] setTextColor:myRed];
        [btnBuy setTitleColor:myTransRed forState:UIControlStateHighlighted];
        [btnBuy setTitleColor:myRed forState:UIControlStateNormal];
        [btnBuy setTag:gameI];
        [lblPrice setTag:gameI];
        [btnBuy addTarget:self action:@selector(purchaseFromButton:) forControlEvents:UIControlEventTouchUpInside];
        [lblDesc setNumberOfLines:0];
        
        [lblDesc setTextAlignment:NSTextAlignmentCenter];
        [lblPrice setTextAlignment:NSTextAlignmentCenter];
        
        [storeView addSubview:lblDesc];
        [storeView addSubview:lblPrice];
        [storeView addSubview:imageView];
        [storeView addSubview:btnBuy];
        [_buttons addObject:btnBuy];
        [_prices addObject:lblPrice];
        product.tag = gameI;
        
        i++;
    }
    for (UIButton *button in _buttons) {
        if (!_checkedOwnedGames) {
            [button setEnabled:NO];
            [button setTitle:@"Checking Availability" forState:UIControlStateNormal];
        }
    }
    [storeView setContentSize:CGSizeMake(228*i, 200)];
    
    [_mainView addSubview:_backgroundButton];
    if (_isPurchasing) {
        [self updateForGames:_reUpdateString];
    }
}

- (void) purchaseFromButton:(UIButton *)sender
{
    [sender setTitle:@"Processing" forState:UIControlStateNormal];
    [sender setEnabled:NO];
    for (LVFProduct* product in _displayArray) {
        NSLog(@"tag::::==::::: %ld", (long)sender.tag);
        if (product.tag == sender.tag) {
            NSString *gameString = @"";
            if ([product.product.productIdentifier isEqualToString:productCsgo]) {
                gameString = @"3";
            } else if ([product.product.productIdentifier isEqualToString:productDota]) {
                gameString = @"2";
            } else if ([product.product.productIdentifier isEqualToString:productHon]) {
                gameString = @"1";
            }
            if (!_isPurchasing) {
                
                [_mainController.connectionsHandler upMyGamesForEmail:_mainController.dataHandler.getEmail andNewGames:gameString];
                
            } else {
                
                
                SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product.product];
                [payment setApplicationUsername:[self hashedValueForAccountName:_mainController.dataHandler.getEmail]];
                [[SKPaymentQueue defaultQueue] addPayment:payment];
                
                
            }
            
            NSLog(@"purchasing: %@", product.product.productIdentifier);
            
            
        }
    }
}

-(void) updateForGames:(NSString*)string
{
    _reUpdateString = string;
    NSLog(@"updating for : %@", string);
    NSArray *games = [string componentsSeparatedByString:@":"];
    for (NSString* game in games) {
        NSLog(@"game:::: %@", game);
        for (UIButton* button in _buttons) {
            NSLog(@"gameStringIntVal: %ld, Tag: %ld", (long)game.integerValue, (long)button.tag);
            if (game.integerValue == button.tag) {
                
                NSLog(@"same button");
                [button removeFromSuperview];
            } else {
                if ([button.titleLabel.text isEqualToString:@"Checking Availability"]) {
                    [button setTitle:@"Buy" forState:UIControlStateNormal];
                    [button setEnabled:YES];
                } else {
                    
                }
            }
        }
        for (UILabel* label in _prices) {
            NSLog(@"gameStringIntVal: %ld, lblTag: %ld", (long)game.integerValue, (long)label.tag);
            if (game.integerValue == label.tag) {
                NSLog(@"same label");
                [label setText:@"Already Owned"];
                [((LVFAppDelegate *)[[UIApplication sharedApplication] delegate]).storeObserver setPaymentFinishedForGamesTransactionWithGame:game];
            } else {
                //??
            }
        }
    }
    _checkedOwnedGames = true;
}

- (void) quitStore:(UIButton *)sender
{
    
    if (_settingsController != NULL) {
        [[_settingsController btnStore]  setEnabled:YES];
        [sender removeFromSuperview];
    } 
}



-(void) stopProcessing:(NSString*)string
{
    for (UIButton* button in _buttons) {
        if (string.integerValue == button.tag && [button.titleLabel.text isEqualToString:@"Processing"]) {
            [button setEnabled:YES];
            [button setTitle:@"Buy" forState:UIControlStateNormal];
            
        } else {
            
        }
    }
}







// Custom method to calculate the SHA-256 hash using Common Crypto
- (NSString *)hashedValueForAccountName:(NSString*)userAccountName
{
    const int HASH_SIZE = 32;
    unsigned char hashedChars[HASH_SIZE];
    const char *accountName = [userAccountName UTF8String];
    size_t accountNameLen = strlen(accountName);
    
    // Confirm that the length of the user name is small enough
    // to be recast when calling the hash function.
    if (accountNameLen > UINT32_MAX) {
        NSLog(@"Account name too long to hash: %@", userAccountName);
        return nil;
    }
    CC_SHA256(accountName, (CC_LONG)accountNameLen, hashedChars);
    
    // Convert the array of bytes into a string showing its hex representation.
    NSMutableString *userAccountHash = [[NSMutableString alloc] init];
    for (int i = 0; i < HASH_SIZE; i++) {
        // Add a dash every four bytes, for readability.
        if (i != 0 && i%4 == 0) {
            [userAccountHash appendString:@"-"];
        }
        [userAccountHash appendFormat:@"%02x", hashedChars[i]];
    }
    
    return userAccountHash;
}




@end
