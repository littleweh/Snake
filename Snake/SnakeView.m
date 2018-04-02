//
//  SnakeView.m
//  Snake
//
//  Created by Ada Kao on 02/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "SnakeView.h"
#import "Coordinate.h"

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
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void) drawSnake: (NSMutableArray*) snake {
    
}

-(CGPoint) modelPointToViewPoint: (Coordinate*) point {
    NSInteger newX = (point.x - midX) % maxX;
    NSInteger newY = (point.y - midY) % maxY;
    return CGPointMake(newX * blockSize, newY * blockSize);
}

- (void) setMaxY: (int) maxY {
    self.maxY = maxY;
    self->midY = maxY / 2;
}
-(void) setMaxX: (int) maxX {
    self.maxX = maxX;
    self->midX = maxX / 2;
}


@end
