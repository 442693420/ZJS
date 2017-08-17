//
//  SettingViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/8/14.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePwdViewController.h"
#import "ChangePhoneViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)NSMutableArray *dataArrSec;

@end
static NSString *cellIdentifier = @"SettingViewControllerViewCell";

@implementation SettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
    self.title = @"设置";
    //tabelView
    [self.view addSubview:self.tableView];
    //版本号lab
    UILabel *versionLab = [[UILabel alloc]init];
    versionLab.font = [UIFont systemFontOfSize:12];
    versionLab.textColor = [UIColor lightGrayColor];
    [self.view addSubview:versionLab];
    //获取当前版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    versionLab.text = appCurVersion;
    [versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-KRealValue(20));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(-10);
        make.bottom.equalTo(versionLab.mas_top);
    }];
    
    //cell加入缓存池
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"修改密码",@"修改手机号",nil];
    self.dataArrSec = [NSMutableArray arrayWithObjects:@"联系我们",nil];
    
}
#pragma tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArr.count;
    }else {
        return self.dataArrSec.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    if (indexPath.section == 0) {
        cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    }else
    {
        cell.textLabel.text = [self.dataArrSec objectAtIndex:indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 20;
    }else{
        return 16;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            ChangePwdViewController *changePwdVC = [[ChangePwdViewController alloc] init];
            [self.navigationController showViewController:changePwdVC sender:nil];
        }else if (indexPath.row == 1){
            ChangePhoneViewController *changePhone = [[ChangePhoneViewController alloc]init];
            [self.navigationController showViewController:changePhone sender:nil];
        }
    }else {

        
    }
}
#pragma mark getter and setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
    _tableView.separatorColor = [UIColor colorWithHexString:kMainColorDark];
    _tableView.rowHeight = KRealValue(60);
    return _tableView;
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
