/*
 Archivo: MenuViewController.m
 Proyecto: Triviarama
 Autor(es): FARM
 Fecha de creación: 20/Octubre/2014
 Fecha de última actualización: 23/Octubre/2014
 Descripción general: Controlador que maneja los elementos de la vista correspondiente al menu de la aplicacion
 
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

#import "MenuViewController.h"

@interface MenuViewController (){
    NSArray * levels, * categories;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackground.jpg"]];
    levels=[[NSArray alloc] initWithObjects:@"Easy", @"Medium", @"Hard", nil];
    categories=[[NSArray alloc] initWithObjects:@"Animals", @"Books & Authors", @"Fashion", @"Food",@"History",@"Quotes", @"Science",@"Sports",@"Travel & Tourism", @"The Movies", @"Word Origins", nil];
    self.levelsTableView.delegate = self;
    self.levelsTableView.dataSource = self;
    self.CategoriesTableView.dataSource = self;
    self.CategoriesTableView.delegate = self;
    self.levelsTableView.backgroundColor = [UIColor clearColor];
    self.levelsTableView.opaque= NO;
    self.levelsTableView.backgroundView= nil;
    self.CategoriesTableView.backgroundColor = [UIColor clearColor];
    self.CategoriesTableView.opaque= NO;
    self.CategoriesTableView.backgroundView= nil;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

*/
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if(self.levelsTableView ==tableView){
        cell= [tableView dequeueReusableCellWithIdentifier:@"level" forIndexPath:indexPath];
        cell.textLabel.text= levels[indexPath.row];
    }
    else{
        cell= [tableView dequeueReusableCellWithIdentifier:@"category" forIndexPath:indexPath];
        cell.textLabel.text= categories[indexPath.row];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.opaque= NO;
    cell.backgroundView=nil;
    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.levelsTableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
    [self.CategoriesTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.levelsTableView ==tableView){
        self.labelNivel.text= [levels objectAtIndex:indexPath.row];
    }
    else{
        self.labelCategoria.text= [categories objectAtIndex:indexPath.row];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    if(self.levelsTableView==tableView){
        return [levels count];}
    return [categories count];
}

@end
