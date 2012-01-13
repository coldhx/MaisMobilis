//
//  AppDelegate.h
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "DataController.h"
#import "Version.h"

@class Reachability;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability *maisMobilisServerReachable;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) resetStore;
- (void) initializeCoreData;
- (void) reachabilityChanged: (NSNotification* )note;
- (void) checkConnectivity;

@end
