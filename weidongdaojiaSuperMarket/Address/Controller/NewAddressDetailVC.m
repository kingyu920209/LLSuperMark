//
//  NewAddressDetailVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "NewAddressDetailVC.h"
#import "NewAddressCell.h"
#import "NewPhoneAndNameCell.h"
#import "AddressPickerView.h"
static NSString * const NewAddressCellID = @"NewAddressCellID";
static NSString * const NewPhoneAndNameCellID = @"NewPhoneAndNameCellID";

@interface NewAddressDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation NewAddressDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增地址";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:(UITableViewStyleGrouped)];
    self.tableView.separatorStyle = UITableViewCellStyleDefault;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[NewPhoneAndNameCell class] forCellReuseIdentifier:NewPhoneAndNameCellID];
    [self.tableView registerClass:[NewAddressCell class] forCellReuseIdentifier:NewAddressCellID];
    // Do any additional setup after loading the view.
    
    UIButton * saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    [saveBtn setTitleColor:[UIColor getColor:@"ffffff"] forState:(UIControlStateNormal)];
    [saveBtn setBackgroundColor:[UIColor getColor:@"8dc445"]];
    saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [saveBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(400);
        make.size.mas_equalTo(CGSizeMake(300, 35));
    }];
    [saveBtn layoutIfNeeded];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:saveBtn.bounds cornerRadius:5];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    saveBtn.layer.mask = layer;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 100;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor getColor:@"dedede"];
    return footerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * registerCell = nil;
    if (indexPath.section==0) {
        NewAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:NewAddressCellID];
        if (!cell) {
            cell = [[NewAddressCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NewAddressCellID];
        }
        cell.titleStr = @"收货城市：";
        cell.placeholderStr = @"请选择城市";
        cell.textFieldEnabled = NO;
        registerCell =cell;
    }
    if (indexPath.section==1) {
        NewAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:NewAddressCellID];
        if (!cell) {
            cell = [[NewAddressCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NewAddressCellID];
        }
        cell.titleStr = @"收货地址：";
        cell.placeholderStr = @"请选择城市地址";
        cell.textFieldEnabled = NO;
        registerCell =cell;
    }
    if (indexPath.section==2) {
        NewAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:NewAddressCellID];
        if (!cell) {
            cell = [[NewAddressCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NewAddressCellID];
        }
        cell.titleStr = @"详细地址：";
        cell.placeholderStr = @"楼号、门牌号等详细地址";
        [cell.textField addTarget:self action:@selector(addressDetailDidChange:) forControlEvents:UIControlEventEditingChanged];

        
        registerCell =cell;

    }
    if (indexPath.section==3) {
        NewPhoneAndNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NewPhoneAndNameCellID];
        if (!cell) {
            cell = [[NewPhoneAndNameCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NewPhoneAndNameCellID];
        }
        registerCell =cell;
    }
    return registerCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LLog(@"%ld",(long)indexPath.section);
    AddressPickerView *city = [[AddressPickerView alloc] initWithTWFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) TWselectCityTitle:@"选择地区"];
    //                __weak typeof(self)blockself = self;
    [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        LLog(@"%@---%@---%@",proviceStr,cityStr,distr);
    }];
}
-(void)addressDetailDidChange:(UITextField *)theTextField{
    LLog(@"%@",theTextField);
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
