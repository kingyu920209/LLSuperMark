//
//  WDShoppingCarVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/8.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "WDShoppingCarVC.h"
#import "ShoppingCarCell.h"
#import "GoodsActiveItem.h"
#import "ShoppingCarToolView.h"
#import "OrderDetailVC.h"
#import "GoodsDetailVC.h"
#import "LeftCategoryItem.h"
static NSString *const ShoppingCarCellID = @"ShoppingCarCellID";

@interface WDShoppingCarVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property (strong , nonatomic)NSMutableArray<GoodsActiveItem *> *goodsArray;
@property (strong , nonatomic)ShoppingCarToolView * toolView;
@property (strong , nonatomic)NSMutableArray *personArr;
@property (nonatomic,strong)JQFMDB*db;

@end

@implementation WDShoppingCarVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    JQFMDB*db = [JQFMDB shareDatabase:@"shopCarGoods.sqlite"];
    NSMutableArray *personArr = [[db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:nil] mutableCopy];
    self.db = db;
    self.personArr=personArr;
    [self.tableView reloadData];
    
    float totalMoney = 0.00;
    NSInteger goodsNum = 0;
    for (int a=0; a<personArr.count; a++) {
        GoodsActiveItem * model = personArr[a];
        if (model.goodsSelect) {
            goodsNum++;
            totalMoney +=([model.price floatValue]*[model.goodsNum integerValue]);
        }
        
    }
    
        SetTabBarItemBadge([self.db jq_tableItemCount:@"shopCarGoods"]);
    
    self.toolView.selectNum = [NSString stringWithFormat:@"%ld",(long)goodsNum];
    self.toolView.totalMoney = [NSString stringWithFormat:@"%.2f",totalMoney];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"购物车";
    self.goodsArray = [GoodsActiveItem mj_objectArrayWithFilename:@"GoodsActive.plist"];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-46*2) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellStyleDefault;
    [self.view addSubview:self.tableView];

    _tableView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    
    [self.tableView registerClass:[ShoppingCarCell class] forCellReuseIdentifier:ShoppingCarCellID];
    // Do any additional setup after loading the view.
    
    [self addBottomToolView];

    
}
-(void)addBottomToolView{
    self.toolView = [[ShoppingCarToolView alloc]initWithFrame:CGRectMake(0, KScreenHeight-46*2, KScreenWidth, 46)];
    [self.view addSubview:self.toolView];
    
    kWeakSelf(weakSelf);
    
    self.toolView.goOrderDetailBlock = ^{
        NSMutableArray * goodsArray = [NSMutableArray array];
        for (int a=0; a<self.personArr.count; a++) {
            
            GoodsActiveItem * item = weakSelf.personArr[a];
            if (item.goodsSelect) {
                [goodsArray addObject:item];
            }
        }
        if (goodsArray.count<=0) {
            
            return;
        }
        OrderDetailVC * vc = [[OrderDetailVC alloc] init];
        vc.goodsArray = goodsArray;
        vc.totalMoney = weakSelf.toolView.totalMoney;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    self.toolView.selectAllGoodsBlock = ^(BOOL select) {
        
        float totalMoney = 0.00;
        NSInteger goodsNum = 0;
        
        for (int a=0; a<self.personArr.count; a++) {
            
            GoodsActiveItem * item = weakSelf.personArr[a];
            
            if (select) {
                item.goodsSelect = YES;
                goodsNum++;
                totalMoney +=([item.price floatValue]*[item.goodsNum integerValue]);

//                LLog(@"%@",item.price);
            }else{
                item.goodsSelect = NO;

            }
            [weakSelf.db jq_updateTable:@"shopCarGoods" dicOrModel:item whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",item.orderID]];

        }
        
        weakSelf.toolView.selectNum = [NSString stringWithFormat:@"%ld",(long)goodsNum];
        weakSelf.toolView.totalMoney = [NSString stringWithFormat:@"%.2f",totalMoney];
        
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
    };

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.personArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = nil;
    if (section==0) {
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor getColor:@"f1f2f6"];
        
        UIView * freeView = [[UIView alloc]init];
        freeView.backgroundColor = [UIColor getColor:@"f77f7a"];
        [topView addSubview:freeView];
        
        UILabel * infoLabel = [[UILabel alloc]init];
        infoLabel.textAlignment = NSTextAlignmentLeft;
        infoLabel.font = [UIFont systemFontOfSize:13];
        infoLabel.textColor = [UIColor whiteColor];
        infoLabel.text = @"满¥30免配送费，不满收¥5运费";
        [freeView addSubview:infoLabel];
        
        [freeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(topView);
            make.height.equalTo(@40);
        }];
        
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(freeView).offset(12);
            make.centerY.equalTo(freeView);
        }];
        headerView = topView;
    }
    if (section==1) {
        UIView * topView = [[UIView alloc]init];
        topView.backgroundColor = [UIColor getColor:@"f1f2f6"];
        
        UIView * freeView = [[UIView alloc]init];
        freeView.backgroundColor = [UIColor whiteColor];
        [topView addSubview:freeView];
        
        UILabel * infoLabel = [[UILabel alloc]init];
        infoLabel.textAlignment = NSTextAlignmentLeft;
        infoLabel.font = [UIFont systemFontOfSize:13];
        infoLabel.textColor = [UIColor getColor:@"333333"];
        infoLabel.text = @"商品缺货";
        [freeView addSubview:infoLabel];
        
        [freeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(topView);
            make.height.equalTo(@40);
        }];
        
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(freeView).offset(12);
            make.centerY.equalTo(freeView);
        }];
        headerView = topView;
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCarCellID];
    GoodsActiveItem * item = self.personArr[indexPath.row];
    if (!cell) {
        cell = [[ShoppingCarCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ShoppingCarCellID];
    }
    [cell setModel:item];
    
    kWeakSelf(weakSelf);
    cell.addNumBlock = ^(NSString *num) {
        item.goodsNum = num;
        [self.db jq_updateTable:@"shopCarGoods" dicOrModel:item whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",item.orderID]];
        weakSelf.toolView.totalMoney = [NSString stringWithFormat:@"%.2f",[weakSelf.toolView.totalMoney floatValue]+[item.price floatValue]];

    };
    cell.reduceNumBlock = ^(NSString *num){
        item.goodsNum = num;
        weakSelf.toolView.totalMoney = [NSString stringWithFormat:@"%.2f",[weakSelf.toolView.totalMoney floatValue]-[item.price floatValue]];

        if ([item.goodsNum integerValue]==0) {
            [self.db jq_deleteTable:@"shopCarGoods" whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",item.orderID]];
            [weakSelf.personArr removeObject:item];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            SetTabBarItemBadge([self.db jq_tableItemCount:@"shopCarGoods"]);

        }else{
            
            [self.db jq_updateTable:@"shopCarGoods" dicOrModel:item whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",item.orderID]];
            
        }
        
    };
    cell.selectGoodsBlock = ^(BOOL select) {
        item.goodsSelect = select;
        [weakSelf.db jq_updateTable:@"shopCarGoods" dicOrModel:item whereFormat:[NSString stringWithFormat:@"where orderID = '%@'",item.orderID]];

        if (select) {
            weakSelf.toolView.totalMoney = [NSString stringWithFormat:@"%.2f",[weakSelf.toolView.totalMoney floatValue]+[item.price floatValue]*[item.goodsNum integerValue]];
            weakSelf.toolView.selectNum = [NSString stringWithFormat:@"%ld",[weakSelf.toolView.selectNum integerValue]+1];
        }else{
            weakSelf.toolView.totalMoney = [NSString stringWithFormat:@"%.2f",[weakSelf.toolView.totalMoney floatValue]-[item.price floatValue]*[item.goodsNum integerValue]];
            weakSelf.toolView.selectNum = [NSString stringWithFormat:@"%ld",[weakSelf.toolView.selectNum integerValue]-1];
            weakSelf.toolView.isSelect = select;
        }
        
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailVC * goodDetail = [[GoodsDetailVC alloc] init];
    
    
    [self.navigationController pushViewController:goodDetail animated:YES];

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
