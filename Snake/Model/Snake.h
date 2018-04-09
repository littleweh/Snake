//
//  Snake.h
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "GameField.h"

typedef enum NSUInteger {
    up = 0,
    right = 1,
    down = 2,
    left = 3
} Direction;

@interface Snake : NSObject <NSCopying>
//@property (strong, atomic, readonly) NSMutableArray <Coordinate *> * snakeBody;
//@property (assign, atomic, readonly) Direction direction;
//@property (strong, atomic, readonly) GameField* gameField;
@property (strong, atomic, readwrite) NSMutableArray <Coordinate *> * snakeBody;
@property (assign, atomic, readwrite) Direction direction;
@property (strong, atomic, readwrite) GameField* gameField;

-(instancetype) initWithGameField: (GameField*) gameField;
-(void) moveOneStep;
-(void) changeDirection: (Direction) direction;
-(void) addBodyLengthNumber: (NSUInteger) number;
-(BOOL) isHeadHitBody;
-(BOOL) isHeadHitPoint: (Coordinate*) point;
@end


