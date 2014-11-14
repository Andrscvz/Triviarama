//
//  ApiBD.h
//  A00618181_Laboratorio_SQLite
//
//  Created by Rob on 27/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Scores.h"
@interface ApiBD : NSObject

@property (nonatomic) sqlite3 *scoreDB;
@property (nonatomic, strong) NSString * documentsDirectory;
@property(nonatomic, strong) NSString * databaseFilename;
@property(nonatomic, strong) NSString * databasePath;
@property(nonatomic, strong) NSString* status;

-(void) initWithDatabaseFilename:(NSString *)dbFilename;
-(BOOL) crearDB;
-(BOOL) addScore:(NSString*)name points:(int) points score:(int)score time:(NSString*)time wrongMoves:(int)wrongMoves;
-(BOOL) removeScore:(int) idScore;
-(NSMutableArray*) findScores;
+(ApiBD *) getSharedInstance;

@end
