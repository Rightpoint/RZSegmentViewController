//
//  ViewController.m
//  RZSegmentViewController-Demo
//
//  Created by Stephen Barnes on 5/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "MainViewController.h"
#import "BasicViewController.h"
#import "BasicTableViewController.h"
#import "RZSegmentViewController.h"

#define kRZSegementDemoVCTitle1     @"White VC"
#define kRZSegementDemoVCTitle2     @"Blue VC"

@interface MainViewController ()

@property (nonatomic, strong) RZSegmentViewController* segmentVC;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    BasicViewController* basicVC1 = [[BasicViewController alloc] initWithColor:[UIColor whiteColor] withTitle:kRZSegementDemoVCTitle1];
    BasicViewController* basicVC2 = [[BasicViewController alloc] initWithColor:[UIColor blueColor] withTitle:kRZSegementDemoVCTitle2];
    BasicTableViewController* tableVC = [[BasicTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    self.segmentVC = [[RZSegmentViewController alloc] init];
    self.segmentVC.viewControllers = @[basicVC1, basicVC2, tableVC];
    self.segmentVC.shouldSegmentedControlOverlapContentView = NO; // note this property defaults to YES for legacy app support
    
    [self addChildViewController:self.segmentVC];
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    [self.segmentVC didMoveToParentViewController:self];
}

@end
