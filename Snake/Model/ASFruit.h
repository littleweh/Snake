//
//  Fruit.h
//  Snake
//
//  Created by Ada Kao on 29/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "GameField.h"

@interface ASFruit : NSObject
@property (strong, nonatomic, readwrite) Coordinate* coordinate;
-(instancetype) initWithGameField: (GameField*) gameField;
-(instancetype) initWithCoordinate: (Coordinate*) coordinate;
@end
