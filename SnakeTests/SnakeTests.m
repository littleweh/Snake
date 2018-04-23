//
//  SnakeTests.m
//  SnakeTests
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ASSnake.h"

@interface SnakeTests : XCTestCase
@property (strong, nonatomic, readwrite) GameField* myGameField;
@property (strong, nonatomic, readwrite) ASSnake* mySnake;
@end

@interface ASSnake ()
@property (strong, atomic, readwrite) NSMutableArray* snakeBody;
@property (assign, atomic, readwrite) ASSnakeDirection direction;


@end

@implementation SnakeTests

- (void)setUp {
    [super setUp];
    self.myGameField = [[GameField alloc]initWithWidth:5 Height:5];
    self.mySnake = [[ASSnake alloc]initWithGameField:self.myGameField];
    
}

- (void)tearDown {
    [super tearDown];
    self.myGameField = nil;
    self.mySnake = nil;
}

// MARK: initWithGameField:
-(void) testInitWithGameFieldNotExist {
    ASSnake* snake = [[ASSnake alloc]initWithGameField:nil];
    XCTAssert(snake == nil, @"initWithGameField: with no gameField input -failed");
}

-(void) testInitWithGameFieldNotGameFieldClass {
    ASSnake* snake = [[ASSnake alloc]initWithGameField: self.mySnake];
    XCTAssert(snake == nil, @"initWithGameField: with input not GameField class -failed");
}

-(void) testInitWithGameField {
    ASSnake* snake = [[ASSnake alloc]initWithGameField: self.myGameField];
    XCTAssert([snake isKindOfClass:[ASSnake class]], @"snake init return Snake");
    XCTAssert(snake.direction == ASSnakeDirectionLeft, @"snake init test, direction");
    XCTAssert(snake.snakeBody.count == 2, @"snake init test, body length");
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == self.myGameField.width / 2 && head.y == self.myGameField.height / 2, @"head x: %d, y: %d, gameField center x: %d, y: %d", head.x, head.y, self.myGameField.width / 2, self.myGameField.height / 2);
    
}

// MARK: moveOneStep

// base cases: up, down, left, right
- (void) testMoveOneStepToLeft {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 1 && head.y == 2, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
    
}

- (void) testMoveOneStepToRight {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:1 coordinateY:2]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:2]];
    snake.snakeBody = body;
    
    [snake setDirection:ASSnakeDirectionRight];
    [snake moveOneStep];

    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 3 && head.y == 2, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
}

- (void) testMoveOneStepToUp {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:2 coordinateY:3]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:2]];
    snake.snakeBody = body;
    
    [snake setDirection:ASSnakeDirectionUp];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 2 && head.y == 1, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
}

- (void) testMoveOneStepToDown {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:2 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:2]];
    snake.snakeBody = body;
    
    [snake setDirection:ASSnakeDirectionDown];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 2 && head.y == 3, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
}

// Extreme case: On Edge

-(void) testMoveOneStepOnLeftEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
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

-(void) testMoveOneStepOnRightEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:3 coordinateY:2]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:2]];
    snake.snakeBody = body;
    
    [snake setDirection:ASSnakeDirectionRight];
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 0 && head.y == 2, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 4 && tail.y == 2, @"tail x %d, y %d", tail.x, tail.y);
}

-(void) testMoveOneStepOnUpEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:0]];
    snake.snakeBody = body;
    
    [snake setDirection:ASSnakeDirectionUp];
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 2 && head.y == 4, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 0, @"tail x %d, y %d", tail.x, tail.y);
}

-(void) testMoveOneStepOnDownEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:3]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:4]];
    snake.snakeBody = body;
    
    [snake setDirection:ASSnakeDirectionDown];
    [snake moveOneStep];
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 2 && head.y == 0, @"head x %d, y %d", head.x, head.y);
    XCTAssert(tail.x == 2 && tail.y == 4, @"tail x %d, y %d", tail.x, tail.y);
}

// Extreme Case: On Corner

