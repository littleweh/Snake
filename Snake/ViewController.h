//
//  ViewController.h
//  Snake
//
//  Created by Ada Kao on 27/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SnakeView.h"

@interface ViewController : UIViewController <SnakeViewDelegate>
@property SnakeView* snakeView;

@end

