//
//  BasicViewController.m
//  RZSegmentViewController-Demo
//
//  Created by Stephen Barnes on 5/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (id)initWithColor:(UIColor*)color withTitle:(NSString*)title
{
    self = [super initWithNibName:@"BasicViewController" bundle:nil];
    if (self)
    {
        [self setTitle:title];
        [self.view setBackgroundColor:color];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.titleLabel setText:self.title];
}

@end
