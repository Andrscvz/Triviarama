//
//  LoserViewController.h
//  Triviarama
//
//  Created by Rob on 08/11/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoserViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *wrongMovesLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) id dataOfScore;
- (IBAction)exit:(id)sender;
- (IBAction)playAgain:(id)sender;
@end
