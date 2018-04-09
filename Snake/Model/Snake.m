//
//  Snake.m
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "Snake.h"

@interface Snake()
{
    NSUInteger bodyLength;
    NSUInteger addLengthNum;
}
@end

@implementation Snake

-(id) copyWithZone:(NSZone *)zone {
    Snake *snakeCopy = [[Snake allocWithZone:zone] init];
    if (snakeCopy) {
        [snakeCopy setDirection:self.direction];
        [snakeCopy setGameField:self.gameField];
        [snakeCopy setSnakeBody:self.snakeBody];
    }
    return snakeCopy;
}

-(instancetype) initWithGameField: (GameField*) gameField {
    if ([super init]) {
        self.direction = left;
        bodyLength = 2;
        addLengthNum = 2;

        self.gameField = gameField;
        NSInteger centerX = gameField.width / 2;
        NSInteger centerY = gameField.height / 2;

        NSMutableArray* body = [[NSMutableArray alloc] init];
        Coordinate* head = [[Coordinate alloc] initWithCoordinateX:centerX
                                                       coordinateY:centerY
                            ];
        [body insertObject:head atIndex:0];
        
        for (int i = 1; i < bodyLength; i++) {
            Coordinate *bodyPoint = [[Coordinate alloc]
                                     initWithCoordinateX: (head.x+i) % gameField.width
                                     coordinateY:head.y
                                     ];
            [body insertObject:bodyPoint atIndex:0];
        }
        
        [self setSnakeBody:body];
    }
    return self;
}
-(void) moveOneStep {
    Coordinate* oldHead = self.snakeBody.lastObject;
    Coordinate* newHead = [oldHead copy];
    switch (self.direction) {
        case left:
            newHead.x = (oldHead.x-1) % self.gameField.width;
            if (newHead.x < 0) newHead.x += self.gameField.width;
            break;
        case right:
            newHead.x = (oldHead.x+1) % self.gameField.width;
            if (newHead.x < 0) newHead.x += self.gameField.width;
            break;
        case up:
            newHead.y = (oldHead.y-1) % self.gameField.height;
            if (newHead.y < 0) newHead.y += self.gameField.height;
            break;
        case down:
            newHead.y = (oldHead.y+1) % self.gameField.height;
            if (newHead.y < 0) newHead.y += self.gameField.height;
            break;
    }
    [self snakeBodyEnqueueWithPoint:newHead];
    [self snakeBodyDequeue];
}

-(void) changeDirection: (Direction) direction {
    if (direction == left || direction == right) {
        if (self.direction == up || self.direction == down) {
            [self setDirection:direction];
        }
    } else if (direction == up || direction == down) {
        if (self.direction == left || self.direction == right) {
            [self setDirection:direction];
        }
    }
}

-(void) addBodyLengthNumber: (NSUInteger) number {
    NSRange range = NSMakeRange(0, 2);
    NSArray* lastTwoNodes = [[self.snakeBody subarrayWithRange:range] mutableCopy];
    Coordinate* lastNode = lastTwoNodes[0];
    Coordinate* previousNode = lastTwoNodes[1];
    NSUInteger dx = lastNode.x - previousNode.x;
    NSUInteger dy = lastNode.y - previousNode.y;

    for (int i = 0; i < number; i++) {
        Coordinate* newTail = [self.snakeBody.firstObject copy];
        newTail.x += dx;
        newTail.y += dy;
        [self.snakeBody insertObject:newTail atIndex:0];
    }
}

-(BOOL) isHeadHitBody {
    Coordinate* snakeHead = [self.snakeBody.lastObject copy];
    NSRange range = NSMakeRange(0, self.snakeBody.count-2);
    NSArray* snakeWithouHead = [self.snakeBody subarrayWithRange:range];
    return [snakeWithouHead containsObject:snakeHead];
}

-(BOOL) isHeadHitPoint: (Coordinate*) point {
    Coordinate* snakeHead = [self.snakeBody.lastObject copy];
    return [snakeHead isEqual:point];    
}

-(void) snakeBodyEnqueueWithPoint: (Coordinate*) point {
    [self.snakeBody insertObject:point atIndex:self.snakeBody.count];
}
-(void) snakeBodyDequeue {
    [self.snakeBody removeObjectAtIndex:0];
}

@end
