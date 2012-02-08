//
//  GameObject.h
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vector2D.h"

@interface GameObject : UIViewController {
    CGSize sizes; // Fixed in PS5
    CGPoint center;
    CGFloat angle;
    CGFloat scale; // Fixed when in-game
    
    CGFloat mass; // Fixed in PS5
    
    Vector2D* force;
    Vector2D* torque;
    
    Vector2D* velocity;
    Vector2D* angularVelocity;
}

@property (nonatomic, readonly) CGSize sizes;
// EFFECTS: Return the sizes (width and height) of the rectangle afetr scaling

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat angle;
@property (nonatomic, readonly) CGFloat scale;

@property (nonatomic, readonly) CGFloat mass;
@property (nonatomic, readonly) CGFloat inertia;

@property (strong, nonatomic) Vector2D* force;
@property (strong, nonatomic) Vector2D* torque;

@property (strong, nonatomic) Vector2D* velocity;
@property (strong, nonatomic) Vector2D* angularVelocity;

/*
+ (Vector2D*) gravitationalAcceleration;

- (void) updateState: (CGFloat) dt;
 */

@end
