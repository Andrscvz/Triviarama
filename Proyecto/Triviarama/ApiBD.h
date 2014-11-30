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
