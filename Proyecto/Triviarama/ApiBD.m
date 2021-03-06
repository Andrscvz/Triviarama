/*
 Archivo: TriviaramaViewController.h
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 11/Noviembre/2014
 Fecha de última actualización: 13/Novimebre/2014
 Descripción general: Api para accesos a base de datos
 
 Triviarama - Memorama que consiste en emparejar cada pregunta de trivia con su respuesta correspondiente.
 Copyright (C) 2014 - ITESM
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program. If not, see <http://www.gnu.org/licenses/>.
 
 Authors:
 
 ITESM representatives
 Ing. Martha Sordia Salinas <msordia@itesm.mx>
 Ing. Mario de la Fuente <mario.delafuente@itesm.mx>
 
 ITESM students
 Andrés Gerardo Cavazos Hernández – A01195067
 Roberto Carlos Rivera Martínez – A00618181
 Fernando Javier Garza Brambila – A01034753
 Marialicia Villarreal García – A00811095
 */

#import "ApiBD.h"

@implementation ApiBD

//Inicializa la base de datos de acuerdo a un path
-(void) initWithDatabaseFilename:(NSString *)dbFilename;{
    if(self){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        self.documentsDirectory =[paths objectAtIndex:0];
        self.databaseFilename = dbFilename;
        self.documentsDirectory= [paths objectAtIndex:0];
        self.databasePath=[[NSString alloc] initWithString:[self.documentsDirectory stringByAppendingString:dbFilename]];
    }
    
}

//Crea la base de datos, si ya existe, toma la existente
-(BOOL) crearDB{
    BOOL error;
    sqlite3 *scoreDB_local;
    self.status =@"OK";
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:self.databasePath]==NO) {
        const char *dbpath =[self.databasePath UTF8String];
        if (sqlite3_open(dbpath, &scoreDB_local) == SQLITE_OK) {
            char *errMsg;
            self.scoreDB = scoreDB_local;
            const char *sql_statement = "CREATE TABLE IF NOT EXISTS SCORES (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, POINTS INTEGER, SCORE INTEGER, TIME TEXT, WRONGMOVES INTEGER )";
            if (sqlite3_exec(self.scoreDB, sql_statement, NULL, NULL, &errMsg) != SQLITE_OK) {
                error=YES;
                self.status = @"Failed to create table";
                NSLog(@"crearDB: %s", sqlite3_errmsg(self.scoreDB));
            }
            return error;
        }
        else{
            error=YES;
            self.status=@"Failed to open/create database";
        }
    }
    if (sqlite3_open([self.databasePath UTF8String], &scoreDB_local)==SQLITE_OK) {
        self.scoreDB = scoreDB_local;
    }
    return error;
}

//Agrega un score a la base de datos
-(BOOL) addScore:(NSString*)name points:(int) points score:(int)score time:(NSString*)time wrongMoves:(int)wrongMoves{
    sqlite3_stmt *sql_statement;
    self.status=@"OK";
    NSString* insertSQL=[NSString stringWithFormat:@"INSERT INTO SCORES (name, POINTS, SCORE, TIME, WRONGMOVES) VALUES (\"%@\",\"%i\", \"%i\", \"%@\", \"%i\" )", name, points,score, time, wrongMoves ];
    const char *insert_statement = [insertSQL UTF8String];
    sqlite3_prepare_v2(self.scoreDB, insert_statement, -1, &sql_statement, NULL);
    NSLog(@"addProfile: %s", sqlite3_errmsg(self.scoreDB));
    
    if (sqlite3_step(sql_statement)== SQLITE_DONE) {
        self.status=@"Score added";
        sqlite3_finalize(sql_statement);
        return NO;
    }else{
        self.status=@"Failed to add score";
        sqlite3_finalize(sql_statement);
        return  YES;
    }
    return NO;
}

//remueve el score con el id especificado
-(BOOL) removeScore:(int)idScore{
    BOOL error = NO;
    sqlite3_stmt *sql_statement;
    NSString * removeSQL = [NSString stringWithFormat:@"DELETE FROM SCORES WHERE id=\"%i\"", idScore];
    const char *remove_statement = [removeSQL UTF8String];
    if (sqlite3_prepare_v2(self.scoreDB, remove_statement, -1, &sql_statement, NULL)== SQLITE_OK) {
        NSLog(@"removeProfile: %s", sqlite3_errmsg(self.scoreDB));
        if (sqlite3_step(sql_statement)== SQLITE_ROW) {
            self.status = @"Match found";
            
        }
        else{
            self.status=@"Match not found";
            error= YES;
        }
        sqlite3_finalize(sql_statement);
    }
    return error;
}

//regresa todos los scores que hay en la base de datos
-(NSMutableArray*) findScores{
    sqlite3_stmt *sql_statement;
    NSMutableArray *scores= [[NSMutableArray alloc] init];
    NSString*querySQL =[NSString stringWithFormat:@"SELECT * FROM SCORES ORDER BY SCORE DESC"];
    const char *query_statement = [querySQL UTF8String];
    if (sqlite3_prepare_v2(self.scoreDB, query_statement, -1, &sql_statement, NULL)== SQLITE_OK) {
        NSLog(@"findProfile: %s", sqlite3_errmsg(self.scoreDB));
        while(sqlite3_step(sql_statement)== SQLITE_ROW) {
            int idrow = sqlite3_column_int(sql_statement, 0);
            NSString * name= [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(sql_statement, 1)];
            int points = sqlite3_column_int(sql_statement, 2);
            int score = sqlite3_column_int(sql_statement, 3);
            NSString * time= [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(sql_statement, 4)];
            int wrongMoves = sqlite3_column_int(sql_statement, 5);
            self.status = @"match found";
            Scores * scoreP= [[Scores alloc] initScore:idrow name:name points:points score:score time:time wrongMoves:wrongMoves ];
            [scores addObject:scoreP];
        }
        sqlite3_finalize(sql_statement);
    }
    return scores;
}

//Crea la instancia de ApiBD, si ya existe toma la existente
+(ApiBD *) getSharedInstance{
    static ApiBD *_sharedInstance=nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ApiBD alloc]init];
        [_sharedInstance initWithDatabaseFilename:@"Triviarama.db"];
    });
    return _sharedInstance;
}

@end
