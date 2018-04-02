//
//  Snake.m
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "Snake.h"

@interface Snake(){
    NSUInteger bodyLength;
    NSUInteger addLengthNum;
}
@end

@implementation Snake
-(instancetype) initWithHeadPositionPoint: (Coordinate*) point;{
    if ([super init]) {
        self.direction = left;
        bodyLength = 2;
        addLengthNum = 2;

        NSMutableArray* body = [[NSMutableArray alloc] init];
        [body insertObject:point atIndex:0];
        Coordinate* secondPoint = [[Coordinate alloc] initWithCoordinateX:point.x+1 coordinateY:point.y];
        [body insertObject:secondPoint atIndex:0];
        
        [self setSnakeBody:body];
    }
    return self;
}
-(void) moveOneStep {
    Coordinate* oldHead = self.snakeBody.lastObject;
    // ToDo: errorhandling: check oldHead is not nil
    Coordinate* newHead = [oldHead copy];
    switch (self.direction) {
        case left:
            newHead.x--;
            break;
        case right:
            newHead.x++;
            break;
        case up:
            newHead.y--;
            break;
        case down:
            newHead.y++;
            break;
        default:
            NSLog(@"no direction set");
            break;
    }
    [self snakeBodyEnqueueWithPoint:newHead];
    [self snakeBodyDequeue];
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

-(void) snakeBodyEnqueueWithPoint: (Coordinate*) point {
    [self.snakeBody insertObject:point atIndex:self.snakeBody.count];
}
-(void) snakeBodyDequeue {
    [self.snakeBody removeObjectAtIndex:0];
}

@end
