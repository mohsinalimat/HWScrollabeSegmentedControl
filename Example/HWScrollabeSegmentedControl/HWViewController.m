//
//  HWViewController.m
//  HWScrollabeSegmentedControl
//
//  Created by ihomway on 04/12/2017.
//  Copyright (c) 2017 ihomway. All rights reserved.
//

#import "HWViewController.h"
#import <HWScrollabeSegmentedControl/HWScrollableSegmentedControl.h>

@interface HWViewController ()

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	HWScrollableSegmentedControl *segmentedControler = [[HWScrollableSegmentedControl alloc] initWithItems:@[@"NBA", @"中国篮球", @"中国足球", @"世预赛", @"欧冠", @"国际足球", @"欧联", @"英超", @"美洲杯", @"法甲"]];
	segmentedControler.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 44);
	
	segmentedControler.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
	segmentedControler.layer.shadowOffset = CGSizeMake(0, 1);
	segmentedControler.layer.shadowRadius = 2;
	segmentedControler.layer.shadowOpacity = 0.5;
	segmentedControler.apportionsSegmentWidthsByContent = YES;
	
	[self.view addSubview:segmentedControler];
	
	[segmentedControler addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
}

- (void)action:(HWScrollableSegmentedControl *)sender
{
	self.label.text = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
