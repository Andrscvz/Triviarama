/*
 Archivo: GameViewController.h
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 20/Octubre/2014
 Fecha de última actualización: 26/Noviembre/2014
 Descripción general: Controlador que maneja los elementos de la vista correspondiente al juego de la aplicacion
 
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
#import "Card.h"
#import <AVFoundation/AVFoundation.h>

@interface GameViewController : UIViewController

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@property (strong, nonatomic) IBOutlet UIView *cardView1;
@property (strong, nonatomic) IBOutlet UIView *cardView2;
@property (strong, nonatomic) IBOutlet UIView *cardView3;
@property (strong, nonatomic) IBOutlet UIView *cardView4;
@property (strong, nonatomic) IBOutlet UIView *cardView5;
@property (strong, nonatomic) IBOutlet UIView *cardView6;
@property (strong, nonatomic) IBOutlet UIView *cardView7;
@property (strong, nonatomic) IBOutlet UIView *cardView8;
@property (strong, nonatomic) IBOutlet UIView *cardView9;
@property (strong, nonatomic) IBOutlet UIView *cardView10;
@property (strong, nonatomic) IBOutlet UIView *cardView11;
@property (strong, nonatomic) IBOutlet UIView *cardView12;
@property (strong, nonatomic) IBOutlet UIView *cardView13;
@property (strong, nonatomic) IBOutlet UIView *cardView14;
@property (strong, nonatomic) IBOutlet UIView *cardView15;
@property (strong, nonatomic) IBOutlet UIView *cardView16;
@property (strong, nonatomic) IBOutlet UIView *cardView17;
@property (strong, nonatomic) IBOutlet UIView *cardView18;
@property (strong, nonatomic) IBOutlet UIView *cardView19;
@property (strong, nonatomic) IBOutlet UIView *cardView20;
- (IBAction)tapCard1:(id)sender;
- (IBAction)tapCard2:(id)sender;
- (IBAction)tapCard3:(id)sender;
- (IBAction)tapCard4:(id)sender;
- (IBAction)tapCard5:(id)sender;
- (IBAction)tapCard6:(id)sender;
- (IBAction)tapCard7:(id)sender;
- (IBAction)tapCard8:(id)sender;
- (IBAction)tapCard9:(id)sender;
- (IBAction)tapCard10:(id)sender;
- (IBAction)tapCard11:(id)sender;
- (IBAction)tapCard12:(id)sender;
- (IBAction)tapCard13:(id)sender;
- (IBAction)tapCard14:(id)sender;
- (IBAction)tapCard15:(id)sender;
- (IBAction)tapCard16:(id)sender;
- (IBAction)tapCard17:(id)sender;
- (IBAction)tapCard18:(id)sender;
- (IBAction)tapCard19:(id)sender;
- (IBAction)tapCard20:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *wrongMovesLabel;

@property (strong, nonatomic) id dataOfMenu;
@property (strong, nonatomic) IBOutlet UIImageView *categoryImageView;


//Properties used to get json object from web service
@property (strong,nonatomic) NSURLConnection *connection;
@property (strong,nonatomic) NSMutableData *responseData;
@property (strong,nonatomic) UIActivityIndicatorView *loading;

//Property of the card
@property Card *myCard;

@end
