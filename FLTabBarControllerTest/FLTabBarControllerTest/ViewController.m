//
//  ViewController.m
//  FLTabBarControllerTest
//
//  Created by apple on 15/5/8.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import "ViewController.h"
#import "Tab1ViewController.h"
#import "Tab2ViewController.h"
#import "Tab3ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Tab1ViewController *tab1 = [[Tab1ViewController alloc]init];
    UINavigationController *tab1Nav = [[UINavigationController alloc]initWithRootViewController:tab1];
    Tab2ViewController *tab2 = [[Tab2ViewController alloc]init];
    Tab3ViewController *tab3 = [[Tab3ViewController alloc]init];
    
    self.viewControllers = @[tab1Nav,tab2,tab3];
    self.itemTitles = @[@"tab1",@"tab2",@"tab3"];//下边标题
    self.itemImages = @[@"tab_visitor",@"tab_workspace",@"tab_more"];//图标
    self.tintColor = [UIColor magentaColor];//选中后的颜色
    
    [self setBadgeValue:@"10" withIndex:1];//设置角标
    
//    self.barView  navigationContoller跳转时获取barView设置隐藏
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
