//
//  Snake.h
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

typedef enum NSUInteger {
    left,
    right,
    up,
    down
} Direction;

@interface Snake : NSObject
@property (strong, atomic, readwrite) NSMutableArray* snakeBody;
@property (assign, atomic, readwrite) Direction direction;

-(instancetype) initWithHeadPositionPoint: (Coordinate*) point;
-(void) moveOneStep;
-(void) addBodyLengthNumber: (NSUInteger) number;
-(BOOL) isHeadHitBody;
-(BOOL) isHeadHitPoint: (Coordinate*) point;
-(void) changeDirection: (Direction) direction;
@end


