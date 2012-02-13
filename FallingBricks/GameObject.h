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
    NSString *name; // For testing purpose.
    
    CGSize sizes; // Fixed in PS5 by object.
    CGPoint center;
    CGFloat angle;
    CGFloat scale; // Fixed when in-game
    
    BOOL canMove;
    CGFloat mass; // In kilograms. Fixed in PS5 by object (or by object and scale).
    CGFloat friction; // Fixed in PS5 by object.
    CGFloat restitution; // Fixed in PS5 by object. Elasticity.
    
    Vector2D* force;
    CGFloat torque;
    
    Vector2D* velocity;
    CGFloat angularVelocity;
}

// @property (nonatomic, readonly) CGSize sizes;

-(CGSize) actualSizes;

@property (strong, nonatomic) NSString* name;

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat angle;
@property (nonatomic, readonly) CGFloat scale;

@property (nonatomic) BOOL canMove;
@property (nonatomic, readonly) CGFloat mass;
@property (nonatomic, readonly) CGFloat inertia;
@property (nonatomic, readonly) CGFloat friction;
@property (nonatomic, readonly) CGFloat restitution;
// EFFECTS: Return the moment of inertia of the game object calculated from the sizes and mass

@property (strong, nonatomic) Vector2D* force;
@property (nonatomic) CGFloat torque;

@property (strong, nonatomic) Vector2D* velocity;
@property (nonatomic) CGFloat angularVelocity;

-(id) initWithSizes: (CGSize) s center:(CGPoint) c angle: (CGFloat) a scale: (CGFloat) sc
               mass: (CGFloat) m friction: (CGFloat) f restitution: (CGFloat) r
            canMove: (BOOL)moveability;
// NOTE: This function will not appear in PS5. The function exists for the purpose of testing.
// EFFECTS: Initialize a game object with sizes, center, rotation angle and mass

-(void)redraw;

@end
