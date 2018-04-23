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
    ASSnakeDirectionUp = 0,
    ASSnakeDirectionRight = 1,
    ASSnakeDirectionDown = 2,
    ASSnakeDirectionLeft = 3
} ASSnakeDirection;

@interface ASSnake : NSObject
@property (strong, nonatomic, readonly) NSMutableArray <Coordinate *> * snakeBody;
@property (assign, nonatomic, readonly) ASSnakeDirection direction;
@property (strong, nonatomic, readonly) GameField* gameField;

-(instancetype) initWithGameField: (GameField*) gameField;
-(void) moveOneStep;
-(void) changeDirection: (ASSnakeDirection) direction;
-(void) addBodyLengthNumber: (NSUInteger) number;
-(BOOL) isHeadHitBody;
-(BOOL) isHeadHitPoint: (Coordinate*) point;
@end


