/*
 Archivo: ScoresViewController.m
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 20/Octubre/2014
 Fecha de última actualización: 23/Octubre/2014
 Descripción general: Controlador que maneja los elementos de la vista correspondiente a los scores de la aplicacion
 
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

#import "ScoresViewController.h"
#import "ScoreTableViewCell.h"
#import "DataBaseManagement.h"
#import "Scores.h"

@interface ScoresViewController (){
    NSMutableArray *scoreList;
    NSMutableArray *scores;
}

@end

@implementation ScoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scoresTableView.dataSource = self;
    self.scoresTableView.delegate = self;
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackground.jpg"]];
    // Do any additional setup after loading the view.
    self.scoresTableView.backgroundColor = [UIColor clearColor];
    self.scoresTableView.opaque= NO;
    self.scoresTableView.backgroundView= nil;
    
    if(!scoreList){
        scoreList = [[NSMutableArray alloc] init];
    }
    
    DataBaseManagement *serv = [DataBaseManagement instance];
    [serv loadScore];
    
    scores = [serv scoreList];
    
    //Sort
    if (scores==NULL) {
        [self sortScores];
    }

    
}

-(void) sortScores{
    Scores *temp, *swap;
    int minimum=0;
    for (int i=0; i<[scores count]; i++) {
        temp=scores[i];
        for (int j=i; i<[scores count]; j++) {
            if ([temp valueForKey:@"score"]>[scores[j] valueForKey:@"score"]) {
                temp=scores[j];
                minimum=j;
            }
        }
        swap=scores[i];
        scores[i]=temp;
        scores[minimum]=swap;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScoreTableViewCell *cell;
    cell= [tableView dequeueReusableCellWithIdentifier:@"score" forIndexPath:indexPath];
    cell.placeLabel.text =@"1.";
    cell.nameLabel.text=@"Roberto Rivera";
    cell.pointsLabel.text=@"";
    cell.backgroundColor=[UIColor clearColor];
    cell.opaque= NO;
    cell.backgroundView=nil;
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
