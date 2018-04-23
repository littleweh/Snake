//
//  ViewController.m
//  Snake
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ViewController.h"
#import "ASSnake.h"
#import "SnakeGameView.h"
#import "ASFruit.h"
#import "GameField.h"

@interface ViewController ()
@property ASSnake* snake;
@property ASFruit* fruit;
@property NSTimer* myTimer;
@property GameField* snakeGameField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.snakeGameView = [[SnakeGameView alloc] initWithFrame:self.view.bounds];
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

-(void) startGame {
    self.snakeGameField = [[GameField alloc] initWithWidth:self.snakeGameView.frame.size.width/ 20
                                                    Height:self.snakeGameView.frame.size.height / 20];
    
    self.startButton.hidden = YES;
    self.snakeGameView.hidden = NO;
    
    self.snake = [[ASSnake alloc] initWithGameField:self.snakeGameField];
    self.fruit = [[ASFruit alloc] initWithGameField:self.snakeGameField];
    
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

-(void)playSnakeGame {
    [self.snake moveOneStep];

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

-(ASFruit *) generateNewFruit {
    ASFruit * previousFruit = self.fruit;
    ASFruit * newFruit = [[ASFruit alloc] initWithGameField:self.snakeGameField];
    
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

// MARK: UI Setup
-(void) setupStartButton {
    self.startButton.backgroundColor = [UIColor blackColor];
    [self.startButton setTintColor:[UIColor yellowColor]];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *centerX = [NSLayoutConstraint
                                   constraintWithItem:self.startButton
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeCenterX
                                   multiplier:1.0
                                   constant:0.0
                                   ];
    NSLayoutConstraint *centerY = [NSLayoutConstraint
                                   constraintWithItem:self.startButton
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1.0
                                   constant:0.0
                                   ];
    
    NSLayoutConstraint *width = [NSLayoutConstraint
                                 constraintWithItem:self.startButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                 toItem:self.view
                                 attribute:NSLayoutAttributeWidth
                                 multiplier:0.3
                                 constant:0.0
                                 ];

    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:self.startButton
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationLessThanOrEqual
                                  toItem:self.startButton
                                  attribute:NSLayoutAttributeWidth
                                  multiplier:1.6
                                  constant:0.0
                                  ];

    [self.view addConstraint:centerX];
    [self.view addConstraint:centerY];
    [self.view addConstraint:width];
    [self.startButton addConstraint:height];

    [self.startButton layoutIfNeeded];

    self.startButton.layer.cornerRadius = 0.2 * self.startButton.frame.size.height;
    self.startButton.clipsToBounds = YES;
}

-(void) setupSnakeGameView {
    self.snakeGameView.backgroundColor = [UIColor whiteColor];
    self.snakeGameView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available (iOS 11, *)) {
        UILayoutGuide * guide = self.view.safeAreaLayoutGuide;

        NSLayoutConstraint *leading = [NSLayoutConstraint
                                       constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:guide
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:10.0
         ];

        NSLayoutConstraint *trailing = [NSLayoutConstraint
                                        constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:guide
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:-10.0
         ];
        NSLayoutConstraint *top = [NSLayoutConstraint
                                   constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:guide
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:10
         ];
        NSLayoutConstraint *bottom = [NSLayoutConstraint
                                      constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:guide
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:-10
         ];
        NSLayoutConstraint *centerX = [NSLayoutConstraint
                                       constraintWithItem:self.snakeGameView
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:guide
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                       constant:0.0
                                       ];

        [self.view addConstraint:leading];
        [self.view addConstraint:trailing];
        [self.view addConstraint:top];
        [self.view addConstraint:bottom];
        [self.view addConstraint:centerX];
    } else {
        UILayoutGuide * margins = self.view.layoutMarginsGuide;
        NSLayoutConstraint *top = [NSLayoutConstraint
                                   constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:margins
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:10
         ];
        NSLayoutConstraint *bottom = [NSLayoutConstraint
                                      constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:margins
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:-10
         ];

        NSLayoutConstraint *leading = [NSLayoutConstraint
                                       constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:margins
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1.0
                                      constant:10
         ];
        NSLayoutConstraint *trailing = [NSLayoutConstraint
                                        constraintWithItem:self.snakeGameView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                        toItem:margins
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1.0
                                      constant:-10
         ];

        NSLayoutConstraint *centerX = [NSLayoutConstraint
                                       constraintWithItem:self.snakeGameView
                                       attribute:NSLayoutAttributeCenterX
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:margins
                                       attribute:NSLayoutAttributeCenterX
                                       multiplier:1.0
                                       constant:0.0
                                       ];

        [self.view addConstraint:top];
        [self.view addConstraint:bottom];
        [self.view addConstraint:leading];
        [self.view addConstraint:trailing];
        [self.view addConstraint:centerX];
        
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

// MARK: snakeGameViewDelegate
-(ASSnake*) snakeForSnakeGameView: (SnakeGameView*) snakeView {
    return self.snake;
}

-(ASFruit*) fruitForSnakeGameView: (SnakeGameView*) snakeView {
    return self.fruit;
}

-(void) snakeGameViewGetNewDirection: (ASSnakeDirection) newDirection {
    [self.snake changeDirection:newDirection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