-(void) testMoveOneStepOnCornerMoveUp {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    
    snake.snakeBody = body;
    [snake setDirection:ASSnakeDirectionUp];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *body1 = snake.snakeBody[2];
    Coordinate *body2 = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 0 && head.y == 4, @"head x %d, y %d", head.x, head.y);
    XCTAssert(body1.x == 0 && body1.y == 0, @"body1 x %d, y %d", body1.x, body1.y);
    XCTAssert(body2.x == 4 && body2.y == 0, @"body2 x %d, y %d", body2.x, body2.y);
    XCTAssert(tail.x == 4 && tail.y == 4, @"tail x %d, y %d", tail.x, tail.y);
    
}

-(void) testMoveOneStepOnCornerMoveLeft {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    
    snake.snakeBody = body;
    [snake setDirection:ASSnakeDirectionLeft];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *body1 = snake.snakeBody[2];
    Coordinate *body2 = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 4 && head.y == 0, @"head x %d, y %d", head.x, head.y);
    XCTAssert(body1.x == 0 && body1.y == 0, @"body1 x %d, y %d", body1.x, body1.y);
    XCTAssert(body2.x == 0 && body2.y == 4, @"body2 x %d, y %d", body2.x, body2.y);
    XCTAssert(tail.x == 4 && tail.y == 4, @"tail x %d, y %d", tail.x, tail.y);
    
}

-(void) testMoveOneStepOnCornerMoveRight {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:4]];
    
    snake.snakeBody = body;
    [snake setDirection:ASSnakeDirectionRight];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *body1 = snake.snakeBody[2];
    Coordinate *body2 = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 0 && head.y == 4, @"head x %d, y %d", head.x, head.y);
    XCTAssert(body1.x == 4 && body1.y == 4, @"body1 x %d, y %d", body1.x, body1.y);
    XCTAssert(body2.x == 4 && body2.y == 0, @"body2 x %d, y %d", body2.x, body2.y);
    XCTAssert(tail.x == 0 && tail.y == 0, @"tail x %d, y %d", tail.x, tail.y);
    
}

-(void) testMoveOneStepOnCornerMoveDown {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:4]];
    
    snake.snakeBody = body;
    [snake setDirection:ASSnakeDirectionDown];
    [snake moveOneStep];
    
    Coordinate *head = snake.snakeBody.lastObject;
    Coordinate *body1 = snake.snakeBody[2];
    Coordinate *body2 = snake.snakeBody[1];
    Coordinate *tail = snake.snakeBody.firstObject;
    
    XCTAssert(head.x == 0 && head.y == 0, @"head x %d, y %d", head.x, head.y);
    XCTAssert(body1.x == 0 && body1.y == 4, @"body1 x %d, y %d", body1.x, body1.y);
    XCTAssert(body2.x == 4 && body2.y == 4, @"body2 x %d, y %d", body2.x, body2.y);
    XCTAssert(tail.x == 4 && tail.y == 0, @"tail x %d, y %d", tail.x, tail.y);
    
}

// MARK: changeDirection:

// ToDo: invalid input

