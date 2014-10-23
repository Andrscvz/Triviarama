//
//  MenuViewController.m
//  Triviarama
//
//  Created by Rob on 22/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController (){
    NSArray * levels, * categories;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackgroundPantallaInicio.jpg"]];
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
