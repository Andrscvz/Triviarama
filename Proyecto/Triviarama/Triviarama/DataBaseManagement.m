//
//  DataBaseManagement.m
//  Triviarama
//
//  Created by Andres Cavazos on 10/24/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "DataBaseManagement.h"
#import "Scores.h"


@implementation DataBaseManagement

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


#pragma mark - Core Data stack

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Scores" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Score.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (id)init
{
    if(self = [super init]){
        [self setScoreList:[[NSMutableArray alloc] init]];
    }
    
    return self;
}

+ (DataBaseManagement  *)instance
{
    static DataBaseManagement *_instancia = nil;
    static dispatch_once_t safer;
    
    dispatch_once(&safer, ^(void){
        _instancia = [[DataBaseManagement alloc] init];
    });
    
    return _instancia;
}

-(void)insertScore:(id)score
{
    NSManagedObjectContext *context = self.managedObjectContext;
    Scores *nueva = [NSEntityDescription insertNewObjectForEntityForName:@"Scores" inManagedObjectContext:context];
    NSDictionary *scores = (NSDictionary *)score;
    nueva.id = [scores objectForKey: @"id"];
    nueva.nombre = [scores objectForKey:@"nombre"];
    nueva.points = [scores objectForKey:@"points"];
    nueva.score = [scores objectForKey:@"score"];
    nueva.time = [scores objectForKey:@"time"];
    nueva.wrongMoves = [scores objectForKey:@"wrongMoves"];
    
    [self saveContext];
}

- (void) loadScoresPlist {
    NSBundle *miBundle = [NSBundle mainBundle];
    NSString *path = [miBundle pathForResource:@"Scores" ofType:@"plist"];
    NSMutableArray *scores = [NSMutableArray arrayWithContentsOfFile:path];
    for(id m in scores) {
        [self insertScore:m];
    }
}

-(NSMutableArray*)loadScore
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Scores" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSError *error;
    NSMutableArray *results = (NSMutableArray*)[context executeFetchRequest:request error:&error];
    Scores *temp;
    
    if(results.count==0){
        /*NSLog(@"There are no scores saved...");
         [self loadScoresPlist];*/
        return NULL;
    }else{
        if (_scoreList) {
            _scoreList = [[NSMutableArray alloc] init];
        }
        for (int i = 0; i < results.count; i++) {
            temp = results[i];
            
            NSMutableDictionary *miDicc = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                           [temp valueForKey:@"id"], @"id",
                                           [temp valueForKey:@"nombre"], @"nombre",
                                           [temp valueForKey:@"points"], @"points",
                                           [temp valueForKey:@"score"], @"score" ,
                                           [temp valueForKey:@"time"], @"time" ,
                                           [temp valueForKey:@"wrongMoves"], @"wrongMoves" ,nil];
            
            [self.scoreList addObject:miDicc];
            
        }
        
        return self.scoreList;
    }
    
}

@end























