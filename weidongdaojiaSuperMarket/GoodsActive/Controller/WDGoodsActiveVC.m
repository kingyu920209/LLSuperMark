//
//  WDGoodsActiveVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/16.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDGoodsActiveVC.h"
#import "GoodsActiveHeaderView.h"
#import "GoodsActiveCell.h"
#import "GoodsActiveItem.h"
#import "GoodsShopCarToolView.h"
#import "AppDelegate.h"
#import "WDTabBarController.h"
#import "GoodsDetailVC.h"
@interface WDGoodsActiveVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property (strong , nonatomic)NSMutableArray<GoodsActiveItem *> *goodsItem;

@property (strong , nonatomic)GoodsShopCarToolView * toolView;

@property (nonatomic,strong)JQFMDB*db;

@end

static NSString * const GoodsActiveCellID = @"GoodsActiveCell";

@implementation WDGoodsActiveVC
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.db close];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.db = [JQFMDB shareDatabase:@"shopCarGoods.sqlite"];

    self.goodsItem = [GoodsActiveItem mj_objectArrayWithFilename:@"GoodsActive.plist"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  =@"新品上市";
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-51) style:(UITableViewStyleGrouped)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellStyleDefault;
    
    [self.tableView registerClass:[GoodsActiveCell class] forCellReuseIdentifier:GoodsActiveCellID];
    
    [self addShopCarToolView];
    // Do any additional setup after loading the view.
}

/**
 添加底部购物车
 */
-(void)addShopCarToolView{
    GoodsShopCarToolView * toolView = [[GoodsShopCarToolView alloc]init];
    toolView.frame = CGRectMake(0, KScreenHeight-51, KScreenWidth, 51);
    [self.view addSubview:toolView];
    
    NSMutableArray *personArr = [[self.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:nil] mutableCopy];
    float totalMoney = 0.00;
    for (int a=0; a<personArr.count; a++) {
        GoodsActiveItem * model = personArr[a];
            totalMoney +=([model.price floatValue]*[model.goodsNum integerValue]);
    }

    toolView.goodsPrice = [NSString stringWithFormat:@"%.2f",totalMoney];
    toolView.goodsNum =[NSString stringWithFormat:@"%d",[self.db jq_tableItemCount:@"shopCarGoods"]];
    kWeakSelf(weakSelf);
    toolView.goShopBlock = ^{
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        WDTabBarController *tab = (WDTabBarController *)delegate.window.rootViewController;
        tab.selectedIndex = 2;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    };
    self.toolView = toolView;
}

#pragma mark - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsItem.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 559/2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GoodsActiveHeaderView * headerView = [GoodsActiveHeaderView headerViewWithTableView:self.tableView];
    headerView.banerURL = @"xp_06";
    headerView.imageURL = @"xp_09";
    return headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GoodsActiveCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsActiveCellID];
    if (!cell) {
        cell = [[GoodsActiveCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:GoodsActiveCellID];
    }
    GoodsActiveItem * model =self.goodsItem[indexPath.row];
    NSArray *count = [self.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
    if (count.count!=0) {
        GoodsActiveItem * numModel =[count firstObject];
        model.goodsNum = numModel.goodsNum;
    }else{
        model.goodsNum = @"0";
    }
    [cell setModel:model];
    kWeakSelf(weakSelf);
    cell.reduceNumBlock = ^(NSString *num) {
        model.goodsNum = num;
        weakSelf.toolView.goodsPrice = [NSString stringWithFormat:@"%.2f",[weakSelf.toolView.goodsPrice floatValue]-[model.price floatValue]];

        if ([model.goodsNum integerValue]==0) {
            [weakSelf.db jq_deleteTable:@"shopCarGoods" whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
            weakSelf.toolView.goodsNum =[NSString stringWithFormat:@"%d",[weakSelf.db jq_tableItemCount:@"shopCarGoods"]];

        }else{
            [weakSelf.db jq_updateTable:@"shopCarGoods" dicOrModel:model whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
        }

    };


    cell.addNumBlock = ^(NSString *num){
        model.goodsNum = num;
        weakSelf.toolView.goodsPrice = [NSString stringWithFormat:@"%.2f",[weakSelf.toolView.goodsPrice floatValue]+[model.price floatValue]];
        NSArray *count = [weakSelf.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
        if (count.count==0) {
            model.goodsSelect = YES;
            [weakSelf.db jq_insertTable:@"shopCarGoods" dicOrModel:model];
            weakSelf.toolView.goodsNum =[NSString stringWithFormat:@"%d",[weakSelf.db jq_tableItemCount:@"shopCarGoods"]];

        }else{
            [weakSelf.db jq_updateTable:@"shopCarGoods" dicOrModel:model whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",model.orderID]];
        }
    };
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailVC * goodDetail = [[GoodsDetailVC alloc] init];
    [self.navigationController pushViewController:goodDetail animated:YES];
    LLog(@"row--%ld",(long)indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    LLog(@"销毁");
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
