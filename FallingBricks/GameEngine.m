//
//  GameEngine.m
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameEngine.h"
#import "GameObject.h"

@implementation GameEngine

@synthesize gravitation = gravitation_;

-(id) init {
    if (self = [super init]) {
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        [accelerometer setDelegate: self];
        [accelerometer setUpdateInterval: (NSTimeInterval) 1./60.];
    }
    return self;
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    // DLog(@"x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
    gravitation_ = [Vector2D vectorWith: acceleration.x * 10. y: acceleration.y * 10];
}

-(void) updateGameObjects: (NSArray*) gameObjects withTimeStep: (CGFloat) dt {
    for (GameObject *o in gameObjects) {
        Vector2D *acceleration = [[o.force multiply: 1./ o.mass] add: self.gravitation];
        o.velocity = [o.velocity add: [acceleration multiply: dt]];
        
        Vector2D *angularAcceleration = [o.torque multiply: 1./o.inertia];
        o.angularVelocity = [o.angularVelocity add: [angularAcceleration multiply: dt]];
    }
}

@end
