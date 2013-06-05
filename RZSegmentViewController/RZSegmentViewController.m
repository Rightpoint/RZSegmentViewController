//
//  RZSegmentViewController.m
//
//  Created by Joe Goullaud on 11/5/12.
//  Copyright (c) 2012 Raizlabs. All rights reserved.
//

#import "RZSegmentViewController.h"

#define kDefaultSegmentControlHeight 44.0

@interface RZSegmentViewController ()

@property (nonatomic, assign) NSUInteger selectedIndex;
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
        self.shouldSegmentedControlOverlapContentView = YES; // unfortunately, default to YES to support legacy usage
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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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
        segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        [segmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self.view addSubview:segmentControl];
        
        self.segmentControl = segmentControl;
    }
    
    [self updateSegmentControl:self.segmentControl forViewControllers:self.viewControllers];
    [self.segmentControl setSelectedSegmentIndex:self.selectedIndex];
    [self showSegmentViewControllerAtIndex:self.selectedIndex];
}

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
    [self.currentViewController willMoveToParentViewController:nil];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
    
    self.currentViewController = [self.viewControllers objectAtIndex:index];
    
    [self addChildViewController:self.currentViewController];
    self.currentViewController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.currentViewController.view];
    [self.currentViewController didMoveToParentViewController:self];
}

- (IBAction)segmentControlValueChanged:(id)sender
{
    [self showSegmentViewControllerAtIndex:self.segmentControl.selectedSegmentIndex];
    self.selectedIndex = self.segmentControl.selectedSegmentIndex;
}

@end
