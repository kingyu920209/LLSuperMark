//
//  AddressListVC.m
//  weidongdaojiaSuperMarket
//
//  Created by 嘚嘚以嘚嘚 on 2018/1/31.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "AddressListVC.h"
#import "AddressListCell.h"
#import "LocationAddressView.h"
#import "AddressListModel.h"
#import "NewAddressDetailVC.h"
static NSString * const AddressListCellID = @"AddressListCellID";
@interface AddressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)LocationAddressView * locationView;
@property (strong , nonatomic)NSMutableArray<AddressListModel *> *addressArray;

@end

@implementation AddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地址列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.addressArray = [AddressListModel mj_objectArrayWithFilename:@"userAddress.plist"];

    self.locationView = [[LocationAddressView alloc] initWithFrame:CGRectMake(0, 45+64, KScreenWidth, 45)];
    [self.view addSubview:self.locationView];
    self.locationView.locationAddress = @"晴天大厦";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90+64, KScreenWidth, KScreenHeight-90) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.tableView.separatorStyle = UITableViewCellStyleDefault;
    [self.view addSubview:self.tableView];
    _tableView.backgroundColor = [UIColor getColor:@"f1f2f6"];

    UIButton * addressBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [addressBtn setTitle:@"新增地址" forState:(UIControlStateNormal)];
    addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [addressBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [addressBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [addressBtn setBackgroundColor:[UIColor getColor:@"8dc445"]];
    [self.view addSubview:addressBtn];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-44);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(250, 45));
    }];
    addressBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        Class class = NSClassFromString(@"NewAddressDetailVC");
        UIViewController * vc = [[[class class] alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        return [RACSignal empty];
    }];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.addressArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:AddressListCellID];
    if (!cell) {
        cell = [[AddressListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:AddressListCellID];
    }
    [cell setModel:self.addressArray[indexPath.section]];
    kWeakSelf(weakSelf);
    cell.editAddressBlock = ^{
        NewAddressDetailVC * vc = [[NewAddressDetailVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.addressModelBlock(self.addressArray[indexPath.section]);
    [self.navigationController popViewControllerAnimated:YES];
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
