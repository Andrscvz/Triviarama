//
//  MenuViewController.h
//  Triviarama
//
//  Created by Rob on 22/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *levelsTableView;
@property (strong, nonatomic) IBOutlet UITableView *CategoriesTableView;

@property (strong, nonatomic) IBOutlet UILabel *labelNivel;
@property (strong, nonatomic) IBOutlet UILabel *labelCategoria;

@end
