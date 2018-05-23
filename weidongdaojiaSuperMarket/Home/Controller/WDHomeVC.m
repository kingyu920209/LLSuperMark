//
//  WDHomeVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDHomeVC.h"
#import "WDShoppingCarVC.h"
#import "WDHomeTopToolView.h"
#import "WDSlidesShowHeadView.h"
#import "WDGoodsGridCell.h"
#import "WDGridItem.h"
#import "WDYouLikeHeadView.h"
#import "WDGoodsCountDownCell.h"
#import "WDOtherHeadView.h"
#import "WDGoodsOtherCell.h"
#import "WDGoodsOtherItem.h"
#import "WDGoodsActiveVC.h"
#import "GoodsDetailVC.h"
#import "GoodsActiveItem.h"
#import "WDTsetVC.h"
#define GoodsHomeSilderImagesArray @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"]

//NSString *const SHOWTOPTOOLVIEW = @"SHOWTOPTOOLVIEW";
//NSString *const HIDETOPTOOLVIEW = @"HIDETOPTOOLVIEW";

@interface WDHomeVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PYSearchViewControllerDelegate>
/* 顶部按钮 */
@property (nonatomic, strong) WDHomeTopToolView *topToolView;

@property(nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView * headerView;

@property (strong , nonatomic)NSMutableArray<WDGridItem *> *gridItem;

@property (strong , nonatomic)NSMutableArray<GoodsActiveItem *> *otherItem;


@property (strong , nonatomic)NSArray *headerArray;

@property (nonatomic,strong)JQFMDB*db;

@end
/* cell */

static NSString *const WDGoodsGridCellID = @"WDGoodsGridCell";
static NSString *const WDGoodsCountDownCellID = @"WDGoodsCountDownCell";
static NSString *const WDGoodsOtherCellID = @"WDGoodsOtherCell";


/* head */
static NSString *const WDSlidesShowHeadViewID = @"WDSlidesShowHeadView";
static NSString *const WDYouLikeHeadViewID = @"WDYouLikeHeadView";
static NSString *const WDOtherHeadViewID = @"WDOtherHeadView";

@implementation WDHomeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.db = [JQFMDB shareDatabase:@"shopCarGoods.sqlite"];
    //    NSLog(@"last:%ld", (long)[self.db lastInsertPrimaryKeyId:@"shopCarGoods"]);
    if (![self.db jq_isExistTable:@"shopCarGoods"]) {
        [self.db jq_createTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class]];
        
    }
    if ([self.db jq_tableItemCount:@"shopCarGoods"]!=0) {
        
        SetTabBarItemBadge([self.db jq_tableItemCount:@"shopCarGoods"]);
    }
    _gridItem = [WDGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _otherItem = [GoodsActiveItem mj_objectArrayWithFilename:@"GoodsOthe.plist"];

    self.headerArray = @[@"sy_41",@"sy_43"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];

    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.frame = CGRectMake(0, -20, KScreenWidth, KScreenHeight);
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:collectionView];
    self.collectionView=collectionView;
    
    
    [_collectionView registerClass:[WDGoodsGridCell class] forCellWithReuseIdentifier:WDGoodsGridCellID];
    [_collectionView registerClass:[WDGoodsCountDownCell class] forCellWithReuseIdentifier:WDGoodsCountDownCellID];
    [_collectionView registerClass:[WDGoodsOtherCell class] forCellWithReuseIdentifier:WDGoodsOtherCellID];


    
    [_collectionView registerClass:[WDSlidesShowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WDSlidesShowHeadViewID];
    [_collectionView registerClass:[WDYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WDYouLikeHeadViewID];
    [_collectionView registerClass:[WDOtherHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WDOtherHeadViewID];

    
    [_collectionView reloadData];
    
    _topToolView = [[WDHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    
    kWeakSelf(weakSelf);

    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了首页扫一扫");
        WDTsetVC * vc = [WDTsetVC new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了首页分类");
       
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
        NSArray *hotSeaches = @[@"牛奶", @"面包", @"薯片",];
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入商品名称" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            LLog(@"%@",searchText);
        }];
            searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
            searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
      
        searchViewController.delegate = weakSelf;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
        [weakSelf presentViewController:nav animated:YES completion:nil];

    };
 
    [self.view addSubview:_topToolView];
    // Do any additional setup after loading the view.
}
#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _topToolView.hidden = (scrollView.contentOffset.y+20 < 0) ? YES : NO;//判断顶部工具View的显示和隐形

    if (scrollView.contentOffset.y > 44) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SHOWTOPTOOLVIEW" object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HIDETOPTOOLVIEW" object:nil];
    }


}
#pragma mark - <UICollectionViewDataSource>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return _gridItem.count;
    }
    if (section == 1) {
        return 1;
    }
    return _otherItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;

    if (indexPath.section == 0) {//10
        WDGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WDGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
        
    }else if (indexPath.section==1){
        WDGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WDGoodsCountDownCellID forIndexPath:indexPath];
        gridcell = cell;
        
    }else{
        WDGoodsOtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WDGoodsOtherCellID forIndexPath:indexPath];
        GoodsActiveItem * model =_otherItem[indexPath.row];;
        NSArray *count = [self.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
        if (count.count!=0) {
            GoodsActiveItem * numModel =[count firstObject];
            model.goodsNum = numModel.goodsNum;
        }else{
            model.goodsNum = @"0";
        }
        cell.otherItem =model;

        cell.reduceNumBlock = ^(NSString *num) {
            model.goodsNum = num;
            
            if ([model.goodsNum integerValue]==0) {
                [self.db jq_deleteTable:@"shopCarGoods" whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];                
                    SetTabBarItemBadge([self.db jq_tableItemCount:@"shopCarGoods"]);
            }else{
                [self.db jq_updateTable:@"shopCarGoods" dicOrModel:model whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
            }

        };
        cell.addNumBlock = ^(NSString *num) {
            model.goodsNum = num;
            NSArray *count = [self.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
            if (count.count==0) {
                model.goodsSelect = YES;
                [self.db jq_insertTable:@"shopCarGoods" dicOrModel:model];
                SetTabBarItemBadge([self.db jq_tableItemCount:@"shopCarGoods"]);

            }else{
                [self.db jq_updateTable:@"shopCarGoods" dicOrModel:model whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
            }
        };
        gridcell = cell;

    }
    
    
    return gridcell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0||section==1) {
        return UIEdgeInsetsMake(0, 0, 0, 0 );
    }
    
        return UIEdgeInsetsMake(0, 5, 0, 5);//分别为上、左、下、右
    
}
#pragma mark - item宽高

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(KScreenWidth/4 , KScreenWidth/4);
    }
    if (indexPath.section==1) {//推荐
        return CGSizeMake(KScreenWidth, 120);

    }
    return CGSizeMake((KScreenWidth-(5*4))/3, 210);

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section==0) {
            
            WDSlidesShowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WDSlidesShowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            reusableview = headerView;
        }else if (indexPath.section==1){
            WDYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WDYouLikeHeadViewID forIndexPath:indexPath];
            [headerView.likeImageView setImage:[UIImage imageNamed:@"sy_28"]];

