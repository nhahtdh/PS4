//
//  ViewController.m
//  FallingBricks
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "GameObject.h"

@implementation GameViewController

@synthesize engine = engine_;

- (void)updateGameObjects: (NSTimer*) timer {
    [self.engine updateGameObjects: [NSArray arrayWithArray: gameObjectsInGameArea]];
}

- (void)startButtonPressed: (id) sender {
    // NOTE: This function is supposed to be
    //       (IBAction)startButtonPresses: (id)sender in PS5
    //       In PS4, this will be called by viewDidLoad function directly to
    //       simulate user pressing start button.
    timer = 
    [NSTimer scheduledTimerWithTimeInterval: self.engine.timeStep 
                                     target: self 
                                   selector: @selector(updateGameObjects:)
                                   userInfo: nil
                                    repeats: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)setUpGameObject {
    // NOTE: This is a functiont that only exists in PS4
    GameObject *o;
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(200, 100)
                                   center: CGPointMake(400, 400) 
                                    angle: degree_to_radian(0)
                                    scale: 1.0
                                     mass: 5
                                 friction: 0.5
                              restitution: 0.8
                                  canMove: YES];
    o.name = @"Gray object";
    [o.view setBackgroundColor: [UIColor grayColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(100, 100)
                                   center: CGPointMake(100, 100) 
                                    angle: degree_to_radian(60)
                                    scale: 1.2
                                     mass: 2
                                 friction: 0.
                              restitution: 1.
                                  canMove: YES];
    o.name = @"Cyan object";
    [o.view setBackgroundColor: [UIColor cyanColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(250, 35)
                                   center: CGPointMake(500, 600) 
                                    angle: degree_to_radian(20)
                                    scale: 1.0
                                     mass: 2
                                 friction: 0.5
                              restitution: 0.5
                                  canMove: YES];
    o.name = @"Green object";
    [o.view setBackgroundColor: [UIColor greenColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(50, 50) 
                                   center: CGPointMake(400, 300)
                                    angle: degree_to_radian(-20) 
                                    scale: 1
                                     mass: 1 
                                 friction: 0.2 
                              restitution: 0.7
                                  canMove: YES];
    o.name = @"Yellow object";
    [o.view setBackgroundColor: [UIColor yellowColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(250, 40) 
                                   center: CGPointMake(550, 200)
                                    angle: degree_to_radian(80) 
                                    scale: 1
                                     mass: 3
                                 friction: 1 
                              restitution: 0 
                                  canMove: YES];
    o.name = @"Purple object";
    [o.view setBackgroundColor: [UIColor purpleColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(150, 90) 
                                   center: CGPointMake(100, 800)
                                    angle: degree_to_radian(80) 
                                    scale: 1
                                     mass: 0.5
                                 friction: 0 
                              restitution: 0.8 
                                  canMove: YES];
    o.name = @"Orange object";
    [o.view setBackgroundColor: [UIColor orangeColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
}

- (void)setUpWalls {
    GameObject *o;
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(500, 1200)
                                   center: CGPointMake(-245, 1004 / 2)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.7
                              restitution: 0.2
                                  canMove: NO];
    o.name = @"Left wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(500, 1200)
                                   center: CGPointMake(767 + 245, 1004 / 2)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.7
                              restitution: 0.2
                                  canMove: NO];
    o.name = @"Right wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(1000, 500)
                                   center: CGPointMake(768 / 2, -245)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.7
                              restitution: 0.2
                                  canMove: NO];
    o.name = @"Top wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(1000, 500)
                                   center: CGPointMake(768 / 2, 1003 + 245)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.7
                              restitution: 0.2
                                  canMove: NO];
    o.name = @"Bottom wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    gameObjectsInGameArea = [NSMutableArray array];
    
    [self setUpWalls];
    [self setUpGameObject];
    
    engine_ = [[GameEngine alloc] init];
    // Simulate user pressing start button
	[self startButtonPressed: self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
