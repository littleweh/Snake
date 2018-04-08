//
//  Fruit.m
//  Snake
//
//  Created by Ada Kao on 29/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "Fruit.h"


@implementation Fruit
-(instancetype) initWithGameField: (GameField*) gameField {
    if ([super init]) {
        // for test
//        NSInteger test_x = gameField.width - 1;
//        NSInteger test_y = 7;
//        Coordinate* testCoordinate = [[Coordinate alloc] initWithCoordinateX:test_x coordinateY:test_y];
//        self.coordinate = testCoordinate;

        // formal
        NSInteger x = arc4random() % gameField.width;
        NSInteger y = arc4random() % gameField.height;
        Coordinate* coordinate = [[Coordinate alloc] initWithCoordinateX:x coordinateY:y];
        self.coordinate = coordinate;
    }
    return self;
}
@end
