//
//  SnakeGameView.h
//  Snake
//
//  Created by Ada Kao on 03/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#ifndef SnakeGameView_h
#define SnakeGameView_h


#endif /* SnakeGameView_h */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Coordinate.h"
#import "Snake.h"
#import "Fruit.h"

@class SnakeGameView;

@protocol SnakeGameViewDelegate <NSObject>
-(Snake*) snakeForSnakeGameView: (SnakeGameView*) snakeGameView;
-(Fruit*) fruitForSnakeGameView: (SnakeGameView*) snakeGameView;
-(void) snakeGameViewGetNewDirection: (Direction) newDirection;
@end

@interface SnakeGameView: UIView
@property (weak, nonatomic) id <SnakeGameViewDelegate> delegate;
@end

@interface SnakeGameView()
-(CGPoint) modelPointToViewPoint: (Coordinate*) point;
-(instancetype) initWithFrame: (CGRect) frame;
-(void)passDirectionByHandlingGestureRecognizedBy: (UISwipeGestureRecognizer*) recognizer;
@end
