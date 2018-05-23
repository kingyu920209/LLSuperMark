//
//  GoodsDetailVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/26.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#define GoodsHomeSilderImagesArray @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"]

#import "GoodsDetailVC.h"
#import "GoodsDetailInfoCell.h"
#import "GoodsDetailTitleCell.h"
#import "GoodsDetailSlidesCell.h"
#import "GoodsDetailModel.h"
#import "DetailShopCarToolView.h"
#import "AppDelegate.h"
#import "WDTabBarController.h"
#import "GoodsDetailWebCell.h"
#import "GoodsActiveItem.h"
static NSString * const GoodsDetailSlidesCellID = @"GoodsDetailSlidesCell";
static NSString * const GoodsDetailInfoCellID = @"GoodsDetailInfoCellID";
static NSString * const GoodsDetailTitleCellID = @"GoodsDetailTitleCellID";
static NSString * const GoodsDetailWebCellID = @"GoodsDetailWebCellID";

@interface GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property (strong , nonatomic)NSMutableArray<GoodsDetailModel *> *goodsItem;
@property (nonatomic,strong)GoodsDetailModel *model;
@property (nonatomic,strong)DetailShopCarToolView * toolView;
@property (nonatomic,assign)CGFloat webHeight;
@property (nonatomic,strong)JQFMDB * db;
@end

@implementation GoodsDetailVC
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        [self.navigationController setNavigationBarHidden:YES animated:animated];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] landscapeImagePhone:nil style:(UIBarButtonItemStyleDone) target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    kWeakSelf(weakSelf);
    self.webHeight= 300;
    self.db = [JQFMDB shareDatabase:@"shopCarGoods.sqlite"];

    self.view.backgroundColor = [UIColor whiteColor];
    self.model = [GoodsDetailModel mj_objectWithFilename:@"GoodsDetail.plist"];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, KScreenWidth, KScreenHeight) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellStyleDefault;
    _tableView.backgroundColor = [UIColor getColor:@"f1f2f6"];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[GoodsDetailTitleCell class] forCellReuseIdentifier:GoodsDetailTitleCellID];
    [_tableView registerClass:[GoodsDetailInfoCell class] forCellReuseIdentifier:GoodsDetailInfoCellID];
    [_tableView registerClass:[GoodsDetailSlidesCell class] forCellReuseIdentifier:GoodsDetailSlidesCellID];
    [_tableView registerClass:[GoodsDetailWebCell class] forCellReuseIdentifier:GoodsDetailWebCellID];
 
    
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:@"navbtn"] forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.top.equalTo(self.view).offset(27);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    [self addShopCarToolView];
    // Do any additional setup after loading the view.
}
-(void)addShopCarToolView{
    self.toolView = [[DetailShopCarToolView alloc] init];

    NSMutableArray *personArr = [[self.db jq_lookupTable:@"shopCarGoods" dicOrModel:[GoodsActiveItem class] whereFormat:nil] mutableCopy];
    float totalMoney = 0.00;
    for (int a=0; a<personArr.count; a++) {
        GoodsActiveItem * model = personArr[a];
        totalMoney +=([model.price floatValue]*[model.goodsNum integerValue]);
    }
    
    self.toolView.goodsPrice = [NSString stringWithFormat:@"%.2f",totalMoney];
    self.toolView.goodsNum =[NSString stringWithFormat:@"%d",[self.db jq_tableItemCount:@"shopCarGoods"]];
    self.toolView.frame = CGRectMake(0, KScreenHeight-51, KScreenWidth, 51);
    [self.view addSubview:self.toolView];
    kWeakSelf(weakSelf);

    self.toolView.goShopBlock = ^{
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        WDTabBarController *tab = (WDTabBarController *)delegate.window.rootViewController;
        tab.selectedIndex = 2;
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        
    };

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 10;
    }
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    GoodsDetailModel *model = [self.goodsItem firstObject];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return self.model.slidesHeight;
        }
        if (indexPath.row==1) {
            return self.model.titleHeight;
        }
        return self.model.infoHeight;
    }else{
        return self.webHeight;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * tableViewCell=nil;
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            GoodsDetailTitleCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailTitleCellID];
            if (!cell) {
                cell = [[GoodsDetailTitleCell  alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:GoodsDetailTitleCellID];
            }
            [cell setUpData:self.model];
            tableViewCell = cell;
        }
        if (indexPath.row==0) {
            GoodsDetailSlidesCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailSlidesCellID];
            if (!cell) {
                cell = [[GoodsDetailSlidesCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:GoodsDetailSlidesCellID];
            }
            cell.imageGroupArray =GoodsHomeSilderImagesArray;
            
            tableViewCell = cell;
        }
        if (indexPath.row==2) {
            GoodsDetailInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailInfoCellID];
            if (!cell) {
                cell = [[GoodsDetailInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:GoodsDetailInfoCellID];
            }
            [cell setUpData:self.model];
            tableViewCell = cell;
        }
    }else{
        GoodsDetailWebCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailWebCellID];
        if (!cell) {
            cell = [[GoodsDetailWebCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:GoodsDetailWebCellID];
        }
        cell.urlStr = @"https://www.baidu.com";
        tableViewCell = cell;
        kWeakSelf(weakSelf);
        cell.webViewHeightBlock = ^(CGFloat height) {
            if (weakSelf.webHeight==300) {
                weakSelf.webHeight = height;
                [weakSelf.tableView beginUpdates];
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationNone)];
                [weakSelf.tableView endUpdates];
            }
        
        };
    }


 
    return tableViewCell;
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//                LLog(@"%@",scrollView);
//                LLog(@"%f",scrollView.contentOffset.y);
//
//    
//}
-(void)dealloc{
    LLog(@"销毁");
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
