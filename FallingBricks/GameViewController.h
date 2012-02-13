//
//  ViewController.h
//  FallingBricks
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameEngine.h"

@interface GameViewController : UIViewController {
    GameEngine *engine;
    NSTimer *timer;
    
    NSMutableArray *gameObjectsInGameArea;
}

@property (strong, nonatomic, readonly) GameEngine* engine;

@end
