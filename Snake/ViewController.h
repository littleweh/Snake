//
//  ViewController.h
//  Snake
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASSnakeGameView.h"

@interface ViewController : UIViewController <SnakeGameViewDelegate>
@property (nonatomic, readonly) ASSnakeGameView* snakeGameView;
@property (nonatomic, readonly) UIButton* startButton;

@end

