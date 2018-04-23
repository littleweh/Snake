//
//  Snake.m
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ASSnake.h"

@interface ASSnake()
{
    NSUInteger bodyLength;
    NSUInteger addLengthNum;
}
@property (strong, atomic, readwrite) NSMutableArray <Coordinate *> * snakeBody;
@property (assign, atomic, readwrite) ASSnakeDirection direction;
@property (strong, atomic, readwrite) GameField* gameField;
@end

@implementation ASSnake

-(instancetype) initWithGameField: (GameField*) gameField {
        
    if (![gameField isKindOfClass:[GameField class]]) {
        return nil;
    }

    if (!gameField) {
        return nil;
    }

    if ([super init]) {
        self.direction = ASSnakeDirectionLeft;
        bodyLength = 2;
        addLengthNum = 2;

        NSAssert(gameField.width >= 4 , @"must be larger than 4");
        NSAssert(gameField.height >= 4 , @"must be larger than 4");
        
        if (gameField.width < 4 || gameField.height < 4) {
            return NULL;
        }

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
        case ASSnakeDirectionLeft:
            newHead.x = (oldHead.x-1) % self.gameField.width;
            if (newHead.x < 0) newHead.x += self.gameField.width;
            break;
        case ASSnakeDirectionRight:
            newHead.x = (oldHead.x+1) % self.gameField.width;
            if (newHead.x < 0) newHead.x += self.gameField.width;
            break;
        case ASSnakeDirectionUp:
            newHead.y = (oldHead.y-1) % self.gameField.height;
            if (newHead.y < 0) newHead.y += self.gameField.height;
            break;
        case ASSnakeDirectionDown:
            newHead.y = (oldHead.y+1) % self.gameField.height;
            if (newHead.y < 0) newHead.y += self.gameField.height;
            break;
    }
    [self snakeBodyEnqueueWithPoint:newHead];
    [self snakeBodyDequeue];
}

-(void) changeDirection: (ASSnakeDirection) direction {
    
    NSAssert(direction == ASSnakeDirectionUp || direction == ASSnakeDirectionDown || direction == ASSnakeDirectionLeft || direction == ASSnakeDirectionRight, @"Must be up, down, left, right");

    if (direction == ASSnakeDirectionLeft || direction == ASSnakeDirectionRight) {
        if (self.direction == ASSnakeDirectionUp || self.direction == ASSnakeDirectionDown) {
            [self setDirection:direction];
        }
    } else if (direction == ASSnakeDirectionUp || direction == ASSnakeDirectionDown) {
        if (self.direction == ASSnakeDirectionLeft || self.direction == ASSnakeDirectionRight) {
            [self setDirection:direction];
        }
    }
}

-(void) addBodyLengthNumber: (NSUInteger) number {
    
    NSAssert(number > 0, @"body lenth to be added should be larger than 0");
    NSAssert(number < MIN(self.gameField.width, self.gameField.height), @"body length to be added shoub not be larger than gameField width/height");
    
    NSRange range = NSMakeRange(0, 2);
    NSArray* lastTwoNodes = [[self.snakeBody subarrayWithRange:range] mutableCopy];
    Coordinate* lastNode = lastTwoNodes[0];
    Coordinate* previousNode = lastTwoNodes[1];
    NSInteger dx = lastNode.x - previousNode.x;
    NSInteger dy = lastNode.y - previousNode.y;

    for (int i = 0; i < number; i++) {
        Coordinate* newTail = [self.snakeBody.firstObject copy];
        newTail.x = (newTail.x + dx) % self.gameField.width;
        if ( newTail.x < 0) { newTail.x += self.gameField.width; }
        newTail.y = (newTail.y + dy ) % self.gameField.height;
        if (newTail.y < 0 ) { newTail.y += self.gameField.height; }
        [self.snakeBody insertObject:newTail atIndex:0];
    }
}

-(BOOL) isHeadHitBody {
    Coordinate* snakeHead = [self.snakeBody.lastObject copy];
    NSMutableArray* snakeWithoutHead = [self.snakeBody mutableCopy];
    [snakeWithoutHead removeLastObject];
    return [snakeWithoutHead containsObject:snakeHead];
}

-(BOOL) isHeadHitPoint: (Coordinate*) point {
    
    NSAssert(point.x >=0 && point.y >= 0, @"point x: %ld, y: %ld should be larger than or equal to 0");
    NSAssert(point.x <self.gameField.width && point.y < self.gameField.height, @"point x: %ld, y: %ld should be less than game field width/ height");

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
