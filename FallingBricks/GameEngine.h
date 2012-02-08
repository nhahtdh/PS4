//
//  GameEngine.h
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"

@interface GameEngine : NSObject<UIAccelerometerDelegate> {
    Vector2D *gravitation;
}

@property (strong, nonatomic, readonly) Vector2D* gravitation;

-(void) updateGameObjects: (NSArray*) gameObjects withTimeStep: (CGFloat) dt;

@end
