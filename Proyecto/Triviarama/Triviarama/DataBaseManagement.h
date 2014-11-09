//
//  DataBaseManagement.h
//  Triviarama
//
//  Created by Andres Cavazos on 10/24/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataBaseManagement : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
-(void)saveContext;


@property (strong, nonatomic) NSMutableArray *scoreList;

- (id) init;

+ (DataBaseManagement *) instance;

- (void)insertScore:(id) score;

- (NSMutableArray *) loadScore;

@end
