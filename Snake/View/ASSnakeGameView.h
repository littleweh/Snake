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
#import "ASSnake.h"
#import "ASFruit.h"

@class ASSnakeGameView;

@protocol SnakeGameViewDelegate <NSObject>
-(NSMutableArray <Coordinate *> *) snakeGameViewWillReturnASSnakeBody: (ASSnakeGameView*) snakeGameView;
-(ASFruit*) snakeGameViewWillReturnASFruit: (ASSnakeGameView*) snakeGameView;
-(void) snakeGameViewGetNewDirection: (ASSnakeDirection) newDirection;
@end

@interface ASSnakeGameView: UIView
@property (weak, nonatomic) id <SnakeGameViewDelegate> delegate;
@end

@interface ASSnakeGameView()
-(CGPoint) modelPointToViewPoint: (Coordinate*) point;
-(instancetype) initWithFrame: (CGRect) frame;
-(void)passDirectionByHandlingGestureRecognizedBy: (UISwipeGestureRecognizer*) recognizer;
@end
