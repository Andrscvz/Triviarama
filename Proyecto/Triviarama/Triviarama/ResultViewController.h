/*
 Archivo: FARMViewController.h
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 2/Noviembre/2014
 Fecha de última actualización: 13/Novimebre/2014
 Descripción general: Controlador que aparece cuando se gana el juego
 
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

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "Reachability.h"
#import "ApiBD.h"
#import "Scores.h"
@interface ResultViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *wrongMovesLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)playAgain:(id)sender;
- (IBAction)shareFacebook:(id)sender;
- (IBAction)shareTwitter:(id)sender;
- (IBAction)exit:(id)sender;
@property(strong, nonatomic) ApiBD * servicioBD;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) id dataOfScore;


@end
