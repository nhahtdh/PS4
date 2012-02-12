//
//  GameEngine.h
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"

double reciprocal(double x);

@interface GameEngine : NSObject<UIAccelerometerDelegate> {
    NSTimeInterval timeStep;
    Vector2D *gravity;
    // CMMotionManager *manager;
}

@property (readonly) NSTimeInterval timeStep;
@property (strong, nonatomic, readonly) Vector2D* gravity;

-(void) updateGameObjects: (NSArray*) gameObjects;

@end
