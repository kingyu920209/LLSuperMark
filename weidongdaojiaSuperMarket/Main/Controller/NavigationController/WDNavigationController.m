//
//  WDNavigationController.m
//  weidongdaojiaC
//
//  Created by 嘚嘚以嘚嘚 on 2017/7/19.
//  Copyright © 2017年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDNavigationController.h"

@interface WDNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WDNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    
    self.interactivePopGestureRecognizer.enabled = YES;
    
    
    
    // 导航条半透明光泽
    self.navigationBar.translucent = YES;
    //    设置导航栏为透明
    [self.navigationBar setBackgroundImage:[self imageByApplyingAlpha:1 image:[self imageWithColor:[UIColor whiteColor]]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.userInteractionEnabled = YES;
    
//    self.edgesForExtendedLayout = YES;
//    self.automaticallyAdjustsScrollViewInsets = YES;

    self.navigationBar.shadowImage = [[UIImage alloc]init];

}



- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *    @brief    由颜色转变成图片
 *
 *    @param     color     指定的颜色
 *
 *    @return    返回颜色生成的图片
 */
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

// 手势触发消息
- (void)handleNavigationTransition:(UIGestureRecognizer*)recognizer
{
    
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if (self.childViewControllers.count==1) {
//        return NO;
//    }
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
