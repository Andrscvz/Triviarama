//
//  Scores.h
//  Triviarama
//
//  Created by Rob on 25/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface Scores : NSObject

@property (nonatomic, assign) int idScore;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) int  points;
@property (nonatomic, assign) int  score;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, assign) int  wrongMoves;

-(id) initScore:(int) idScore name:(NSString *)name points:(int)points score:(int)scores time:(NSString*)time wrongMoves:(int)wrongMoves;
@end
