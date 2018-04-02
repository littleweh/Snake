//
//  Fruit.m
//  Snake
//
//  Created by Ada Kao on 29/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "Fruit.h"


@implementation Fruit
-(instancetype) initWithCoordinateX: (NSInteger) x cooridnateY:(NSInteger) y {
    if ([super init]) {
        Coordinate* coordinate = [[Coordinate alloc] initWithCoordinateX:x coordinateY:y];
        self.coordinate = coordinate;
    }
    return self;
}
@end
