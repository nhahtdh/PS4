//
//  FallingBricksTests.m
//  FallingBricksTests
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FallingBricksTests.h"

@implementation FallingBricksTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

+ (GameObject*) gameObjectWithSizes: (CGSize) s center:(CGPoint) c angle:(CGFloat) a scale: (CGFloat) sc {
    // EFFECTS: Initialize a game object with the parameters necessary for boolean collision testing.
    return [[GameObject alloc] initWithSizes: s center: c angle: a scale: sc mass: 1.0 friction: 1.0 restitution:1.0 canMove: YES];
}

- (void)testTouching {
    GameObject *a = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100) 
                                                     center: CGPointMake(50, 50) 
                                                      angle: 0
                                                      scale: 1.0];
    
    GameObject *b = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100)
                                                     center: CGPointMake(150, 100) 
                                                      angle: 0 
                                                      scale: 1.0];
    
    BOOL result = [GameEngine collideGameObject: a : b : 1./60.];
    STAssertFalse(result, @"Touching rectangular objects");
}

- (void) testSmallOverlapByRotation {
    GameObject *a = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100) 
                                                     center: CGPointMake(50, 50) 
                                                      angle: 0
                                                      scale: 1.0];
    
    GameObject *b = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100)
                                                     center: CGPointMake(150, 100) 
                                                      angle: degree_to_radian(1)
                                                      scale: 1.0];
    
    // NOTE: The objects does not go to step 3 with rotation angle = 1 degree
    BOOL result = [GameEngine collideGameObject: a : b : 1./60.];
    STAssertTrue(result, @"Slightly overlapping objects by rotation");
}

- (void) testSmallOverlapByScaling {
    GameObject *a = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100) 
                                                     center: CGPointMake(50, 50) 
                                                      angle: 0
                                                      scale: 1.0];
    
    GameObject *b = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100) 
                                                     center: CGPointMake(150, 100) 
                                                      angle: 0 
                                                      scale: 1.05];
    
    BOOL result = [GameEngine collideGameObject: a : b : 1./60.];
    STAssertTrue(result, @"Slightly overlapping objects by scaling");
}

- (void) testCrossOverlap {
    GameObject *a = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 10) 
                                                     center: CGPointMake(200, 200) 
                                                      angle: 0 
                                                      scale: 1];
    GameObject *b = [FallingBricksTests gameObjectWithSizes: CGSizeMake(200, 15)
                                                     center: CGPointMake(180, 250)
                                                      angle: 90
                                                      scale: 1];
    BOOL result = [GameEngine collideGameObject: a : b : 1./60.];
    STAssertTrue(result, @"Crossing objects");
}

- (void) testCornerTouching {
    GameObject *a = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100) 
                                                     center: CGPointMake(100, 100)
                                                      angle: 0 
                                                      scale: 1];
    GameObject *b = [FallingBricksTests gameObjectWithSizes: CGSizeMake(100, 100) 
                                                     center: CGPointMake(200, 200) 
                                                      angle: 0 
                                                      scale: 1];
    
    BOOL result = [GameEngine collideGameObject: a : b : 1./60.];
    STAssertFalse(result, @"Corner touching");
}


@end
