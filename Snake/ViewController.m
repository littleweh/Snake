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
#import "GameField.h"

@interface ViewController ()
@property Snake* snake;
@property Fruit* fruit;
@property NSTimer* myTimer;
@property GameField* snakeGameField;
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
    
    self.snakeGameField = [[GameField alloc] initWithWidth:self.snakeGameView.frame.size.width/ 20
                                                    Height:self.snakeGameView.frame.size.height / 20];
//    NSLog(@"gameField- width: %d, height: %d", self.snakeGameField.width, self.snakeGameField.height);
    
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

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    __weak typeof(self) weakSelf = self;

    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [weakSelf.snakeGameView setNeedsLayout];
    }];
}

-(void)playSnakeGame {
    [self.snake moveOneStep];
    
    // ToDo: delete
//    [self showSnakePosition];
//    [self showFruitPosition];

    [self.snakeGameView setNeedsLayout];
    [self.snakeGameView setNeedsDisplay];
    
    if ([self.snake isHeadHitBody]) {
        [self endGame];
    }
    
    if([self.snake isHeadHitPoint:self.fruit.coordinate]) {
        [self.snake addBodyLengthNumber:2];
        self.fruit = [self generateNewFruit];
    }
}

-(Fruit *) generateNewFruit {
    Fruit * previousFruit = self.fruit;
    Fruit * newFruit = [[Fruit alloc] initWithGameField:self.snakeGameField];

    for (int i = 0; i<self.snake.snakeBody.count; i++) {
        Coordinate* bodyPoint = self.snake.snakeBody[i];
        if (newFruit.coordinate.x == bodyPoint.x && newFruit.coordinate.y == bodyPoint.y) {
            newFruit = [self generateNewFruit];
            break;
        }
    }
        
    if (newFruit.coordinate.x == previousFruit.coordinate.x &&
        newFruit.coordinate.y == previousFruit.coordinate.y) {
        newFruit = [self generateNewFruit];
    }
    
    return newFruit;
    
}

-(void) startGame {
    self.startButton.hidden = YES;
    self.snakeGameView.hidden = NO;
    
    self.snake = [[Snake alloc] initWithGameField:self.snakeGameField];
    self.fruit = [[Fruit alloc] initWithGameField:self.snakeGameField];
    
//    [self showSnakePosition];

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
        
//        NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewA]-(padding)-[viewB]-|" options:0 metrics:@{@"padding": @(50)} views:NSDictionaryOfVariableBindings()];
//        NSLayoutConstraint constraintWithItem:<#(nonnull id)#> attribute:<#(NSLayoutAttribute)#> relatedBy:<#(NSLayoutRelation)#> toItem:<#(nullable id)#> attribute:<#(NSLayoutAttribute)#> multiplier:<#(CGFloat)#> constant:<#(CGFloat)#>
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
- (void) showSnakePosition {
    for (Coordinate* body in self.snake.snakeBody) {
        NSLog(@"x: %ld, y: %ld", (long)body.x, body.y);
    }
}

- (void) showFruitPosition {
    NSLog(@"Fruit - x: %ld, y: %ld", (long)self.fruit.coordinate.x, self.fruit.coordinate.y);
}
*/

@end
