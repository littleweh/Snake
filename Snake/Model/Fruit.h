//
//  Fruit.h
//  Snake
//
//  Created by Ada Kao on 29/03/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface Fruit : NSObject
@property (strong, atomic, readwrite) Coordinate* coordinate;
-(instancetype) init;
@end
