//
//  GameEngine.m
//  FallingBricks
//
//  Created by  on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameEngine.h"
#import "Matrix2D.h"

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
        /*
        manager = [CMMotionManager new];
        [manager startAccelerometerUpdatesToQueue: [NSOperationQueue currentQueue]
                                      withHandler:
            ^ (CMAccelerometerData *accelerometerData, NSError *error) {
                DLog(@"x:%f y:%f z:%f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
                gravity_ = [Vector2D vectorWith: accelerometerData.acceleration.x * GravityXAxisMultiplier
                                              y: accelerometerData.acceleration.y * GravityYAxisMultiplier];
            }
        ];
        */
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

+ (Matrix2D*) rotationMatrix: (CGFloat) angle {
    return [Matrix2D matrixWithValues:cos(angle) and:sin(angle) and:-sin(angle) and:cos(angle)];
}

+(BOOL) collideGameObject: (GameObject*) a: (GameObject*) b : (CGFloat) timeStep {
    // EFFECTS: Simulate the collision of 2 game objects and modifies velocity and angular
    //          velocity of the objects.
    //          This function returns a boolean for testing purpose and should not be used
    //          in simulation. The return value indicates whether the 2 game objects are
    //          overlapping or not based on the average distance between the incident edges.
    Vector2D *pA = [Vector2D vectorWith: a.center.x y: a.center.y];
    Vector2D *pB = [Vector2D vectorWith: b.center.x y: b.center.y];
    
    // Vector2D *d = [Vector2D vectorWith:b.center.x - a.center.x y:b.center.y - a.center.y];
    Vector2D *d = [pB subtract: pA];
    Vector2D *hA = [Vector2D vectorWith: a.actualSizes.width / 2 y: a.actualSizes.height / 2];
    Vector2D *hB = [Vector2D vectorWith: b.actualSizes.width / 2 y: b.actualSizes.height / 2];
    
    Matrix2D *RA = [GameEngine rotationMatrix: a.angle];
    Matrix2D *RB = [GameEngine rotationMatrix: b.angle];
    
    Vector2D *dA = [[RA transpose] multiplyVector: d];
    Vector2D *dB = [[RB transpose] multiplyVector: d];
    
    Matrix2D *C = [[RA transpose] multiply: RB];
    Vector2D *fA = [[[dA abs] subtract: hA] subtract: [[C abs] multiplyVector: hB]];
    Vector2D *fB = [[[dB abs] subtract: hB] subtract: [[[C transpose] abs] multiplyVector: hA]];
    
    // Check whether the 2 rectangles overlap. Return if they are not overlapping.
    if (fA.x >= 0 || fA.y >= 0 || fB.x >= 0 || fB.y >= 0) {
        DLog(@"No collision %@ and %@. Average incident edge test: %@ %@.", a, b, fA, fB);
        return NO;
    }
    
    Vector2D *n, *nf, *ns;
    CGFloat Df, Ds, Dneg, Dpos;
    
    Vector2D *ni, *p, *h;
    Matrix2D *R;
    Vector2D *v1, *v2;
    
    CGFloat minMagnitude = MIN(MIN(MIN(abs(fA.x), abs(fA.y)), abs(fB.x)), abs(fB.y));
    if (minMagnitude == abs(fA.x)) {
        // Find reference edge
        if (dA.x > 0) {
            n = RA.col1;
        } else {
            n = [RA.col1 negate];
        }
        
        nf = n;
        Df = [pA dot: nf] + hA.x;
        ns = RA.col2;
        Ds = [pA dot: ns];
        Dneg = hA.y - Ds;
        Dpos = hA.y + Ds;
        
        // Find incident edge - first half
        ni = [[[RB transpose] multiplyVector: nf] negate];
        p = pB;
        R = RB;
        h = hB;
    } else if (minMagnitude == abs(fA.y)) {
        if (dA.y > 0) {
            n = RA.col2;
        } else {
            n = [RA.col2 negate];
        }
        
        nf = n;
        Df = [pA dot: nf] + hA.y;
        ns = RA.col1;
        Ds = [pA dot: ns];
        Dneg = hA.x - Ds;
        Dpos = hA.x + Ds;
        
        
        ni = [[[RB transpose] multiplyVector: nf] negate];
        p = pB;
        R = RB;
        h = hB;
    } else if (minMagnitude == abs(fB.x)) {
        if (dB.x > 0) {
            n = RB.col1;
        } else {
            n = [RB.col1 negate];
        }
        
        nf = [n negate];
        Df = [pB dot: nf] + hB.x;
        ns = RB.col2;
        Ds = [pB dot: ns];
        Dneg = hB.y - Ds;
        Dpos = hB.y + Ds;
        
        
        ni = [[[RA transpose] multiplyVector: nf] negate];
        p = pA;
        R = RA;
        h = hA;
        
    } else if (minMagnitude == abs(fB.y)) {
        if (dB.y > 0) {
            n = RB.col2;
        } else {
            n = [RB.col2 negate];
        }
        
        nf = [n negate];
        Df = [pB dot: nf] + hB.y;
        ns = RB.col1;
        Ds = [pB dot: ns];
        Dneg = hB.x - Ds;
        Dpos = hB.x + Ds;
        
        ni = [[[RA transpose] multiplyVector: nf] negate];
        p = pA;
        R = RA;
        h = hA;
        
    } else {
        @throw [NSException exceptionWithName: NSInternalInconsistencyException reason: @"Serious error happened, probably due to NaN value" userInfo: nil];
    }
    
    // Find incident edge - second half
    if (abs(ni.x) > abs(ni.y)) {
        if (ni.x > 0) {
            v1 = [p add: [R multiplyVector: [Vector2D vectorWith: h.x y: -h.y]]];
            v2 = [p add: [R multiplyVector: h]];
        } else { // ni.x <= 0
            v1 = [p add: [R multiplyVector: [Vector2D vectorWith: -h.x y:h.y]]];;
            v2 = [p add: [R multiplyVector: [h negate]]];
        }
    } else { // abs(ni.x) <= abs(ni.y)
        if (ni.y > 0) {
            v1 = [p add: [R multiplyVector: h]];
            v2 = [p add: [R multiplyVector: [Vector2D vectorWith: -h.x y:h.y]]];
        } else { // ni.y <= 0
            v1 = [p add: [R multiplyVector: [h negate]]];
            v2 = [p add: [R multiplyVector: [Vector2D vectorWith: h.x y: -h.y]]];
        }
    }
    
    // First clipping
    Vector2D *v1_, *v2_;
    CGFloat dist1, dist2;
    dist1 = -[ns dot: v1] - Dneg;
    dist2 = -[ns dot: v2] - Dneg;
    
    if (dist1 >= 0 && dist2 >= 0) {
        // The 2 rectangles do not collide
        DLog(@"No collision %@ and %@. First clipping.", a , b);
        return YES;
    } else if (dist1 < 0 && dist2 < 0) {
        v1_ = v1;
        v2_ = v2;
    } else if (dist1 < 0 && dist2 >= 0) {
        v1_ = v1;
        v2_ = [v1 add: [[v2 subtract: v1] multiply: dist1 / (dist1 - dist2)]];
    } else if (dist1 >= 0 && dist2 < 0) {
        v1_ = v2;
        v2_ = [v1 add: [[v2 subtract: v1] multiply: dist1 / (dist1 - dist2)]];
    } else {
        DLog(@"Dist: %f %f",  dist1, dist2);
        @throw [NSException exceptionWithName: NSInternalInconsistencyException reason: @"Serious error happened, probably due to NaN value" userInfo: nil];
    }
    
    // Second clipping
    Vector2D *v1__, *v2__;
    dist1 = [ns dot: v1_] - Dpos;
    dist2 = [ns dot: v2_] - Dpos;
    
    if (dist1 >= 0 && dist2 >= 0) {
        // The 2 rectangles do not collide
        DLog(@"No collision %@ and %@. Second clipping.", a , b);
        return YES;
    } else if (dist1 < 0 && dist2 < 0) {
        v1__ = v1_;
        v2__ = v2_;
    } else if (dist1 < 0 && dist2 >= 0) {
        v1__ = v1_;
        v2__ = [v1_ add: [[v2_ subtract: v1_] multiply: dist1 / (dist1 - dist2)]];
    } else if (dist1 >= 0 && dist2 < 0) {
        v1__ = v2_;
        v2__ = [v1_ add: [[v2_ subtract: v1_] multiply: dist1 / (dist1 - dist2)]];
    }
    
    Vector2D *endPointDiff = [v1__ subtract: v2__];
    if (float_equals(endPointDiff.x, 0) && float_equals(endPointDiff.y, 0)) {
        DLog(@"Contact points are coincidental between %@ and %@", a, b);
        return YES;
    }
    
    // Find contact points
    Vector2D *c[2];
    CGFloat s[2];
    
    s[0] = [nf dot: v1__] - Df;
    c[0] = [v1__ subtract: [nf multiply: s[0]]];
    
    s[1] = [nf dot: v2__] - Df;
    c[1] = [v2__ subtract: [nf multiply: s[1]]];
    
    Vector2D *t;
    t = [n crossZ: 1];
    
    DLog(@"Contact points between %@ and %@: (%f, %f) (%f, %f)", a, b, c[0].x, c[0].y, c[1].y, c[1].y);
    
    CGFloat mn[2], mt[2];
    Vector2D *rA[2], *rB[2];
    
    for (int i = 0; i < 2; i++) {
        rA[i] = [c[i] subtract: pA];
        rB[i] = [c[i] subtract: pB];
        
        mn[i] = 1. / a.mass + 1. / b.mass + 
        ([rA[i] dot: rA[i]] - ([rA[i] dot: n] * [rA[i] dot: n])) / a.inertia + 
        ([rB[i] dot: rB[i]] - ([rB[i] dot: n] * [rB[i] dot: n])) / b.inertia;
        mn[i] = 1. / mn[i];
        
        mt[i] = 1. / a.mass + 1. / b.mass + 
        ([rA[i] dot: rA[i]] - ([rA[i] dot: t] * [rA[i] dot: t])) / a.inertia + 
        ([rB[i] dot: rB[i]] - ([rB[i] dot: t] * [rB[i] dot: t])) / b.inertia;
        mt[i] = 1. / mt[i];    
    }
    
    // Apply impulses at contact points
    for (int l = 0; l < 10; l++) {
        // One iteration
        for (int i = 0; i < 2; i++) {
            if (s[i] < 0) {
                Vector2D *uA, *uB;
                uA = [a.velocity add: [rA[i] crossZ: -a.angularVelocity]];
                uB = [b.velocity add: [rB[i] crossZ: -b.angularVelocity]];
                
                Vector2D *u;
                u = [uB subtract: uA];
                
                CGFloat ut, un;
                un = [u dot: n];
                ut = [u dot: t];

                Vector2D *Pn;
                
                CGFloat bias = fabs(0.05 / timeStep * (0.01 + s[i]));
                
                CGFloat e = sqrt(a.restitution * b.restitution);
                // Pn = [n multiply: mn * (1 + e) * un];
                // Pn = [n multiply: mn * ((1 + e) * un - bias)];
                Pn = [n multiply: MIN(0, mn[i] * ((1 + e) * un - bias))];
                CGFloat dPt = mt[i] * ut;
                
                CGFloat Ptmax = [Pn dot: Pn] * a.friction * b.friction;
                dPt = MAX(-Ptmax, MIN(dPt, Ptmax));
                
                Vector2D *Pt = [t multiply: dPt];
                
                Vector2D *P = [Pn add: Pt];
                
                if ([a canMove]) {
                    a.velocity = [a.velocity add: [P multiply: 1. / a.mass]];
                    a.angularVelocity = a.angularVelocity + [rA[i] cross: P] / a.inertia;
                }
                
                if ([b canMove]) {
                    b.velocity = [b.velocity subtract: [P multiply: 1. / b.mass]];
                    b.angularVelocity = b.angularVelocity - [rB[i] cross: P] / b.inertia; 
                }
            }
        }
    }
    
    DLog("/!\\ Collision detected %@ and %@.", a, b)
    
    return YES;
}

