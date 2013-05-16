//
//  BasicTableViewController.m
//  RZSegmentViewController-Demo
//
//  Created by Stephen Barnes on 5/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "BasicTableViewController.h"

#define kBasicTableViewCellId               @"kBasicTableViewCellId"
#define kBasicTableViewTopContentOffset     40

@interface BasicTableViewController ()

@property (nonatomic, strong) NSArray* listOfItems;

@end

@implementation BasicTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.listOfItems = @[@"Iceland", @"Greenland", @"Switzerland", @"Norway", @"New Zealand", @"Greece", @"Rome", @"Ireland"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kBasicTableViewCellId];
        self.tableView.contentInset = UIEdgeInsetsMake(kBasicTableViewTopContentOffset, 0, 0, 0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Countries List"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listOfItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBasicTableViewCellId forIndexPath:indexPath];
 
    [cell.textLabel setText:[self.listOfItems objectAtIndex:[indexPath row]]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
