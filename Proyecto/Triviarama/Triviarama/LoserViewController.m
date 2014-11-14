//
//  LoserViewController.m
//  Triviarama
//
//  Created by Rob on 08/11/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

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
