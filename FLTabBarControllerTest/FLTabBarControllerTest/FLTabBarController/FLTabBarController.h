//
//  MyTbaBarViewController.h
//  test1
//
//  Created by apple on 15-4-16.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTabBarController : UITabBarController

@property(nonatomic,retain)NSArray *itemImages;//tabbar显示图片
@property(nonatomic,retain)NSArray *itemSelectedImages;//tabbar选中后图片
@property(nonatomic,retain)NSArray *itemTitles;//bar标题
@property(nonatomic,retain)UIColor  *tintColor;//选中后图标字体的颜色
@property(nonatomic,retain)UIView   *barView;//工具栏
-(void)setBadgeValue:(NSString *)badgeValue withIndex:(NSInteger)index;
@end
