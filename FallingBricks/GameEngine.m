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

@synthesize timeStep;
@synthesize gravity = gravity_;

#define GravityXAxisMultiplier 500.
#define GravityYAxisMultiplier -500.

-(void)simulateGravity: (NSTimer*) timer {
    // There is a bug with the orientation on the iOS simulator (at least for iPad)
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            DLog(@"Up/Down");
            gravity_ = [Vector2D vectorWith: 0 y: 0];
            break;
        case UIDeviceOrientationLandscapeLeft:
            DLog(@"Left");
            gravity_ = [Vector2D vectorWith: -GravityXAxisMultiplier y: 0];
            break;
        case UIDeviceOrientationLandscapeRight:
            DLog(@"Right");
            gravity_ = [Vector2D vectorWith: GravityXAxisMultiplier y: 0];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            DLog(@"Up");
            gravity_ = [Vector2D vectorWith: 0 y: GravityYAxisMultiplier];
            break;
        // case UIDeviceOrientationUnknown:
        case UIDeviceOrientationPortrait:
            DLog(@"Down");
            gravity_ = [Vector2D vectorWith: 0 y: -GravityYAxisMultiplier];
            break;
        default:
            break;
    }
}

-(id) init {
    if (self = [super init]) {
        // Set up UIAccelerometer
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        [accelerometer setDelegate: self];
        [accelerometer setUpdateInterval: (NSTimeInterval) 1./60.];
        
        // For iPad Simulator only.
        if ([[[UIDevice currentDevice] name] isEqual: @"iPad Simulator"]) { 
            DLog(@"Accelerometer not available, so gravity is simulated.");
            [NSTimer scheduledTimerWithTimeInterval: 1./60. 
                                             target: self 
                                           selector: @selector(simulateGravity:)
                                           userInfo: nil
                                            repeats: YES];
        }
        
        // Default time step value
        timeStep = 1./60.;
    }
    return self;
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    DLog(@"x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
    gravity_ = [Vector2D vectorWith: acceleration.x * GravityXAxisMultiplier y: acceleration.y * GravityYAxisMultiplier];
}

static long count = 0;

-(void) updateGameObjects: (NSArray*) gameObjects {
    // Make sure the same gravity is used throughout
    DLog(@"updateGameObject is called %ld.", count++);
    Vector2D *currentGravity = self.gravity;
    
    for (GameObject *o in gameObjects) {
        Vector2D *acceleration = [[o.force multiply: 1./ o.mass] add: currentGravity];
        o.velocity = [o.velocity add: [acceleration multiply: self.timeStep]];
        
        CGFloat angularAcceleration = o.torque * 1./o.inertia;
        o.angularVelocity += angularAcceleration * self.timeStep;
    }
    
    for (GameObject *o in gameObjects) {
        o.center = CGPointMake(o.center.x + o.velocity.x * self.timeStep, o.center.y + o.velocity.y * self.timeStep);
        
        o.angle += o.angularVelocity * self.timeStep;
        
        [o redraw];
    }
}

@end
