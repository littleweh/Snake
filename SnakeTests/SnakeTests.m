//
//  SnakeTests.m
//  SnakeTests
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Snake.h"

@interface SnakeTests : XCTestCase

@end

//@interface Snake ()
//@property (strong, atomic, readwrite) NSMutableArray* snakeBody;
//@end

@implementation SnakeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddTailOnLeftEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc] initWithGameField:gameField];
    [snake changeDirection:up];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:2]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:3 coordinateY:2]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:3 coordinateY:1]];
    snake.snakeBody = body;
    // arrange

    [snake addBodyLengthNumber:1];
    // action

    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 1 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
}

- (void)testAddTailORightnEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc] initWithGameField:gameField];
    [snake changeDirection:up];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:3 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];

    snake.snakeBody = body;
    // arrange

    [snake addBodyLengthNumber:1];
    // action

    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 2 && tail.y == 1, @"tail x %d, y %d", tail.x, tail.y);
}

- (void)testAddTailCenter {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc] initWithGameField:gameField];
    [snake changeDirection:up];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:1 coordinateY:1]];
    snake.snakeBody = body;
    // arrange

    [snake addBodyLengthNumber:1];
    // action

    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 3 && tail.y == 1, @"tail x %d, y %d", tail.x, tail.y);
}


@end
