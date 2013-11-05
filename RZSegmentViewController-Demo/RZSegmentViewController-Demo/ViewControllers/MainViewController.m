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

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#import "RZAnimationTransition.h"
#endif

#define kRZSegementDemoVCTitle1     @"White VC"
#define kRZSegementDemoVCTitle2     @"Blue VC"

@interface MainViewController () <RZSegmentViewControllerDelegate>

@property (nonatomic, strong) RZSegmentViewController* segmentVC;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
@property (strong, nonatomic) RZAnimationTransition* animatedTransition;
#endif

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
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    
    self.animatedTransition = [[RZAnimationTransition alloc] init];
    [self.segmentVC setAnimationTransitioning:self.animatedTransition];
    self.segmentVC.delegate = self;
#endif
    [self addChildViewController:self.segmentVC];
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    [self.segmentVC didMoveToParentViewController:self];
}

- (void)willSelectSegmentAtIndex:(NSUInteger)index currentIndex:(NSUInteger)currentIndex
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    if (currentIndex > index)
    {
        self.animatedTransition.isLeft = YES;
    }
    else
    {
        self.animatedTransition.isLeft = NO;
    }
#endif
}

@end