-(void) testChangeDirectionToUp {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionUp];
    XCTAssertEqual(snake.direction, ASSnakeDirectionUp, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionRight];
    [snake changeDirection:ASSnakeDirectionUp];
    XCTAssertEqual(snake.direction, ASSnakeDirectionUp, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionDown];
    [snake changeDirection:ASSnakeDirectionUp];
    XCTAssertEqual(snake.direction, ASSnakeDirectionDown, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionUp];
    [snake changeDirection:ASSnakeDirectionUp];
    XCTAssertEqual(snake.direction, ASSnakeDirectionUp, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionToDown {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionDown];
    XCTAssertEqual(snake.direction, ASSnakeDirectionDown, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionRight];
    [snake changeDirection:ASSnakeDirectionDown];
    XCTAssertEqual(snake.direction, ASSnakeDirectionDown, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionDown];
    [snake changeDirection:ASSnakeDirectionDown];
    XCTAssertEqual(snake.direction, ASSnakeDirectionDown, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionUp];
    [snake changeDirection:ASSnakeDirectionDown];
    XCTAssertEqual(snake.direction, ASSnakeDirectionUp, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionToLeft {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionLeft];
    XCTAssertEqual(snake.direction, ASSnakeDirectionLeft, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionRight];
    [snake changeDirection:ASSnakeDirectionLeft];
    XCTAssertEqual(snake.direction, ASSnakeDirectionRight, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionDown];
    [snake changeDirection:ASSnakeDirectionLeft];
    XCTAssertEqual(snake.direction, ASSnakeDirectionLeft, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionUp];
    [snake changeDirection:ASSnakeDirectionLeft];
    XCTAssertEqual(snake.direction, ASSnakeDirectionLeft, @"snake direction: %u", snake.direction);
    
}

-(void) testChangeDirectionToRight {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    ASSnake *snake = [[ASSnake alloc]initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionRight];
    XCTAssertEqual(snake.direction, ASSnakeDirectionLeft, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionRight];
    [snake changeDirection:ASSnakeDirectionRight];
    XCTAssertEqual(snake.direction, ASSnakeDirectionRight, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionDown];
    [snake changeDirection:ASSnakeDirectionRight];
    XCTAssertEqual(snake.direction, ASSnakeDirectionRight, @"snake direction: %u", snake.direction);
    
    [snake setDirection:ASSnakeDirectionUp];
    [snake changeDirection:ASSnakeDirectionRight];
    XCTAssertEqual(snake.direction, ASSnakeDirectionRight, @"snake direction: %u", snake.direction);
    
}



// MARK: AddBodyLengthNumber:

// ToDo: invalid input

// Base case
-(void) testAddBodyLengthTailOnRight {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    Coordinate *head = [[Coordinate alloc] initWithCoordinateX:2 coordinateY:2];
    Coordinate *tail = [[Coordinate alloc] initWithCoordinateX:3 coordinateY:2];
    [body addObject:tail];
    [body addObject:head];
    
    snake.snakeBody = body;
    
    [snake addBodyLengthNumber:1];
    Coordinate *newTail = snake.snakeBody.firstObject;
    XCTAssert(newTail.x == 4 && newTail.y == 2, @"tail x: %ld, y: %ld", newTail.x, newTail.y);
    
}

-(void) testAddBodyLengthTailOnLeft {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    Coordinate *head = [[Coordinate alloc] initWithCoordinateX:2 coordinateY:2];
    Coordinate *tail = [[Coordinate alloc] initWithCoordinateX:1 coordinateY:2];
    [body addObject:tail];
    [body addObject:head];
    
    snake.snakeBody = body;
    
    [snake addBodyLengthNumber:1];
    Coordinate *newTail = snake.snakeBody.firstObject;
    XCTAssert(newTail.x == 0 && newTail.y == 2, @"tail x: %ld, y: %ld", newTail.x, newTail.y);
    
}

-(void) testAddBodyLengthTailOnTop {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:1]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:2]];
    
    snake.snakeBody = body;
    
    [snake addBodyLengthNumber:1];
    Coordinate *newTail = snake.snakeBody.firstObject;
    XCTAssert(newTail.x == 2 && newTail.y == 0, @"tail x: %ld, y: %ld", newTail.x, newTail.y);
    
}

-(void) testAddBodyLengthTailOnBottom {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    Coordinate *head = [[Coordinate alloc] initWithCoordinateX:2 coordinateY:2];
    Coordinate *tail = [[Coordinate alloc] initWithCoordinateX:2 coordinateY:3];
    [body addObject:tail];
    [body addObject:head];
    
    snake.snakeBody = body;
    
    [snake addBodyLengthNumber:1];
    Coordinate *newTail = snake.snakeBody.firstObject;
    XCTAssert(newTail.x == 2 && newTail.y == 4, @"tail x: %ld, y: %ld", newTail.x, newTail.y);
    
}

// Extreme case: add tail on edge

- (void)testAddTailOnLeftEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionUp];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:3]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:3]];
    snake.snakeBody = body;
    // arrange

    [snake addBodyLengthNumber:1];
    // action

    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 1 && tail.y == 3, @"tail x %d, y %d", tail.x, tail.y);
}

- (void)testAddTailOnRightEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionUp];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:4 coordinateY:3]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:3]];
    snake.snakeBody = body;
    // arrange
    
    [snake addBodyLengthNumber:1];
    // action
    
    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 3 && tail.y == 3, @"tail x %d, y %d", tail.x, tail.y);
}

