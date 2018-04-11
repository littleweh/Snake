//
//  CoordinateTests.m
//  SnakeTests
//
//  Created by Ada Kao on 11/04/2018.
//  Copyright © 2018 Ada Kao. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Coordinate.h"
#import "Fruit.h"

@interface CoordinateTests : XCTestCase

@end

@implementation CoordinateTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


// MARK: isEqual

-(void) testIsEqualEqualCase {
    Coordinate *point = [[Coordinate alloc]initWithCoordinateX:1 coordinateY:1];
    Coordinate *samePoint = [[Coordinate alloc]initWithCoordinateX:1 coordinateY:1];
    
    XCTAssertTrue([point isEqual:samePoint], @"Coordinate isEqual failed");
    
}
-(void) testIsEqualNotEqualCase {
    Coordinate *point = [[Coordinate alloc]initWithCoordinateX:1 coordinateY:1];
    Coordinate *samePoint = [[Coordinate alloc]initWithCoordinateX:2 coordinateY:1];
    
    XCTAssertFalse([point isEqual:samePoint], @"Coordinate isEqual failed");
    
}

-(void) testIsEqualSameObjectCase {
    Coordinate *point = [[Coordinate alloc]initWithCoordinateX:1 coordinateY:1];
    Coordinate *anotherPoint = point;
    
    XCTAssertTrue([point isEqual:anotherPoint], @"Coordinate isEqual same object failed");
}

-(void) testIsEqualInvalidInput {
    Coordinate *point = [[Coordinate alloc]initWithCoordinateX:1 coordinateY:1];
    Fruit *fruit = [[Fruit alloc]initWithCoordinate:point];
    
    XCTAssertFalse([point isEqual:fruit], @"Coordinate is Equal invalid input failed");
}
@end
