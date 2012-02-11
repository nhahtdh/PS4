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
    
    CGFloat mass; // In kilograms. Fixed in PS5
    
    Vector2D* force;
    CGFloat torque;
    
    Vector2D* velocity;
    CGFloat angularVelocity;
}

@property (nonatomic, readonly) CGSize sizes;
// EFFECTS: Return the sizes (width and height) of the rectangle afetr scaling

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat angle;
@property (nonatomic, readonly) CGFloat scale;

@property (nonatomic, readonly) CGFloat mass;
@property (nonatomic, readonly) CGFloat inertia;
// EFFECTS: Return the moment of inertia of the game object calculated from the sizes and mass

@property (strong, nonatomic) Vector2D* force;
@property (nonatomic) CGFloat torque;

@property (strong, nonatomic) Vector2D* velocity;
@property (nonatomic) CGFloat angularVelocity;

// TODO: Probably add scale later for testing.
-(id) initWithSizes: (CGSize) s center:(CGPoint) c angle: (CGFloat) a mass:(CGFloat) m;
// NOTE: This function will not appear in PS5. The function exists for the purpose of testing.
// EFFECTS: Initialize a game object with sizes, center, rotation angle and mass

-(void)redraw;

@end