//            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs5.gomein.net.cn/T16LLvByZj1RCvBVdK.png"]];
            reusableview = headerView;
        }else{
            WDOtherHeadView * headerView= [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WDOtherHeadViewID forIndexPath:indexPath];
            [headerView.likeImageView setImage:[UIImage imageNamed:self.headerArray[indexPath.section-2]]];
//            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516008635078&di=ff32e189e73a7910092433731b4eb8e0&imgtype=0&src=http%3A%2F%2Fimg2.ali213.net%2Fpicfile%2FNews%2F2017%2F12%2F18%2F584_2017121873535701.jpg"]];
            reusableview = headerView;
        }

    }
//    if (kind == UICollectionElementKindSectionFooter) {
//        if (indexPath.section==0) {

//        }
//
//    }
    return reusableview;
}
#pragma mark - head宽高

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(KScreenWidth, 230); //图片滚动的宽高
    }
    if (section==1) {
        return CGSizeMake(KScreenWidth, 40);  //推荐适合的宽高

    }
    return CGSizeMake(KScreenWidth, 110);
}
#pragma mark - foot宽高

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return CGSizeZero;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//10
        WDGoodsActiveVC *vc = [WDGoodsActiveVC new];
        [self.navigationController pushViewController:vc animated:YES];

        LLog(@"点击了9个属性第%zd",indexPath.row);
    }else{
        GoodsDetailVC * goodDetail = [[GoodsDetailVC alloc] init];
        [self.navigationController pushViewController:goodDetail animated:YES];
        LLog(@"section =%zd,row=%zd",indexPath.section,indexPath.row);
    }
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
