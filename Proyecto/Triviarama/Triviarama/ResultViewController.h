//
//  ResultViewController.h
//  Triviarama
//
//  Created by Rob on 25/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ResultViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *wrongMovesLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
- (IBAction)playAgain:(id)sender;
- (IBAction)shareFacebook:(id)sender;
- (IBAction)shareTwitter:(id)sender;
- (IBAction)exit:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) id dataOfScore;


@end
