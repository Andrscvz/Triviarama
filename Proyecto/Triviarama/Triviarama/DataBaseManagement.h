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


@property (strong, nonatomic) NSMutableArray *scoreList;

- (id) init;
+ (DataBaseManagement *) instancia;

- (void)insertarMascota:(id) mascota conVacunas:(NSArray *)vacunas;

- (Vacunas *)insertarVacuna:(id)datosVacuna;

- (NSMutableArray *) cargarMascotas;

- (void) cargarVacunas;

- (id) buscarVacuna:(NSString *) nombre;

- (NSArray *) buscarVacunasParaMascota:(NSString *) nombre;


@end
