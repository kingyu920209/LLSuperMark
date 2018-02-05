//
//  OrderDetailVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/29.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderDetailTopView.h"
#import "OrderDetailBottomView.h"
#import "OrderDetailAddressCell.h"
#import "OrderDetailTimeCell.h"
#import "OrderDetailTotalCell.h"
#import "OrderDetailComCell.h"
#import "OrderDetailPayModelCell.h"
#import "OrderDetailImgCell.h"
#import "GoodsActiveItem.h"
#import "OrderListVC.h"
#import "AddressListVC.h"
#import "AddressListModel.h"
#define PayTitleArray @[@"支付宝",@"微信"]
#define PayImgArray @[@"alipay",@"wxpay"]

static NSString * const OrderDetailPayModelCellID = @"OrderDetailPayModelCellID";
static NSString * const OrderDetailTimeCellID = @"OrderDetailTimeCellID";
static NSString * const OrderDetailTotalCellID = @"OrderDetailTotalCellID";
static NSString * const OrderDetailComCellID = @"OrderDetailComCellID";
static NSString * const OrderDetailAddressCellID = @"OrderDetailAddressCellID";
static NSString * const OrderDetailImgCellID = @"OrderDetailImgCellID";

@interface OrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)OrderDetailTopView * topToolView;
@property (nonatomic , strong)OrderDetailBottomView * bottomToolView;
@property (nonatomic , strong)AddressListModel * addressModel;
@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算";
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.topToolView = [[OrderDetailTopView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 70)];
    [self.view addSubview:self.topToolView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+70, KScreenWidth, KScreenHeight-70) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellStyleDefault;
    _tableView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[OrderDetailTimeCell class] forCellReuseIdentifier:OrderDetailTimeCellID];
    [self.tableView registerClass:[OrderDetailTotalCell class] forCellReuseIdentifier:OrderDetailTotalCellID];
    [self.tableView registerClass:[OrderDetailComCell class] forCellReuseIdentifier:OrderDetailComCellID];
    [self.tableView registerClass:[OrderDetailPayModelCell class] forCellReuseIdentifier:OrderDetailPayModelCellID];
    [self.tableView registerClass:[OrderDetailAddressCell class] forCellReuseIdentifier:OrderDetailAddressCellID];
    [self.tableView registerClass:[OrderDetailImgCell class] forCellReuseIdentifier:OrderDetailImgCellID];
    
    self.bottomToolView = [[OrderDetailBottomView alloc] initWithFrame:CGRectMake(0, KScreenHeight-47, KScreenWidth, 47)];
    self.bottomToolView.totalMoney = self.totalMoney;
    [self.view addSubview:self.bottomToolView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1||section==4) {
        return 2;
    }
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
//        return 70;
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        LLog(@"%f",cell.frame.size.height);
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            return 85;
        }
    }
 
    if (indexPath.section==3) {
        return 90;
    }
    if (indexPath.section==4) {
        return 55;
    }
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * registerCell  = nil;
    if (indexPath.section==0) {
        OrderDetailAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailAddressCellID];
        if (!cell) {
            cell = [[OrderDetailAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:OrderDetailAddressCellID];
        }
        [cell UpDataCell:self.addressModel];
        registerCell = cell;
    }
    if (indexPath.section==1) {
        if (indexPath.row ==0) {
            OrderDetailImgCell * cell  = [tableView dequeueReusableCellWithIdentifier:OrderDetailImgCellID];
            if (!cell) {
                cell = [[OrderDetailImgCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:OrderDetailImgCellID];
            }
            cell.imgArray =self.goodsArray;
            registerCell = cell;
        }
        if (indexPath.row==1) {
            OrderDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailTimeCellID];
            if (!cell) {
                cell = [[OrderDetailTimeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:OrderDetailTimeCellID];
            }
            registerCell= cell;
        }
    }
    if (indexPath.section==2) {
        OrderDetailComCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailComCellID];
        if (!cell) {
            cell = [[OrderDetailComCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:OrderDetailComCellID];
        }
        registerCell = cell;
    }
    if (indexPath.section==3) {
        OrderDetailTotalCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailTotalCellID];
        if (!cell) {
            cell = [[OrderDetailTotalCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:OrderDetailTotalCellID];
        }
        cell.totalMoney = self.totalMoney;
        registerCell = cell;
    }
    if (indexPath.section==4) {
        OrderDetailPayModelCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailPayModelCellID];
        if (!cell) {
            cell = [[OrderDetailPayModelCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:OrderDetailPayModelCellID];
        }
        cell.titleStr = PayTitleArray[indexPath.row];
        cell.imgStr = PayImgArray[indexPath.row];
        registerCell = cell;
    }

    return registerCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        AddressListVC * vc = [[AddressListVC alloc] init];
        kWeakSelf(weakSelf);
        vc.addressModelBlock = ^(AddressListModel *model) {
            weakSelf.addressModel = model;
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];

        };
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            OrderListVC * vc = [[OrderListVC alloc] init];                        
            vc.goodsArray = self.goodsArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
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
