//
//  CustomNavigationController.m
//  Triviarama
//
//  Created by Rob on 23/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate;
{
    if([self.topViewController.title isEqualToString:@"game"]){
        if ([[UIApplication sharedApplication] statusBarOrientation]== UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation]== UIInterfaceOrientationLandscapeRight) {
            return YES;
        }
        return NO;
    }
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    if([self.topViewController.title isEqualToString:@"game"]){
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
    
}

-(UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    if([self.topViewController.title isEqualToString:@"game"]){
        return UIInterfaceOrientationPortrait;
    }
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait;
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
