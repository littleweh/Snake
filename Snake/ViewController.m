//
//  ViewController.m
//  Snake
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "Snake.h"
#import "SnakeView.h"
#import "Fruit.h"

@interface ViewController ()
@property Snake* snake;
@property Fruit* fruit;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Coordinate* center = [[Coordinate alloc] initWithCoordinateX:0 coordinateY:0];
    self.snake = [[Snake alloc] initWithHeadPositionPoint:center];
    
    self.fruit = [[Fruit alloc] initWithCoordinateX:-2 cooridnateY:-2];
    
    [self showSnakePosition];

    
    self.view.backgroundColor = [UIColor blackColor];
    CGRect gameView = CGRectMake(self.view.bounds.origin.x + 20, self.view.bounds.origin.y + 20, self.view.bounds.size.width - 40, self.view.bounds.size.height - 40);
    self.snakeView = [[SnakeView alloc] initWithFrame:gameView];
    self.snakeView.backgroundColor = [UIColor whiteColor];
    
    
    
    [self.view addSubview:self.snakeView];
    [self.snakeView setDelegate:self];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
//    button.backgroundColor = [UIColor whiteColor];
//    [button setTitle:@"test" forState:UIControlStateNormal];
//    [button setTintColor:[UIColor blueColor]];
//    [self.view addSubview:button];
    
//    Coordinate* pointZero = [[Coordinate alloc] initWithCoordinateX:0 coordinateY:0];
//    BOOL flag = [self.snake isHeadHitPoint:pointZero];
//    NSLog(flag? @"Yes" : @"NO");
    
    NSLog(@"Move one step with direction: %u", self.snake.direction);
    [self.snake moveOneStep];
    [self showSnakePosition];
    [self.view setNeedsDisplay];
    
//    NSLog(@"Add body length with direction: %u", self.snake.direction);
//    [self.snake addBodyLengthNumber:5];
//    [self snakeFromSnakeView:self.snakeView];
////    [self showSnakePosition];
//    
//    
//    [self.snake changeDirection:up];
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self showSnakePosition];
//
//    
//    [self.snake changeDirection:right];
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self showSnakePosition];
//
//    
//    [self.snake changeDirection:down];
//    NSLog(@"Move one step with direction: %u", self.snake.direction);
//    [self.snake moveOneStep];
//    [self showSnakePosition];
//
//    BOOL flag2 = [self.snake isHeadHitBody];
//    NSLog(flag2? @"hit": @"not hit");
    
    
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

-(Snake*) snakeFromSnakeView: (SnakeView*) snakeView {
    return self.snake;
}

-(Fruit*) fruitFromSnakeView: (SnakeView*) snakeView {
    return self.fruit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
