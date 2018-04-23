//
//  SnakeView.m
//  Snake
//
//  Created by Ada Kao on 02/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "SnakeGameView.h"
#import "Coordinate.h"
#import "ASSnake.h"
#import "ASFruit.h"

#define blockSize 20.0
// ToDo: blockSize flexible

@interface SnakeGameView() {
    int maxY;
    int maxX;
}
@end

@implementation SnakeGameView
-(instancetype) initWithFrame: (CGRect) frame {
    if ([super initWithFrame:frame]) {
        self.frame = frame;
        self->maxX = frame.size.width / blockSize;
        self->maxY = frame.size.height / blockSize;
    }
    return self;
}

-(void)passDirectionByHandlingGestureRecognizedBy: (UISwipeGestureRecognizer*) recognizer {
    if ([self.delegate respondsToSelector:@selector(snakeGameViewGetNewDirection:)]) {
        UISwipeGestureRecognizerDirection direction = recognizer.direction;        
        switch (direction) {
            case UISwipeGestureRecognizerDirectionUp:
                [self.delegate snakeGameViewGetNewDirection:ASSnakeDirectionUp];
                break;
            case UISwipeGestureRecognizerDirectionDown:
                [self.delegate snakeGameViewGetNewDirection:ASSnakeDirectionDown];
                break;
            case UISwipeGestureRecognizerDirectionLeft:
                [self.delegate snakeGameViewGetNewDirection:ASSnakeDirectionLeft];
                break;
            case UISwipeGestureRecognizerDirectionRight:
                [self.delegate snakeGameViewGetNewDirection:ASSnakeDirectionRight];
                break;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if ([self.delegate respondsToSelector:@selector(snakeForSnakeGameView:)]) {
        ASSnake* snake = [delegate snakeForSnakeGameView:self];
        [self drawSnake:snake.snakeBody];
    }
    if ([self.delegate respondsToSelector:@selector(fruitForSnakeGameView:)]) {
        ASFruit* fruit = [delegate fruitForSnakeGameView:self];
        [self drawFruit: fruit];
    }
    
}

-(CGPoint) modelPointToViewPoint: (Coordinate*) point {
    if (point == nil) {
        return CGPointZero;
    }

    maxX = self.frame.size.width / blockSize;
    maxY = self.frame.size.height / blockSize;

    NSInteger newX = point.x % maxX;
    if (newX < 0) newX += maxX;

    NSInteger newY = point.y % maxY;
    if (newY < 0) newY += maxY;
    return CGPointMake(newX * blockSize, newY * blockSize);
}

-(void) drawSnake: (NSMutableArray*) snakeBody {
    if (snakeBody == nil) {
        return;
    }
    for (int i = 0; i < [snakeBody count]; i++) {
        CGPoint newPoint = [self modelPointToViewPoint:snakeBody[i]];
        CGRect rect = CGRectMake(newPoint.x, newPoint.y, blockSize, blockSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
        CGContextFillRect(context, rect);
    }
    
}

-(void) drawFruit: (ASFruit*) fruit {
    if (fruit == nil) {
        return;
    }
    CGPoint fruitPoint = [self modelPointToViewPoint:fruit.coordinate];
    CGRect rect = CGRectMake(fruitPoint.x, fruitPoint.y, blockSize, blockSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextFillEllipseInRect(context, rect);
}

@synthesize delegate;
@end
