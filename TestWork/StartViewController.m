//
//  ViewController.m
//  TestWork
//
//  Created by Nikolay Berlioz on 15.04.16.
//  Copyright © 2016 Nikolay Berlioz. All rights reserved.
//

#import "StartViewController.h"
#import "AnimationViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startButton.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 50,
                                   CGRectGetMidY(self.view.bounds) - 25,
                                   100, 50);
    startButton.backgroundColor = [UIColor blueColor];
    
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:startButton];
    
    [startButton addTarget:self action:@selector(actionStartAnimating:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void) actionStartAnimating:(UIButton*)sender
{
    AnimationViewController *controller = [[AnimationViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
