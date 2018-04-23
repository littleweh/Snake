//
//  GameField.m
//  Snake
//
//  Created by Ada Kao on 03/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import "GameField.h"

@implementation GameField
-(instancetype) initWithWidth: (NSInteger) width Height: (NSInteger) height {
    if (self = [super init]) {
        self.width = width;
        self.height = height;
    }
    return self;
}

@end
