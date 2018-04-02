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

@class SnakeView;

@protocol SnakeViewDelegate
-(Snake*) snakeFromSnakeView: (SnakeView*) snakeView;
-(Fruit*) fruitFromSnakeView: (SnakeView*) snakeView;

@end

@interface SnakeView : UIView {
    id <SnakeViewDelegate> delegate;
}
@property (weak, nonatomic) id <SnakeViewDelegate> delegate;
-(CGPoint) modelPointToViewPoint: (Coordinate*) point;

@end
