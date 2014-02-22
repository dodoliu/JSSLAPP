//
//  LaunchViewController.m
//  JSSL
//
//  Created by LDY on 14-2-22.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

@synthesize launchIView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //launchIView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    //launchIView.image =[UIImage imageNamed:@"Default.png"];
    self.view.backgroundColor = [UIColor redColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
