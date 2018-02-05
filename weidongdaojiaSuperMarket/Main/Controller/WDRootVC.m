//
//  WDRootVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/9.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDRootVC.h"

@interface WDRootVC ()

@end

@implementation WDRootVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.childViewControllers.count>1) {
        self.tabBarController.tabBar.hidden = YES;

    }else{
        self.tabBarController.tabBar.hidden = NO;

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageByApplyingAlpha:1 image:[self imageWithColor:[UIColor whiteColor]]] forBarMetrics:UIBarMetricsDefault];

    
    if (self.navigationController.childViewControllers.count>1) {
//        UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
//        [leftButton setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
        
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] landscapeImagePhone:nil style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarAction)];
        self.navigationItem.leftBarButtonItem = leftItem;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

//[[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    }else{


    }
    // Do any additional setup after loading the view.
}
-(void)leftBarAction{
    [self.navigationController popViewControllerAnimated:YES];
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
