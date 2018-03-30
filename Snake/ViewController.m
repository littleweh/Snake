//
//  ViewController.m
//  Snake
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "Snake.h"

@interface ViewController ()
@property Snake* snake;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Coordinate* center = [[Coordinate alloc] initWithCoordinateX:0 coordinateY:0];
    self.snake = [[Snake alloc] initWithHeadPositionPoint:center];
    
    [self showSnakePosition];
    
    Coordinate* pointZero = [[Coordinate alloc] initWithCoordinateX:0 coordinateY:0];
    BOOL flag = [self.snake isHeadHitPoint:pointZero];
    NSLog(flag? @"Yes" : @"NO");
    
    NSLog(@"Move one step with direction: %u", self.snake.direction);
    [self.snake moveOneStep];
    [self showSnakePosition];
    
    NSLog(@"Add body length with direction: %u", self.snake.direction);
    [self.snake addBodyLengthNumber:5];
    [self showSnakePosition];
    
    [self.snake changeDirection:up];
    NSLog(@"Move one step with direction: %u", self.snake.direction);
    [self.snake moveOneStep];
    [self showSnakePosition];

    
    [self.snake changeDirection:right];
    NSLog(@"Move one step with direction: %u", self.snake.direction);
    [self.snake moveOneStep];
    [self showSnakePosition];

    
    [self.snake changeDirection:down];
    NSLog(@"Move one step with direction: %u", self.snake.direction);
    [self.snake moveOneStep];
    [self showSnakePosition];

    BOOL flag2 = [self.snake isHeadHitBody];
    NSLog(flag? @"hit": @"not hit");
    
    
//    [self.snake changeDirection:up];
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self showSnakePosition];
//
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self showSnakePosition];
//
//    NSLog(@"Add body length with direction: %u", self.snake.direction);
//    [self.snake addBodyLengthNumber:2];
//    [self showSnakePosition];
//
//    [self.snake changeDirection:right];
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self.snake moveOneStep];
//    [self showSnakePosition];
//
//    [self.snake changeDirection:down];
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self.snake moveOneStep];
//    [self showSnakePosition];
    

   
}

- (void) showSnakePosition {
    for (Coordinate* body in self.snake.snakeBody) {
        NSLog(@"x: %ld, y: %ld", (long)body.x, body.y);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
