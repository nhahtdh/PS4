//
//  GameObject.h
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameObject : UIViewController {
    CGPoint center;
    CGFloat angle;
}

@property (nonatomic) CGPoint center;

@property (nonatomic) CGFloat angle;

@end
