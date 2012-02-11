//
//  GameObject.m
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

- (CGSize) sizes {
    return CGSizeMake(sizes.width * self.scale, sizes.height * self.scale);
}

@synthesize center;
@synthesize angle;
@synthesize scale;

@synthesize mass;

- (CGFloat) inertia {
    CGSize currentSizes = self.sizes;
    return (currentSizes.width * currentSizes.width + currentSizes.height * currentSizes.height) * self.mass / 12.;
}

@synthesize force;
@synthesize torque;

@synthesize velocity;
@synthesize angularVelocity;

-(id) initWithSizes:(CGSize)s center:(CGPoint)c angle:(CGFloat)a mass:(CGFloat)m {
    if (self = [super init]) {
        sizes = s;
        center = c;
        angle = a;
        scale = 1.0;
        mass = m;
        
        force = [Vector2D initZero];
        torque = 0.;
        velocity = [Vector2D initZero];
        angularVelocity = 0.;
        
        [self redraw];
    }
    return self;
}

-(void) redraw {
    [self.view setFrame: CGRectMake(0, 0, self.sizes.width, self.sizes.height)];
    [self.view setCenter: self.center];
    [self.view setTransform: CGAffineTransformTranslate(CGAffineTransformMakeRotation(self.angle), self.scale, self.scale)];
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
