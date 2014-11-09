//
//  Scores.h
//  Triviarama
//
//  Created by Rob on 25/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface Scores : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * id;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSDecimalNumber * points;
@property (nonatomic, retain) NSDecimalNumber * score;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSDecimalNumber * wrongMoves;

@end
