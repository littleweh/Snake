//
//  SnakeView.h
//  Snake
//
//  Created by Ada Kao on 02/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coordinate.h"
#import "Snake.h"
#import "Fruit.h"

@class SnakeGameView;

@protocol SnakeViewDelegate <NSObject>
-(Snake*) snakeForSnakeGameView: (SnakeGameView*) snakeGameView;
-(Fruit*) fruitForSnakeGameView: (SnakeGameView*) snakeGameView;
-(void) snakeGameViewGetNewDirection: (Direction) newDirection;

@end

@interface SnakeGameView : UIView 
@property (weak, nonatomic) id <SnakeViewDelegate> delegate;
@end

@interface SnakeGameView()
-(CGPoint) modelPointToViewPoint: (Coordinate*) point;
-(instancetype) initWithFrame: (CGRect) frame;
-(void)passDirectionByHandlingGestureRecognizedBy: (UISwipeGestureRecognizer*) recognizer;
@end

