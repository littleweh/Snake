//
//  Fruit.m
//  Snake
//
//  Created by Ada Kao on 29/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "ASFruit.h"


@implementation ASFruit
-(instancetype) initWithGameField: (GameField*) gameField {
    if (self = [super init]) {
        NSInteger x = arc4random() % gameField.width;
        NSInteger y = arc4random() % gameField.height;
        Coordinate* coordinate = [[Coordinate alloc] initWithCoordinateX:x coordinateY:y];
        self.coordinate = coordinate;
    }
    return self;
}

-(instancetype) initWithCoordinate: (Coordinate*) coordinate {
    if (self = [super init]) {
        self.coordinate = coordinate;
    }
    return self;
}

@end
