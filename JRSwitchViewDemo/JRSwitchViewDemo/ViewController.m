//
//  ViewController.m
//  JRSwitchViewDemo
//
//  Copyright © 2017年 lei JR. All rights reserved.
//

#import "ViewController.h"

#import "JRSwitchView.h"

@interface ViewController () <JRSwitchViewDetegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    JRSwitchView * switchView = [[JRSwitchView alloc] initWithFrame:CGRectMake(100, 100, 80, 30)];
    switchView.leftText = @"开";
    switchView.rightText = @"关";
    switchView.delegate = self;
    switchView.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:switchView];
    
    
    JRSwitchView * switchView1 = [[JRSwitchView alloc] initWithFrame:CGRectMake(100, 200, 80, 30)];
    switchView1.leftText = @"执行";
    switchView1.rightText = @"停止";
    switchView1.leftColorText = [UIColor redColor];
    switchView1.rightColorText = [UIColor blueColor];
    switchView1.on = YES;
    switchView1.font = [UIFont systemFontOfSize:12.0f];
    switchView1.onTintColor = [UIColor cyanColor];
    switchView1.offTintColor = [UIColor grayColor];
    [self.view addSubview:switchView1];
    
    
}


- (void)wh_switchView:(JRSwitchView *)swithchView {
    NSLog(@"%zd",swithchView.on);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
