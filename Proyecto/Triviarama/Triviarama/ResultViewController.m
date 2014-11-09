//
//  ResultViewController.m
//  Triviarama
//
//  Created by Rob on 25/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ResultViewController.h"
#import "DataBaseManagement.h"


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
    [self.navigationItem setHidesBackButton:YES];
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

- (void) setDataOfScore:(id)dataOfScore
{
    _dataOfScore = dataOfScore;
}

- (IBAction)playAgain:(id)sender {
}

- (IBAction)shareFacebook:(id)sender {
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

- (IBAction)shareTwitter:(id)sender {
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

- (IBAction)exit:(id)sender {
}
@end
