//
//  GameViewController.m
//  Triviarama
//
//  Created by Rob on 22/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "GameViewController.h"


@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ipadBackgroundPantallaInicio.jpg"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
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
