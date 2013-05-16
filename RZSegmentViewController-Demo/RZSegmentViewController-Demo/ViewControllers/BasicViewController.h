//
//  BasicViewController.h
//  RZSegmentViewController-Demo
//
//  Created by Stephen Barnes on 5/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (id)initWithColor:(UIColor*)color withTitle:(NSString*)title;

@end
