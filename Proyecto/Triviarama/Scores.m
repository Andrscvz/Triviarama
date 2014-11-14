//
//  Scores.m
//  Triviarama
//
//  Created by Rob on 25/10/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "Scores.h"

@implementation Scores
-(id) initScore:(int)idScore name:(NSString *)name points:(int)points score:(int)scores time:(NSString *)time wrongMoves:(int)wrongMoves{
    self = [super init];
    _name= name;
    _points= points;
    _score= scores;
    _time= time;
    _wrongMoves= wrongMoves;
    _idScore= idScore;
    return self;
}


@end
