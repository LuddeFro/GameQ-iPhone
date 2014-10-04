//
//  LVFStoreObserver.m
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 04/10/14.
//  Copyright (c) 2014 Ludvig Fröberg. All rights reserved.
//

#import "LVFStoreObserver.h"

@implementation LVFStoreObserver


-(id)initWithMainController:(LVFViewController*)mainC
{
    self = [super init];
    if (self) {
        // Custom initialization
        _mainController = mainC;
        
        
    }
    return self;
}


-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
                // Call the appropriate custom method.
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

-(void) completeTransaction:(SKPaymentTransaction *)transaction
{
    
    NSString *gameString = @"";
    if ([transaction.payment.productIdentifier isEqualToString:productCsgo]) {
        gameString = @"3";
    } else if ([transaction.payment.productIdentifier isEqualToString:productDota]) {
        gameString = @"2";
    } else if ([transaction.payment.productIdentifier isEqualToString:productHon]) {
        gameString = @"1";
    }
    [_processingTrans setObject:transaction forKey:gameString];
    [_mainController.connectionsHandler upMyGamesForEmail:_mainController.dataHandler.getEmail andNewGames:gameString];
    
}

-(void) failedTransaction:(SKPaymentTransaction *)transaction
{
    [[[UIAlertView alloc] initWithTitle:@"GameQ" message:[NSString stringWithFormat:@"The transaction for %@ failed.", transaction.payment.productIdentifier] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self setPaymentFinishedForGamesTransaction:transaction];
    NSString *gameString = @"";
    if ([transaction.payment.productIdentifier isEqualToString:productCsgo]) {
        gameString = @"3";
    } else if ([transaction.payment.productIdentifier isEqualToString:productDota]) {
        gameString = @"2";
    } else if ([transaction.payment.productIdentifier isEqualToString:productHon]) {
        gameString = @"1";
    }
    [_mainController.storeHandler stopProcessing:gameString];
    [_mainController.connectionsHandler getMyGamesForEmail:_mainController.dataHandler.getEmail];
}

-(void) restoreTransaction:(SKPaymentTransaction *)transaction
{
    [[[UIAlertView alloc] initWithTitle:@"GameQ" message:@"Your previous purchases have been restored!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self setPaymentFinishedForGamesTransaction:transaction];
    
}

-(void) setPaymentFinishedForGamesTransaction:(SKPaymentTransaction *)transaction
{
    [_finishedTransactions removeObject:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
-(void) setPaymentFinishedForGamesTransactionWithGame:(NSString *)game
{
    SKPaymentTransaction *transaction = [_processingTrans objectForKey:game];
    [_processingTrans removeObjectForKey:game];
    if (transaction != nil) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}
@end