static long count = 0;

-(void) updateGameObjects: (NSArray*) gameObjects {
    // Make sure the same gravity is used throughout
    DLog(@"updateGameObject is called %ld.", count++);
    Vector2D *currentGravity = self.gravity;
    
    for (GameObject *o in gameObjects) {
        if ([o canMove]) {
            Vector2D *acceleration = [[o.force multiply: 1./ o.mass] add: currentGravity];
            o.velocity = [o.velocity add: [acceleration multiply: self.timeStep]];
            
            CGFloat angularAcceleration = o.torque * 1./o.inertia;
            o.angularVelocity += angularAcceleration * self.timeStep;
        }
    }
    
    for (int i = 0; i < gameObjects.count; i++) {
        for (int j = i + 1; j < gameObjects.count; j++) {
            GameObject *a = [gameObjects objectAtIndex: i], *b = [gameObjects objectAtIndex: j];
            if ([a canMove] || [b canMove]) {
                [GameEngine collideGameObject: a: b: self.timeStep];
            }
        }
    }
    
    for (GameObject *o in gameObjects) {
        if ([o canMove]) {
            o.center = CGPointMake(o.center.x + o.velocity.x * self.timeStep, o.center.y + o.velocity.y * self.timeStep);
            
            o.angle += o.angularVelocity * self.timeStep;
            
            [o redraw];
        }
    }
}

@end
