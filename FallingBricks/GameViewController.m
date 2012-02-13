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
                                 friction: 0.
                              restitution: 1.
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
}

- (void)setUpWalls {
    GameObject *o;
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(1000, 1200)
                                   center: CGPointMake(-495, 1004 / 2)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.8
                              restitution: 0.3
                                  canMove: NO];
    o.name = @"Left wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(1000, 1200)
                                   center: CGPointMake(767 + 495, 1004 / 2)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.8
                              restitution: 0.3
                                  canMove: NO];
    o.name = @"Right wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(1000, 1000)
                                   center: CGPointMake(768 / 2, -495)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.8
                              restitution: 0.3
                                  canMove: NO];
    o.name = @"Top wall";
    [o.view setBackgroundColor: [UIColor redColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(1000, 1000)
                                   center: CGPointMake(768 / 2, 1003 + 495)
                                    angle: 0 
                                    scale: 1.0
                                     mass: INFINITY
                                 friction: 0.8
                              restitution: 0.3
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
    
    // Simulate user pressing start button
    engine_ = [[GameEngine alloc] init];
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
