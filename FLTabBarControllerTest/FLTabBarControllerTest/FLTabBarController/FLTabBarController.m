//
//  MyTbaBarViewController.m
//  test1
//
//  Created by apple on 15-4-16.
//  Copyright (c) 2015年 HikVision. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define BARHEIGHT 49

#import "FLTabBarController.h"

@interface FLTabBarController (){
    NSMutableArray *itemBtnArray;//用于存放itemBtn
}

@end

@implementation FLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    itemBtnArray = [[NSMutableArray alloc]initWithCapacity:2];
    [self initUI];
}

-(void)initUI{
    self.tabBar.hidden = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _tintColor = [UIColor redColor];
    
    _barView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - BARHEIGHT, [UIScreen mainScreen].bounds.size.width, BARHEIGHT)];
    [_barView setBackgroundColor:[UIColor colorWithRed:240.0f/255 green:240.0f/255 blue:240.0f/255 alpha:1.0f]];
    [self.view addSubview:_barView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithRed:200.0f/255 green:200.0f/255 blue:200.0f/255 alpha:1.0f]];
    [_barView addSubview:lineView];
}

//设置viewcontrollers时设置按钮
-(void)setViewControllers:(NSArray *)viewControllers{
    [super setViewControllers:viewControllers];
    for (NSInteger i = 0; i < self.viewControllers.count; i++) {
        UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH/self.viewControllers.count, 0, SCREEN_WIDTH/self.viewControllers.count, BARHEIGHT)];
        [itemBtn addTarget:self action:@selector(itemBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.tag = i;
        [_barView addSubview:itemBtn];
        
        UIImageView *itemImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        itemImage.center = CGPointMake(itemBtn.frame.size.width/2, 20);
        [itemImage setImage:[UIImage imageNamed:[_itemImages objectAtIndex:i]]];
        //        [itemImage setBackgroundColor:[UIColor redColor]];
        [itemBtn addSubview:itemImage];
        
        UILabel *itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(itemBtn.frame), 12)];
        itemLabel.center = CGPointMake(itemBtn.frame.size.width/2, itemImage.center.y + CGRectGetHeight(itemImage.frame)/2+6);
        if (_itemTitles.count == 0) {
            [itemLabel setText:((UIViewController *)self.viewControllers[i]).title];
        }else{
            [itemLabel setText:[_itemTitles objectAtIndex:i]];
        }
        [itemLabel setTextColor:[UIColor grayColor]];
        [itemLabel setTextAlignment:NSTextAlignmentCenter];
        [itemLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [itemBtn addSubview:itemLabel];
        
        UILabel *badgeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        badgeLabel.center = CGPointMake(itemImage.center.x+CGRectGetWidth(itemImage.frame)/2-3, itemImage.center.y-CGRectGetHeight(itemImage.frame)/2+3);
        badgeLabel.layer.cornerRadius = 6;
        badgeLabel.clipsToBounds = YES;
        [badgeLabel setBackgroundColor:[UIColor redColor]];
        [badgeLabel setTextColor:[UIColor whiteColor]];
        badgeLabel.hidden = YES;
        [badgeLabel setTextAlignment:NSTextAlignmentCenter];
        [badgeLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [itemBtn addSubview:badgeLabel];
        
        [itemBtnArray addObject:itemBtn];
    }
    self.selectedIndex = 0;
}

-(void)itemBtnClicked:(UIButton *)itemBtn{
    if (itemBtn.tag == self.selectedIndex) {
        return;
    }
    [UIView animateWithDuration:0.1f animations:^{
       itemBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
    } completion:^(BOOL finish){
        [UIView animateWithDuration:0.1f animations:^{
            itemBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
        } completion:^(BOOL finish){
            [UIView animateWithDuration:0.1f animations:^{
                itemBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
            } completion:^(BOOL finish){
                
            }];
        }];
    }];
    
    self.selectedIndex = itemBtn.tag;
}

//设置标题
-(void)setItemTitles:(NSArray *)itemTitles{
    for (NSInteger i = 0; i<itemBtnArray.count; i++) {
        [((UILabel *)[((UIButton *)[itemBtnArray objectAtIndex:i]).subviews objectAtIndex:1]) setText:[itemTitles objectAtIndex:i]];
        if (i == self.selectedIndex) {
            [((UILabel *)[((UIButton *)[itemBtnArray objectAtIndex:i]).subviews objectAtIndex:1]) setTextColor:[UIColor redColor]];
        }
    }
    _itemTitles = itemTitles;
}

//设置图标
-(void)setItemImages:(NSArray *)itemImages{
    for (NSInteger i = 0; i<itemBtnArray.count; i++) {
        [((UIImageView *)[((UIButton *)[itemBtnArray objectAtIndex:i]).subviews objectAtIndex:0]) setImage:[UIImage imageNamed:[itemImages objectAtIndex:i]]];
    }
    _itemImages = itemImages;
    self.selectedIndex = self.selectedIndex;
}

-(void)setItemSelectedImages:(NSArray *)itemSelectedImages{
    for (NSInteger i = 0; i<itemBtnArray.count; i++) {
        if (i == self.selectedIndex) {
            [((UIImageView *)[((UIButton *)[itemBtnArray objectAtIndex:i]).subviews objectAtIndex:0]) setImage:[UIImage imageNamed:[itemSelectedImages objectAtIndex:i]]];
        }
    }
    _itemSelectedImages = itemSelectedImages;
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    for (UIButton *selectedBtn in itemBtnArray) {
        if (selectedBtn.tag == selectedIndex) {
            UIImageView *imageView = (UIImageView *)[selectedBtn.subviews objectAtIndex:0];
            UIImage *image = nil;
            if (_itemSelectedImages.count == 0) {
                image = [self getImage:[UIImage imageNamed:[_itemImages objectAtIndex:selectedBtn.tag]] withTintColor:_tintColor];
            }else{
                image = [UIImage imageNamed:[_itemSelectedImages objectAtIndex:selectedBtn.tag]];
            }
            [imageView setImage:image];
            
            [((UILabel *)[selectedBtn.subviews objectAtIndex:1]) setTextColor:_tintColor];
        }else{
            [((UIImageView *)[selectedBtn.subviews objectAtIndex:0]) setImage:[UIImage imageNamed:[_itemImages objectAtIndex:selectedBtn.tag]]];
            [((UILabel *)[selectedBtn.subviews objectAtIndex:1]) setTextColor:[UIColor grayColor]];
        }
    }
}


//自定义图片的颜色 kCGBlendModeOverlay
-(UIImage *)getImage:(UIImage *)image withTintColor:(UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

//设置角标
-(void)setBadgeValue:(NSString *)badgeValue withIndex:(NSInteger)index{
    if (index > itemBtnArray.count) {
        return;
    }
    UIButton *badgeBtn = [itemBtnArray objectAtIndex:index];
    UILabel *badgeLabel = (UILabel *)[badgeBtn.subviews objectAtIndex:2];
    if (badgeValue == nil) {
        badgeLabel.hidden = YES;
    }else{
        badgeLabel.hidden = NO;
        [badgeLabel setText:badgeValue];
        if (badgeValue.length > 1) {
            [badgeLabel sizeToFit];
        }
    }
}

-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    self.selectedIndex = self.selectedIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
