/*
 Archivo: FARMViewController.h
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 2/Noviembre/2014
 Fecha de última actualización: 13/Novimebre/2014
 Descripción general: Controlador que aparece cuando se pierde el juego
 
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

#import "LoserViewController.h"

@interface LoserViewController ()

@end

@implementation LoserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackground.jpg"]];
    self.pointsLabel.text = [self.dataOfScore valueForKey:@"points"];
    self.timeLabel.text = [self.dataOfScore valueForKey:@"time"];
    self.wrongMovesLabel.text = [self.dataOfScore valueForKey:@"wrongMoves"];
    self.scoreLabel.text = [self.dataOfScore valueForKey:@"score"];
    [self.navigationItem setHidesBackButton:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// se obtienen datos de la variable dataOfScore
- (void) setDataOfScore:(id)dataOfScore
{
    _dataOfScore = dataOfScore;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)exit:(id)sender {
}
- (IBAction)playAgain:(id)sender {
}
@end
