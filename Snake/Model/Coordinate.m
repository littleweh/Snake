//
//  Coordinate.m
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate
-(instancetype) initWithCoordinateX:(NSInteger) x coordinateY:(NSInteger) y
{
    if (self = [super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}

-(id) copyWithZone:(NSZone *)zone
{
    Coordinate *anotherCoordinate = [[self class] allocWithZone:zone];
    
    if (anotherCoordinate) {
        [anotherCoordinate setX: self.x];
        [anotherCoordinate setY: self.y];
    }
    
    return anotherCoordinate;
}

-(BOOL) isEqualToCoordinate: (Coordinate *) aCoordinate{
    if (!aCoordinate || self.x != aCoordinate.x || self.y != aCoordinate.y){
        return NO;
    }
    return YES;
}

-(BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[Coordinate class]]) {
        return NO;
    }
    
    return [self isEqualToCoordinate:(Coordinate *)object];
}

@end