- (void)testAddTailOnTopEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionUp];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:4]];
    snake.snakeBody = body;
    // arrange
    
    [snake addBodyLengthNumber:1];
    // action
    
    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 2 && tail.y == 1, @"tail x %d, y %d", tail.x, tail.y);
}

- (void)testAddTailOnBottomEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    [snake changeDirection:ASSnakeDirectionUp];
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:4]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:2 coordinateY:0]];
    snake.snakeBody = body;
    // arrange
    
    [snake addBodyLengthNumber:1];
    // action
    
    Coordinate *tail = snake.snakeBody.firstObject;
    XCTAssert(tail.x == 2 && tail.y == 3, @"tail x %d, y %d", tail.x, tail.y);
}

// Extreme case: add tail (length > 1) on corner
-(void) testAddTailCrossEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:1 coordinateY:0]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:2 coordinateY:0]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:2 coordinateY:1]];
    
    snake.snakeBody = body;
    
    [snake addBodyLengthNumber:2];
    
    Coordinate *tail = snake.snakeBody.firstObject;
    Coordinate *tail2 = snake.snakeBody[1];
    
    XCTAssert(tail.x == 4 && tail.y == 0, @"tail x: %d, y: %d", tail.x, tail.y);
    XCTAssert(tail2.x == 0 && tail2.y == 0, @"tail2 x: %d, y:%d", tail2.x, tail2.y);
}


// MARK: isHeadHitBody

-(void) testIsHeadHitBodyDefault {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    [body addObject:[[Coordinate alloc] initWithCoordinateX:0 coordinateY:0]];
    
    snake.snakeBody = body;
    
    XCTAssertTrue([snake isHeadHitBody], @"isHeadHitBody failed");
}

-(void) testIsHeadHitBodyAfterMoveOneStepOnEdge {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:4 coordinateY:2]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:4 coordinateY:3]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:4 coordinateY:4]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:0 coordinateY:4]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:0 coordinateY:3]];

    snake.snakeBody = body;
    [snake moveOneStep];
    
    XCTAssertTrue([snake isHeadHitBody], @"isHeadHitBody failed on the edge");

}

-(void) testIsHeadHitBodyAfterMoveOneStepInCenter {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:3 coordinateY:4]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:3 coordinateY:3]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:3 coordinateY:2]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:2 coordinateY:2]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:1 coordinateY:2]];
    
    snake.snakeBody = body;
    [snake changeDirection:ASSnakeDirectionUp];
    [snake moveOneStep];
    [snake changeDirection:ASSnakeDirectionRight];
    [snake moveOneStep];
    [snake changeDirection:ASSnakeDirectionDown];
    [snake moveOneStep];
    
    XCTAssertTrue([snake isHeadHitBody], @"isHeadHitBody failed in center");
    
}

-(void) testIsHeadHitBodyAfterAddBodyLength {
    GameField *gameField = [[GameField alloc] initWithWidth:5 Height:5];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:0 coordinateY:2]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:4 coordinateY:2]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:3 coordinateY:2]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:2 coordinateY:2]];
    
    snake.snakeBody = body;
    [snake addBodyLengthNumber:2];
    
    XCTAssertTrue([snake isHeadHitBody], @"isHeadHitBody failed in center");
    
}

// MARK: isHeadHitPoint:

// ToDo: invalid input

-(void) testIsHeadHitPoint {
    GameField *gameField = [[GameField alloc] initWithWidth:4 Height:4];
    ASSnake *snake = [[ASSnake alloc] initWithGameField:gameField];
    
    NSMutableArray *body = [NSMutableArray array];
    [body addObject:[[Coordinate alloc] initWithCoordinateX: 2 coordinateY: 3]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:1 coordinateY:3]];
    [body addObject:[[Coordinate alloc]initWithCoordinateX:1 coordinateY:2]];
    
    snake.snakeBody = body;
    
    Coordinate *point = [[Coordinate alloc]initWithCoordinateX:1 coordinateY:2];
    
    XCTAssert([snake isHeadHitPoint:point] == YES, @"isHeadHitPoint failed");
}

@end
