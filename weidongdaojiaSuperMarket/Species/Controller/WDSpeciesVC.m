//
//  WDSpeciesVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDSpeciesVC.h"
#import "LeftCategoryCell.h"
#import "LeftCategoryItem.h"
#import "TopCategoryCell.h"
#import "CategoryGoodsCell.h"
#import "GoodsActiveItem.h"
static NSString *const LeftCategoryCellID = @"LeftCategoryCell";
static NSString *const TopCategoryCellID = @"TopCategoryCell";
static NSString *const CategoryGoodsCellID = @"CategoryGoodsCell";

@interface WDSpeciesVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,PYSearchViewControllerDelegate>
{
    NSInteger oldOffset;

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) UICollectionView * topCollectionView;
@property (nonatomic,strong) UIView * toolView;
@property (strong , nonatomic)NSMutableArray<LeftCategoryItem *> *goodsItem;
@property (nonatomic,strong)NSMutableArray<LeftCategoryItem *> *topItem;
@property (nonatomic,strong)NSMutableArray<GoodsActiveItem *> *categoryGoodsItem;
@property (nonatomic,strong)UIButton *searchButton;
@property (nonatomic,strong)JQFMDB*db;

@end

@implementation WDSpeciesVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//        _collectionView.frame = CGRectMake(92, 64+38, KScreenWidth-92, KScreenHeight-64-38);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator=NO;
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topCollectionView.mas_bottom);
            make.left.equalTo(self.tableView.mas_right);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        [_collectionView registerClass:[CategoryGoodsCell class] forCellWithReuseIdentifier:CategoryGoodsCellID];

    }
    return _collectionView;
}
-(UICollectionView *)topCollectionView{
    if (!_topCollectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _topCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _topCollectionView.delegate = self;
        _topCollectionView.dataSource = self;
        _topCollectionView.showsVerticalScrollIndicator=NO;
        [self.view addSubview:_topCollectionView];
        int value = self.topItem.count % (3);
        NSInteger inte = self.topItem.count/3;

        [_topCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.toolView.mas_bottom);
            make.left.equalTo(self.tableView.mas_right);
            make.right.equalTo(self.view);
//            make.height.equalTo(@78);
            if (value==0) {
                make.height.equalTo(@(inte*34+10));
            }else{
                make.height.equalTo(@((inte+1)*34+10));
            }
        }];
        [_topCollectionView registerClass:[TopCategoryCell class] forCellWithReuseIdentifier:TopCategoryCellID];

    }
    return _topCollectionView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 92, KScreenHeight) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[LeftCategoryCell class] forCellReuseIdentifier:LeftCategoryCellID];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.db = [JQFMDB shareDatabase:@"shopCarGoods.sqlite"];
    
    oldOffset= -64;
    self.view.backgroundColor = [UIColor whiteColor];

    self.tableView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    

    self.goodsItem = [LeftCategoryItem mj_objectArrayWithFilename:@"LeftCategory.plist"];
    self.topItem = [LeftCategoryItem mj_objectArrayWithFilename:@"TopCategory.plist"];
    self.categoryGoodsItem = [GoodsActiveItem mj_objectArrayWithFilename:@"CategoryGoods.plist"];
    
    

    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    

    [self addNavigationBar];
    
    [self setToolView];
    self.topCollectionView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    [self.topCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UICollectionViewScrollPositionTop)];
    self.collectionView.backgroundColor = [UIColor getColor:@"f1f2f6"];

}

