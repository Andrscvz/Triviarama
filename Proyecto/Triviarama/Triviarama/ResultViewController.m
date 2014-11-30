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


#import "ResultViewController.h"



@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackground.jpg"]];
    self.pointsLabel.text = [self.dataOfScore valueForKey:@"points"];
    self.timeLabel.text = [self.dataOfScore valueForKey:@"time"];
    self.wrongMovesLabel.text = [self.dataOfScore valueForKey:@"wrongMoves"];
    self.scoreLabel.text = [self.dataOfScore valueForKey:@"score"];
    [self setServicioBD:[ApiBD getSharedInstance]];
    [self registrarNotificacion];
    [self.servicioBD crearDB];
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registrarNotificacion
{
    // singleton de la aplicacion actual
    UIApplication *app = [UIApplication sharedApplication];
    
    // registro en el centro de notificaciones de mi aplicación
    // cuando la aplicación entra al background se ejecuta el método guardar datos
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(insertScore)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:app];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) setDataOfScore:(id)dataOfScore
{
    _dataOfScore = dataOfScore;
}

//metodo que reacciona al hacer click en el boton play again
- (IBAction)playAgain:(id)sender {
    [self insertScore];
}
//Se muestra alerta de no acceso a internet

-(void) showInternetAlert{
    UIAlertView * alerta= [[UIAlertView alloc] initWithTitle:@"No Internet Access" message:@"Please connect to a WiFi network" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerta show];
}

//Se inserta un score si es mayor a cualquiera de los primeros 5
-(void) insertScore{
    if ([self.nameTextField.text isEqualToString:@""]) {
        return;
    }
    NSMutableArray * scores = [self.servicioBD findScores];
    if (scores.count <5) {
         [self.servicioBD addScore:self.nameTextField.text points:self.pointsLabel.text.intValue score:self.scoreLabel.text.intValue time:self.timeLabel.text wrongMoves:self.wrongMovesLabel.text.intValue];
        return;
    }
    if ([scores[scores.count-1] score] < self.scoreLabel.text.intValue ) {
        [self.servicioBD removeScore:[scores[scores.count-1] idScore]];
        [self.servicioBD addScore:self.nameTextField.text points:self.pointsLabel.text.intValue score:self.scoreLabel.text.intValue time:self.timeLabel.text wrongMoves:self.wrongMovesLabel.text.intValue];
    }
    
}

//Metodo para compartir en facebook
- (IBAction)shareFacebook:(id)sender {
    if (![Reachability connected]) {
        [self showInternetAlert];
        return;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebook= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebook setInitialText:[@"I'm a winner!! Final score =" stringByAppendingString:self.scoreLabel.text]];
        [facebook addImage:[UIImage imageNamed:@"Icon_TRVM_1024Retina.png"]];
        [self presentViewController:facebook animated:YES completion:nil];
    }
    else{
        UIAlertView *alerta= [[UIAlertView alloc] initWithTitle:@"Facebook Error" message:@"You may not have set up facebook service on your device or\n You may not connected to internet.\n Please check..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerta show];
    }
}

//Metodo para compartir en twitter
- (IBAction)shareTwitter:(id)sender {
    if (![Reachability connected]) {
        [self showInternetAlert];
        return;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitter= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:[@"I'm a winner!! Final score =" stringByAppendingString:self.scoreLabel.text]];
        [twitter addImage:[UIImage imageNamed:@"Icon_TRVM_1024Retina.png"]];
        [self presentViewController:twitter animated:YES completion:nil];
    }
    else{
        UIAlertView *alerta= [[UIAlertView alloc] initWithTitle:@"Twitter Error" message:@"You may not have set up twitter service on your device or\n You may not connected to internet.\n Please check..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerta show];
    }
}

//metodo que reacciona al hacer click en el boton exit
- (IBAction)exit:(id)sender {
    [self insertScore];
}
@end
