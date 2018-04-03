//
//  GameField.h
//  Snake
//
//  Created by Ada Kao on 03/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameField : NSObject
@property NSInteger width;
@property NSInteger height;

-(instancetype) initWithWidth: (NSInteger) width Height: (NSInteger) height;

@end


