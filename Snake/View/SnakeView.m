//
//  SnakeView.m
//  Snake
//
//  Created by Ada Kao on 02/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "SnakeView.h"
#import "Coordinate.h"
#import "Snake.h"
#import "Fruit.h"

#define blockSize 20.0

@interface SnakeView() {
    int maxY;
    int maxX;
    int midY;
    int midX;
}
@end

@implementation SnakeView
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(instancetype) initWithFrame: (CGRect) frame {
    if ([super initWithFrame:frame]) {
        self.frame = frame;
        self->maxX = frame.size.width / blockSize;
        self->maxY = frame.size.height / blockSize;
        self->midX = maxX / 2;
        self->midY = maxY / 2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    Snake* snake = [delegate snakeFromSnakeView:self];
    [self drawSnake:snake.snakeBody];
    
    Fruit* fruit = [delegate fruitFromSnakeView:self];
    [self drawFruit: fruit];
    
}

-(CGPoint) modelPointToViewPoint: (Coordinate*) point {
    if (point == nil) {
        return CGPointZero;
    }
    NSInteger newX = (point.x - midX) % maxX;
    if (newX < 0) newX += maxX;
    NSInteger newY = (point.y - midY) % maxY;
    if (newY < 0) newY += maxY;
    return CGPointMake(newX * blockSize, newY * blockSize);
}

-(void) drawSnake: (NSMutableArray*) snake {
    if (snake == nil) {
        return;
    }
    for (int i = 0; i < [snake count]; i++) {
        CGPoint newPoint = [self modelPointToViewPoint:snake[i]];
        CGRect rect = CGRectMake(newPoint.x, newPoint.y, blockSize, blockSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
        CGContextFillRect(context, rect);
    }
    
}

-(void) drawFruit: (Fruit*) fruit {
    if (fruit == nil) {
        return;
    }
    CGPoint fruitPoint = [self modelPointToViewPoint:fruit.coordinate];
    CGRect rect = CGRectMake(fruitPoint.x, fruitPoint.y, blockSize, blockSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextFillEllipseInRect(context, rect);
}



- (void) setMaxY: (int) maxY {
    self.maxY = maxY;
    self->midY = maxY / 2;
}
-(void) setMaxX: (int) maxX {
    self.maxX = maxX;
    self->midX = maxX / 2;
}

@synthesize delegate;
@end
