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
    if ([super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}

-(id) copyWithZone:(NSZone *)zone
{
    Coordinate *coordinateCopy = [[Coordinate allocWithZone:zone] init];
    
    if (coordinateCopy) {
        [coordinateCopy setX: self.x];
        [coordinateCopy setY: self.y];
    }
    
    return coordinateCopy;
}

-(BOOL) isEqualToCoordinate: (Coordinate *) coordinate{
    if (!coordinate || self.x != coordinate.x || self.y != coordinate.y){
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
