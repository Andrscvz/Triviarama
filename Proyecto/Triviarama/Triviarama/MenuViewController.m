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
#import "GameViewController.h"

@interface MenuViewController (){
    NSArray * levels, * categories;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackground.jpg"]];
    levels=[[NSArray alloc] initWithObjects:@"Easy", @"Medium", @"Hard", nil];
    categories=[[NSArray alloc] initWithObjects:@"Animals", @"Books & Authors", @"Fashion", @"Food",@"History",@"Quotes", @"Science",@"Sports",@"Travel & Tourism", @"Movies", @"Word Origins", nil];
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
    self.labelCategory.text = @"Animals";
    self.labelLevel.text= @"Easy";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.levelsTableView ==tableView){
        self.labelLevel.text= [levels objectAtIndex:indexPath.row];
    }
    else{
        self.labelCategory.text= [categories objectAtIndex:indexPath.row];
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

/*- (IBAction)unWind:(UIStoryboardSegue*)segue{
 
}*/
//Se obtiene el id de la categoria de acuerdo a su nombre
- (NSString *)getIdOfCategory:(NSString *)categoryName {
    if ([categoryName isEqualToString:@"Animals"]) {
        return @"21";
    } else if ([categoryName isEqualToString:@"Books & Authors"]) {
        return @"197";
    } else if ([categoryName isEqualToString:@"Fashion"]) {
        return @"26";
    } else if ([categoryName isEqualToString:@"Food"]) {
        return @"49";
    } else if ([categoryName isEqualToString:@"History"]) {
        return @"114";
    } else if ([categoryName isEqualToString:@"Quotes"]) {
        return @"1420";
    } else if ([categoryName isEqualToString:@"Science"]) {
        return @"25";
    } else if ([categoryName isEqualToString:@"Sports"]) {
        return @"42";
    } else if ([categoryName isEqualToString:@"Travel & Tourism"]) {
        return @"369";
    } else if ([categoryName isEqualToString:@"Movies"]) {
        return @"309";
    } else if ([categoryName isEqualToString:@"Word Origins"]) {
        return @"223";
    } else {
        return @"-1";
    }
}


-(IBAction)unwind2:(UIStoryboardSegue *)segue{
    
}

//Se hace un segue a la pantalla de juego en caso de que se cuente con acceso a internet
- (IBAction)gameSegue:(id)sender {
    if ([Reachability connected]) {
        GameViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"game"];
        NSDictionary *dataOfMenuSelected = [[NSDictionary alloc] initWithObjectsAndKeys:self.labelLevel.text, @"level", self.labelCategory.text, @"category", [self getIdOfCategory:self.labelCategory.text], @"idCategory", nil];
        
        [myController setDataOfMenu:dataOfMenuSelected];
        [self.navigationController pushViewController: myController animated:YES];
    }
    else{
        [self showInternetAlert];
    }
    
}

// Se muestra alerta de no acceso a internet
-(void) showInternetAlert{
    UIAlertView * alerta= [[UIAlertView alloc] initWithTitle:@"No Internet Access" message:@"Please connect to a WiFi network" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alerta show];
}
@end
