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

@interface Snake ()
@property (strong, atomic, readwrite) NSMutableArray* snakeBody;
@property (assign, atomic, readwrite) Direction direction;


@end

@implementation SnakeTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void) testMoveOneStepBaseCase {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 1 && head.y == 2, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
    
}

- (void) testMoveOneStepWithDifferentDirection {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [snake.snakeBody insertObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:2] atIndex:0];
    [snake changeDirection:up];
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *middle = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 2 && head.y == 1, @"head x %d, y %d", head.x, head.y);
    XCTAssert(middle.x == 2 && middle.y == 2, @"middle x %d, y %d", middle.x, middle.y);
    XCTAssert(tail.x == 3 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
}

-(void) testMoveOneStepOnEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:1 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:1]];
    snake.snakeBody = body;
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 4 && head.y == 1, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 0 && tail.y == 1, @"tail x %d, y %d", tail.x, tail.y);
}

-(void) testMoveOneStepWithDifferentDirectionAndOnEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:3 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:3 coordinateY:0]];

    snake.snakeBody = body;
    [snake changeDirection:up];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *body1 = snake.snakeBody[2];
    Coordinate *body2 = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 3 && head.y == 4, @"head x %d, y %d", head.x, head.y);
    XCTAssert(body1.x == 3 && body1.y == 0, @"body1 x %d, y %d", body1.x, body1.y);
    XCTAssert(body2.x == 3 && body2.y == 1, @"body2 x %d, y %d", body2.x, body2.y);
    XCTAssert(tail.x == 4 && tail.y == 1, @"tail x %d, y %d", tail.x, tail.y);
    
}

-(void) testMoveOneStepOnCorner {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    
    snake.snakeBody = body;
    [snake changeDirection:down];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *body1 = snake.snakeBody[2];
    Coordinate *body2 = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 0 && head.y == 1, @"head x %d, y %d", head.x, head.y);
    XCTAssert(body1.x == 0 && body1.y == 0, @"body1 x %d, y %d", body1.x, body1.y);
    XCTAssert(body2.x == 4 && body2.y == 0, @"body2 x %d, y %d", body2.x, body2.y);
    XCTAssert(tail.x == 4 && tail.y == 4, @"tail x %d, y %d", tail.x, tail.y);
    
}

-(void) testChangeDirectionToUp {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    [snake changeDirection:up];
    XCTAssertEqual(snake.direction, up, @"snake direction: %u", snake.direction);
    
    [snake setDirection:right];
    [snake changeDirection:up];
    XCTAssertEqual(snake.direction, up, @"snake direction: %u", snake.direction);
    
    [snake setDirection:down];
    [snake changeDirection:up];
    XCTAssertEqual(snake.direction, down, @"snake direction: %u", snake.direction);
    
    [snake setDirection:up];
    [snake changeDirection:up];
    XCTAssertEqual(snake.direction, up, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionToDown {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    [snake changeDirection:down];
    XCTAssertEqual(snake.direction, down, @"snake direction: %u", snake.direction);
    
    [snake setDirection:right];
    [snake changeDirection:down];
    XCTAssertEqual(snake.direction, down, @"snake direction: %u", snake.direction);
    
    [snake setDirection:down];
    [snake changeDirection:down];
    XCTAssertEqual(snake.direction, down, @"snake direction: %u", snake.direction);
    
    [snake setDirection:up];
    [snake changeDirection:down];
    XCTAssertEqual(snake.direction, up, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionToLeft {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    [snake changeDirection:left];
    XCTAssertEqual(snake.direction, left, @"snake direction: %u", snake.direction);
    
    [snake setDirection:right];
    [snake changeDirection:left];
    XCTAssertEqual(snake.direction, right, @"snake direction: %u", snake.direction);
    
    [snake setDirection:down];
    [snake changeDirection:left];
    XCTAssertEqual(snake.direction, left, @"snake direction: %u", snake.direction);
    
    [snake setDirection:up];
    [snake changeDirection:left];
    XCTAssertEqual(snake.direction, left, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionToRight {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    [snake changeDirection:right];
    XCTAssertEqual(snake.direction, left, @"snake direction: %u", snake.direction);
    
    [snake setDirection:right];
    [snake changeDirection:right];
    XCTAssertEqual(snake.direction, right, @"snake direction: %u", snake.direction);
    
    [snake setDirection:down];
    [snake changeDirection:right];
    XCTAssertEqual(snake.direction, right, @"snake direction: %u", snake.direction);
    
    [snake setDirection:up];
    [snake changeDirection:right];
    XCTAssertEqual(snake.direction, right, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionInput {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    Snake *snake = [[Snake alloc]initWithGameField:gameField];
    [snake changeDirection:14];
    
    XCTAssertNil(@"");
    
    
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

- (void)testAddTailOnRightEdge {
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
