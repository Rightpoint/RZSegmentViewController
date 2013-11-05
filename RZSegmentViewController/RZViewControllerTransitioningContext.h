//
//  RZViewControllerTransitioningContext.h
//  VirginPulse
//
//  Created by Alex Rouse on 11/5/13.
//  Copyright (c) 2013 Virgin. All rights reserved.
//

/** 
 *  A class that is used to use custom transitions with in ChildViewControllers.
 *  Given the From - To - and Container view this class will return what is required
 *  to implement a custom ViewController Transition.
 *
 *  This class will need further testing with a few different animations.
 */

#import <Foundation/Foundation.h>

@interface RZViewControllerTransitioningContext : NSObject <UIViewControllerContextTransitioning>

//Sets if the transition will be animated or not
@property (nonatomic, assign) BOOL animated;

// The parent ViewController.  Used to call didMoveToParentViewController: and other containment methods on the ChildViewControllers.
@property (nonatomic, weak) UIViewController* parentViewController;

// All parameters are required and non can be nil.
- (instancetype)initWithFromViewController:(UIViewController *)fromVC
                          toViewController:(UIViewController *)toVC
                             containerView:(UIView *)containerView;


@end
