//
//  ViewController.m
//  Snake
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "Snake.h"
#import "SnakeGameView.h"
#import "Fruit.h"

@interface ViewController ()
@property Snake* snake;
@property Fruit* fruit;
@property NSTimer* myTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect gameView = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
    self.snakeGameView = [[SnakeGameView alloc] initWithFrame:gameView];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.view addSubview:self.snakeGameView];
    [self.view addSubview:self.startButton];
    [self setupSnakeGameView];
    [self setupStartButton];
    
    [self.snakeGameView setDelegate:self];
    [self addSwipeGestureRecognizerToSnakeGameView];
    self.snakeGameView.hidden = YES;
    
}

-(void) initializeTimer {
    float theInterval = 1.0 / 2.0;
    self.myTimer = [NSTimer
                    scheduledTimerWithTimeInterval:theInterval
                    target:self
                    selector:@selector(playSnakeGame)
                    userInfo:nil
                    repeats:YES
                    ];
}

-(void)playSnakeGame {
    [self.snake moveOneStep];
    
    // ToDo: delete
    [self showSnakePosition];
    [self showFruitPosition];

    [self.snakeGameView setNeedsLayout];
    [self.snakeGameView setNeedsDisplay];
    
    if ([self.snake isHeadHitBody]) {
        [self endGame];
    }
    
    if([self.snake isHeadHitPoint:self.fruit.coordinate]) {
        [self.snake addBodyLengthNumber:2];
        self.fruit = [[Fruit alloc] init];
    }
    
}

-(void) startGame {
    self.startButton.hidden = YES;
    self.snakeGameView.hidden = NO;
    
    Coordinate* center = [[Coordinate alloc] initWithCoordinateX:0 coordinateY:0];
    self.snake = [[Snake alloc] initWithHeadPositionPoint:center];
    self.fruit = [[Fruit alloc] init];
    
    [self showSnakePosition];

    [self.view layoutIfNeeded];
    [self.snakeGameView setNeedsLayout];
    [self.snakeGameView setNeedsDisplay];
    
    [self initializeTimer];
    
}

-(void) endGame {
    self.snakeGameView.hidden = YES;
    self.startButton.hidden = NO;
    [self.myTimer invalidate];
    self.myTimer = nil;
}

-(void) setupStartButton {
    self.startButton.backgroundColor = [UIColor blackColor];
    [self.startButton setTintColor:[UIColor yellowColor]];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.startButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.startButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.3].active = YES;
    [self.startButton.heightAnchor constraintLessThanOrEqualToAnchor:self.startButton.widthAnchor multiplier:1.6].active = YES;
}

-(void) setupSnakeGameView {
    self.snakeGameView.backgroundColor = [UIColor whiteColor];
    self.snakeGameView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available (iOS 11, *)) {
        UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
        [self.snakeGameView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:10].active = YES;
        [self.snakeGameView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:10].active = YES;
        [self.snakeGameView.topAnchor constraintEqualToAnchor:guide.topAnchor].active = YES;
        [self.snakeGameView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
    } else {
        UILayoutGuide * margins = self.view.layoutMarginsGuide;
        [self.snakeGameView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor constant:10].active = YES;
        [self.snakeGameView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:10].active = YES;
        [self.snakeGameView.topAnchor constraintEqualToAnchor:margins.topAnchor constant:10].active = YES;
        [self.snakeGameView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor constant:10].active = YES;
    }
    
    [self.view layoutIfNeeded];
    
}

-(void) addSwipeGestureRecognizerToSnakeGameView {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self.snakeGameView action:@selector(passDirectionByHandlingGestureRecognizedBy:)];
    [swipeLeft setDirection: UISwipeGestureRecognizerDirectionLeft];
    [self.snakeGameView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self.snakeGameView action:@selector(passDirectionByHandlingGestureRecognizedBy:)];
    [swipeRight setDirection: UISwipeGestureRecognizerDirectionRight];
    [self.snakeGameView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self.snakeGameView action:@selector(passDirectionByHandlingGestureRecognizedBy:)];
    [swipeUp setDirection: UISwipeGestureRecognizerDirectionUp];
    [self.snakeGameView addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self.snakeGameView action:@selector(passDirectionByHandlingGestureRecognizedBy:)];
    [swipeDown setDirection: UISwipeGestureRecognizerDirectionDown];
    [self.snakeGameView addGestureRecognizer:swipeDown];
}

-(Snake*) snakeForSnakeGameView: (SnakeGameView*) snakeView {
    return self.snake;
}

-(Fruit*) fruitForSnakeGameView: (SnakeGameView*) snakeView {
    return self.fruit;
}

-(void) snakeGameViewGetNewDirection: (Direction) newDirection {
    [self.snake changeDirection:newDirection];
    [self.snake moveOneStep];
    [self showSnakePosition];
    [self.snakeGameView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) showSnakePosition {
    for (Coordinate* body in self.snake.snakeBody) {
        NSLog(@"x: %ld, y: %ld", (long)body.x, body.y);
    }
}

- (void) showFruitPosition {
    NSLog(@"Fruit - x: %ld, y: %ld", (long)self.fruit.coordinate.x, self.fruit.coordinate.y);
}

@end
