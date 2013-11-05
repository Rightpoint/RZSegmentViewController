//
//  RZSegmentViewController.m
//
//  Created by Joe Goullaud on 11/5/12.
//  Copyright (c) 2012 Raizlabs. All rights reserved.
//

#import "RZSegmentViewController.h"
#import "RZViewControllerTransitioningContext.h"

#define kDefaultSegmentControlHeight 44.0

@interface RZSegmentViewController ()

@property (nonatomic, weak) UIViewController *currentViewController;

- (void)setupSegmentViewController;

- (void)updateSegmentControl:(UISegmentedControl*)segmentControl forViewControllers:(NSArray*)viewControllers;

- (void)showSegmentViewControllerAtIndex:(NSUInteger)index;

@end

@implementation RZSegmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupSegmentViewController];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupSegmentViewController];
}

- (void)setupSegmentViewController
{
    // override in sub-class as needed
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.contentView == nil)
    {
        UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
        contentView.autoresizesSubviews = YES;
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        if( self.shouldSegmentedControlOverlapContentView == NO ) {
            // inset content-view frame if desired
            contentView.frame = CGRectMake(contentView.frame.origin.x,
                                           contentView.frame.origin.y + kDefaultSegmentControlHeight,
                                           contentView.frame.size.width,
                                           contentView.frame.size.height - kDefaultSegmentControlHeight);
        }
        [self.view addSubview:contentView];
        [self.view sendSubviewToBack:contentView];
        
        self.contentView = contentView;
    }
    
    if (self.segmentControl == nil)
    {
        UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kDefaultSegmentControlHeight)];
        segmentControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:segmentControl];
        
        self.segmentControl = segmentControl;
    }
    
    [self updateSegmentControl:self.segmentControl forViewControllers:self.viewControllers];
    [self.segmentControl setSelectedSegmentIndex:self.selectedIndex];
    [self showSegmentViewControllerAtIndex:self.selectedIndex];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.segmentControl.userInteractionEnabled = YES;
}

#pragma mark - Properties

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex < self.segmentControl.numberOfSegments)
    {
        [self.segmentControl setSelectedSegmentIndex:selectedIndex];
        [self showSegmentViewControllerAtIndex:selectedIndex];
        _selectedIndex = selectedIndex;
    }
    
    // TODO: Error handling if index is out of bounds?
}

#pragma mark - Private

- (void)updateSegmentControl:(UISegmentedControl*)segmentControl forViewControllers:(NSArray*)viewControllers
{
    [segmentControl removeAllSegments];
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = (UIViewController*)obj;
        [segmentControl insertSegmentWithTitle:vc.title atIndex:idx animated:NO];
    }];
}

- (void)showSegmentViewControllerAtIndex:(NSUInteger)index
{
    [self showSegmentViewControllerAtIndex:index animated:NO];
}

- (void)showSegmentViewControllerAtIndex:(NSUInteger)index animated:(BOOL)animated
{

    if (self.animationTransitioning && animated)
    {
        UIViewController* nextVC = [self.viewControllers objectAtIndex:index];
        RZViewControllerTransitioningContext* transitioningContext = [[RZViewControllerTransitioningContext alloc] initWithFromViewController:self.currentViewController toViewController:nextVC containerView:self.contentView];
        __weak __typeof(self)wself = self;
        transitioningContext.completionBlock = ^(BOOL succeeded, RZViewControllerTransitioningContext* transitioningContext) {
            wself.segmentControl.userInteractionEnabled = YES;
        };
        self.segmentControl.userInteractionEnabled = NO;
        [self.animationTransitioning animateTransition:transitioningContext];
        self.currentViewController = nextVC;
    }
    else
    {
        [self.currentViewController willMoveToParentViewController:nil];
        [self.currentViewController.view removeFromSuperview];
        [self.currentViewController removeFromParentViewController];
        
        self.currentViewController = [self.viewControllers objectAtIndex:index];
        
        [self addChildViewController:self.currentViewController];
        self.currentViewController.view.frame = self.contentView.bounds;
        self.currentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.currentViewController.view];
        [self.currentViewController didMoveToParentViewController:self];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectSegmentAtIndex:)])
        {
            [self.delegate didSelectSegmentAtIndex:index];
        }
    }
}
- (IBAction)segmentControlValueChanged:(id)sender
{
    NSInteger selectedIndex = self.segmentControl.selectedSegmentIndex;

    if (self.delegate && [self.delegate respondsToSelector:@selector(willSelectSegmentAtIndex:currentIndex:)])
    {
        [self.delegate willSelectSegmentAtIndex:selectedIndex currentIndex:self.selectedIndex];
    }

    [self showSegmentViewControllerAtIndex:selectedIndex animated:YES];
    _selectedIndex = selectedIndex;
    
}

@end