-(void)setToolView{
    UIView * toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    toolView.frame = CGRectMake(92, 64, KScreenWidth-92, 38);
    [self.view addSubview:toolView];
    self.toolView = toolView;
    NSArray * titlearray = @[@"默认排序",@"按价格",@"销量排序"];
    for (int a=0; a<titlearray.count; a++) {
        UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:titlearray[a] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor getColor:@"333333"] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor getColor:@"8dc445"] forState:(UIControlStateSelected)];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [toolView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(toolView).offset(a*(KScreenWidth-92)/3);
            make.top.bottom.equalTo(toolView);
            make.width.equalTo(@((KScreenWidth-92)/3));
        }];

    }
     UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor getColor:@"dcdcdc"];
    [toolView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolView).offset(10);
        make.right.equalTo(toolView).offset(-10);
        make.bottom.equalTo(toolView);
        make.height.equalTo(@0.5);
    }];
    
}
-(void)addNavigationBar{
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    //    topView.frame = CGRectMake(0, 0, KScreenWidth, 64);
    [self.navigationController.navigationBar addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.navigationController.navigationBar);
    }];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"搜索" forState:0];
    [_searchButton setTitleColor:[UIColor getColor:@"333333"] forState:0];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_searchButton setImage:[UIImage imageNamed:@"group_home_search_gray"] forState:0];
    _searchButton.tintColor = [UIColor getColor:@"333333"];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * 10, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    _searchButton.backgroundColor = [UIColor getColor:@"f1f2f6"];
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_searchButton];
    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView);
        make.height.equalTo(@28);
        make.left.equalTo(topView).offset(13);
        make.right.equalTo(topView).offset(-45);
    }];
    [_searchButton layoutIfNeeded];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_searchButton.bounds cornerRadius:16];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    _searchButton.layer.mask = layer;


}
-(void)searchButtonClick{
    NSArray *hotSeaches = @[@"牛奶", @"面包", @"薯片",];
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入商品名称" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        LLog(@"%@",searchText);
    }];
    searchViewController.hotSearchStyle = PYHotSearchStyleBorderTag;
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    
    searchViewController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - collection view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.topCollectionView) {
        
        return self.topItem.count;
    }else{
        return self.categoryGoodsItem.count;

    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.topCollectionView) {
    
        return CGSizeMake((KScreenWidth -92 - (15 * (3 +1)))/3, 24);
    }
    return CGSizeMake(KScreenWidth -92, 94);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.topCollectionView) {
        return UIEdgeInsetsMake(10, 15, 10, 15);//分别为上、左、下、右
    }
    return UIEdgeInsetsMake(0, 0, 0, 0 );
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    
    if (collectionView == self.topCollectionView) {
        TopCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TopCategoryCellID forIndexPath:indexPath];
        [cell setModel:self.topItem[indexPath.row]];
        gridcell =cell;
    }else{
        CategoryGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryGoodsCellID forIndexPath:indexPath];
        GoodsActiveItem * model =self.categoryGoodsItem[indexPath.row];
        
        NSArray *count = [self.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
        if (count.count!=0) {
            GoodsActiveItem * numModel =[count firstObject];
            model.goodsNum = numModel.goodsNum;
        }else{
            model.goodsNum = @"0";
        }

        [cell setModel:model];
//        kWeakSelf(weakSelf);
//        LLog(@"%@",model.title);
        cell.reduceNumBlock = ^(NSString *num) {
            model.goodsNum = num;
            
            if ([model.goodsNum integerValue]==0) {
            [self.db jq_deleteTable:@"shopCarGoods" whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
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
            }else{
                [self.db jq_updateTable:@"shopCarGoods" dicOrModel:model whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
            }
        };
      
        gridcell = cell;
    }

    return gridcell;

}
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.topCollectionView) {

        return  15;
    }
    return 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.topCollectionView) {
        return 10;
    }
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.topCollectionView) {
        TopCategoryCell *cell = (TopCategoryCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//        [self updateCollectionViewCellStatus:cell selected:YES];
    }
    LLog(@"section==%ld,row==%ld",(long)indexPath.section,(long)indexPath.row);
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.topCollectionView) {
        TopCategoryCell *cell = (TopCategoryCell *)[_collectionView cellForItemAtIndexPath:indexPath];
//        [self updateCollectionViewCellStatus:cell selected:NO];
    }
    LLog(@"section--%ld,row--%ld",(long)indexPath.section,(long)indexPath.row);
}
-(void)updateCollectionViewCellStatus:(TopCategoryCell *)myCollectionCell selected:(BOOL)selected
{
    myCollectionCell.titleColor = selected?@"8dc445":@"bfbfbf";

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsItem.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftCategoryCellID     forIndexPath:indexPath];
    if (!cell) {
        cell = [[LeftCategoryCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:LeftCategoryCellID];
    }
    [cell setModel:self.goodsItem[indexPath.row]];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.collectionView) {
//        LLog(@"%@",scrollView);
//        LLog(@"%f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y > oldOffset) {//如果当前位移大于缓存位移，说明scrollView向上滑动
            LLog(@"向上");

        }else{

            LLog(@"向下");
        }
        oldOffset = scrollView.contentOffset.y;//将当前位移变成缓存位移
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
