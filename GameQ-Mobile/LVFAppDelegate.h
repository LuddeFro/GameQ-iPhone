//
//  LVFAppDelegate.h
//  GameQ-Mobile
//
//  Created by Ludvig Fröberg on 10/21/13.
//  Copyright (c) 2013 Ludvig Fröberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVFViewController.h"
#import "LVFDefinitions.h"
#import "iRate.h"


@class  LVFViewController;


@interface LVFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) LVFViewController *mainController;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
