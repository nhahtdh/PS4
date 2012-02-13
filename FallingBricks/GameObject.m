//
//  GameObject.m
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize name;

// @synthesize sizes;

- (CGSize) actualSizes {
    return CGSizeMake(sizes.width * self.scale, sizes.height * self.scale);
}

@synthesize center;
@synthesize angle;

@synthesize scale;

@synthesize canMove;
@synthesize mass;
@synthesize friction;
@synthesize restitution;

- (CGFloat) inertia {
    return (self.actualSizes.width * self.actualSizes.width + self.actualSizes.height * self.actualSizes.height) * self.mass / 12.;
}

@synthesize force;
@synthesize torque;

@synthesize velocity;
@synthesize angularVelocity;

-(id) initWithSizes:(CGSize)s center:(CGPoint)c angle:(CGFloat)a scale: (CGFloat) sc
               mass:(CGFloat)m friction:(CGFloat)f restitution:(CGFloat)r
            canMove:(BOOL)moveability {
    if (self = [super init]) {
        DLog(@"%f", a);
        sizes = s;
        center = c;
        angle = a;
        scale = sc;
        canMove = moveability;
        mass = m;
        friction = f;
        restitution = r;
        
        force = [Vector2D initZero];
        torque = 0.;
        velocity = [Vector2D initZero];
        angularVelocity = 0.;
        
        name = @"Default name";
        
        [self.view setFrame: CGRectMake(0, 0, sizes.width, sizes.height)];
        [self redraw];
    }
    return self;
}

-(void) redraw {
    // The sequence: setFrame, setTransform, setFrame, setTransform will cause the image to deform.
    // [self.view setFrame: CGRectMake(0, 0, sizes.width, sizes.height)];
    [self.view setCenter: self.center];
    DLog(@"Angle: %f Center: (%f, %f)", self.angle, self.view.center.x, self.view.center.y);
    [self.view setTransform: CGAffineTransformRotate(CGAffineTransformMakeScale(self.scale, self.scale), self.angle)];
}

-(NSString*) description {
    return [NSString stringWithFormat: @"<GameObject name:/%@/ velocity:%@ angularVelocity:%f>", self.name, self.velocity, self.angularVelocity];
}












/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 
 - (void)didReceiveMemoryWarning
 {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Release any cached data, images, etc that aren't in use.
 }
 */

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

/*
 - (void)viewDidUnload
 {
 [super viewDidUnload];
 // Release any retained subviews of the main view.
 // e.g. self.myOutlet = nil;
 }
 */

/*
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 // Return YES for supported orientations
 return YES;
 }
 */

@end
