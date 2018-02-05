//
//  WDTabBarController.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDTabBarController.h"
#import "WDTabBar.h"
#import "WDHomeTabBarItem.h"
#import "WDSpeciesTabBarItem.h"
#import "WDAnimTabBarItem.h"
#import "WDShoppingCarTabBarItem.h"
#import "WDMyCenterTabBarItem.h"
#define MallClassKey   @"rootVCClassString"

static WDShoppingCarTabBarItem *_shopTabBarItem;

void SetTabBarItemBadge(NSInteger badge)
{
    if (badge==0) {
        _shopTabBarItem.numLabel.hidden = YES;
    }else{
        _shopTabBarItem.numLabel.hidden = NO;
        _shopTabBarItem.barNum = [NSString stringWithFormat:@"%ld",(long)badge];
    }
}
@interface WDTabBarController ()<UITabBarControllerDelegate>
@property (strong, nonatomic) NSMutableArray *tabBarItemList;
@property (strong, nonatomic) UIView *customTabBar;

@end


@implementation WDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
//    [self.tabBar setBackgroundImage:[UIImage new]];
//    [self.tabBar setShadowImage:[UIImage new]];
    
    WDTabBar * tabBar = [[WDTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    [tabBar setBackgroundImage:[UIImage new]];
    [tabBar setShadowImage:[UIImage new]];
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    CGRect tabBarRect = tabBar.frame;
    
    self.customTabBar = [[UIView alloc] init];
    [_customTabBar setBackgroundColor:[UIColor whiteColor]];
    [_customTabBar setFrame:CGRectMake(0, 0, tabBarRect.size.width, tabBarRect.size.height)];
    UIView * toplineView = [[UIView alloc]init];
    toplineView.backgroundColor = [UIColor getColor:@"9e9e9e"];
    [_customTabBar addSubview:toplineView];
    [toplineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_customTabBar);
        make.height.equalTo(@0.5);
    }];
    [tabBar addSubview:_customTabBar];
    
    
    NSArray *childArray = @[
                            @{MallClassKey  : @"WDHomeVC",
                            },
                            
                            @{MallClassKey  : @"WDSpeciesVC",
                             },
                            
                            @{MallClassKey  : @"WDShoppingCarVC",
                             },
                            @{MallClassKey  : @"WDMyCenterVC",
                             },
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        //        vc.navigationItem.title = ([dict[MallTitleKey] isEqualToString:@"首页"] || [dict[MallTitleKey] isEqualToString:@"分类"]) ? nil : dict[MallTitleKey];
        WDNavigationController *nav = [[WDNavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
        
    }];

    

    
    WDHomeTabBarItem *homeTabBarItem = [[WDHomeTabBarItem alloc] initWithTabBarController:self index:0];
    WDSpeciesTabBarItem *subscribeTabBarItem = [[WDSpeciesTabBarItem alloc] initWithTabBarController:self index:1];
    WDShoppingCarTabBarItem *shopTabBarItem = [[WDShoppingCarTabBarItem alloc] initWithTabBarController:self index:2];
    _shopTabBarItem=shopTabBarItem;
    
    WDMyCenterTabBarItem *myCenterTabBarItem = [[WDMyCenterTabBarItem alloc] initWithTabBarController:self index:3];

    [self.tabBarItemList addObject:homeTabBarItem];
    [self.tabBarItemList addObject:subscribeTabBarItem];
    [self.tabBarItemList addObject:shopTabBarItem];
    [self.tabBarItemList addObject:myCenterTabBarItem];
    CGFloat viewWidth = self.view.bounds.size.width;
    for (WDAnimTabBarItem *barItem in _tabBarItemList) {
        CGFloat itemCenterX = [self centerXOfTabBarItem:barItem];
        [_customTabBar addSubview:barItem];
        [barItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_customTabBar);
            make.centerY.equalTo(_customTabBar);
            make.centerX.equalTo(@(itemCenterX - viewWidth/2));
        }];
    }
    // Do any additional setup after loading the view.
}
- (CGFloat)centerXOfTabBarItem:(WDAnimTabBarItem *)item {
    NSUInteger index = [_tabBarItemList indexOfObject:item];
    CGFloat drawerWidth = self.view.bounds.size.width / _tabBarItemList.count;
    CGFloat centerX = (index+0.5) * drawerWidth;
    return centerX;
}
- (NSMutableArray *)tabBarItemList {
    if (nil == _tabBarItemList) {
        _tabBarItemList = [NSMutableArray array];
    }
    return _tabBarItemList;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
//    self.selectedIndex = tabBarController.selectedIndex;
    
    if(viewController == [tabBarController.viewControllers objectAtIndex:3]){
        self.selectedIndex = 3;
    }else if (viewController == [tabBarController.viewControllers objectAtIndex:2]){
        self.selectedIndex = 2;
    }else if (viewController == [tabBarController.viewControllers objectAtIndex:1]){
        self.selectedIndex = 1;
    }else{
        self.selectedIndex = 0;
    }
    return YES;
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    if (self.selectedIndex ==selectedIndex) {
        if (selectedIndex==0) {
            WDNavigationController *navController = (WDNavigationController *)[self.childViewControllers objectAtIndex:selectedIndex];

//            MainHomeController *mainHomeController = (MainHomeController *)navController.topViewController;
//            [mainHomeController refreshCurrentPage];
        }
    }else{
        
        WDAnimTabBarItem *previousItem = [_tabBarItemList objectAtIndex:self.selectedIndex];
        [previousItem releaseAnim];
        [super setSelectedIndex:selectedIndex];
        WDAnimTabBarItem *currentItem = [_tabBarItemList objectAtIndex:self.selectedIndex];
        [currentItem selectedAnim];
    }
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
