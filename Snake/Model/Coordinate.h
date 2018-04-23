//
//  Coordinate.h
//  Snake
//
//  Created by Ada Kao on 28/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject <NSCopying>
@property (assign, nonatomic, readwrite) NSInteger x;
@property (assign, nonatomic, readwrite) NSInteger y;
-(instancetype) initWithCoordinateX:(NSInteger) x coordinateY:(NSInteger) y;
-(id) copyWithZone:(NSZone *)zone;
@end
