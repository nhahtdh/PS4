//
//  ViewController.m
//  FallingBricks
//
//  Created by  on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GameObject.h"

@implementation ViewController

@synthesize engine = engine_;

- (void)updateGameObjects: (NSTimer*) timer {
    [self.engine updateGameObjects: gameObjectsInGameArea];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    engine_ = [[GameEngine alloc] init];
    
    gameObjectsInGameArea = [NSMutableArray array];
    
    GameObject *o;
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(200, 100)
                                   center: CGPointMake(200, 300) 
                                    angle: degree_to_radian(0)
                                     mass: 5];
    [o.view setBackgroundColor: [UIColor grayColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
    
    o = [[GameObject alloc] initWithSizes: CGSizeMake(50, 50)
                                   center: CGPointMake(100, 100) 
                                    angle: degree_to_radian(60)
                                     mass: 1];
    [o.view setBackgroundColor: [UIColor cyanColor]];
    [self.view addSubview: o.view];
    [gameObjectsInGameArea addObject: o];
    
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
