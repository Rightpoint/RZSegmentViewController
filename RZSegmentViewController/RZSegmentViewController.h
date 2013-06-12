//
//  RZSegmentViewController.h
//
//  Created by Joe Goullaud on 11/5/12.
//  Copyright (c) 2012 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZSegmentViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic, copy) NSArray *viewControllers;

// whether child view-controllers are allowed to scroll underneath the segmented view
@property (nonatomic, assign) BOOL shouldSegmentedControlOverlapContentView; 

- (IBAction)segmentControlValueChanged:(id)sender;

@end
