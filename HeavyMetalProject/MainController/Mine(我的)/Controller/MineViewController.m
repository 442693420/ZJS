//
//  MineViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"


#import "MineTitleView.h"

#import "UserObject.h"
#import "UserManger.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger sum_unRead;//消息未读数量
}
@property (nonatomic , strong)MineTitleView *titleView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *dataArr;
@end
static NSString *cellIdentifier = @"TableViewCell";

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.titleView];
    //tabelView
    [self.view addSubview:self.tableView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(KRealValue(150));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.titleView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    //cell加入缓存池
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    sum_unRead = 0;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self reloadTableviewData];
}
- (void)reloadTableviewData{
    NSArray *sec0 = @[@"绑定手机号",@"分享给朋友"];
    NSArray *sec1 = @[@"我的钱包",@"消费记录"];
    NSArray *sec2 = @[@"系统设置",@"客服电话",@"注销"];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:sec0,sec1,sec2,nil];
    [self.tableView reloadData];
}
//-(void)loadMyinfo
//{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    J_UserModel *userObj = [J_BaseObject getUserInfoDefault];
//
//    params[@"sid"] = userObj.sid;
//    params[@"c_s"] = C_S;
//
//    [J_AFNetWorkManager POST:API_GETJIBENINFO params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        J_UserModel *model = [J_UserModel mj_objectWithKeyValues:responseObject];
//
//        if ([model.rc isEqualToString:@"0"])
//        {
//
//            if ([model.sign isBlankString] || model.sign == nil) {
//                self.titleView.infoLab.text = [NSString stringWithFormat:@"编辑个性签名"];
//            }else {
//                self.titleView.infoLab.text = [NSString stringWithFormat:@"%@",model.sign];
//
//            }
//            [self.tableView reloadData];
//        }
//        else
//        {
//
//            //            [MBManager showBriefAlert:model.des];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
//}
#pragma tableViewDelegate
/**
 *  分割线顶头
 */
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KRealValue(60);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor blackColor];
    NSArray *arr = [self.dataArr objectAtIndex:indexPath.section];
    NSString *titleStr = arr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = titleStr;
    cell.textLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LBTabBarController *rootTab = (LBTabBarController *) [UIApplication sharedApplication].delegate.window.rootViewController;
//    BaseNavigationController *nav = (BaseNavigationController*)rootTab.selectedViewController;
   
}

- (void)loginOutData {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"sid"] = [J_BaseObject getUserInfoDefault].sid;
//    params[@"user_id"] = [J_BaseObject getUserInfoDefault].ID;
//    params[@"c_s"] = C_S;
//    [J_AFNetWorkManager POST:API_LOGINOUT params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        if ([[responseObject objectForKey:@"rc"] isEqual:@"0"]) {
////            [MBManager showBriefAlert:@"注销成功"];
//            
//        }else{
////            [MBManager showBriefAlert:[responseObject objectForKey:@"des"]];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark private-method
//个人资料详情
- (void)infoBackViewClick{
//    J_PersonalMsgViewController *viewController = [[J_PersonalMsgViewController alloc]init];
//    [self.navigationController pushViewController:viewController animated:YES];
}
//我的消息
- (IBAction)messageBtnClick:(id)sender{
//    SNFriendsSessionListViewController *viewController = [[SNFriendsSessionListViewController alloc]init];
//    [self.navigationController pushViewController:viewController animated:YES];
}
//普通登录
- (IBAction)defaultLoginBtnClick:(id)sender{
    LoginViewController *viewController = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}
//- (void)loadLoginDataparamar:(NSMutableDictionary *)params {
//    [J_AFNetWorkManager POST:API_LOGIN params:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBManager hideAlert];
//        NSLog(@"%@",responseObject);
//        J_UserModel *model = [J_UserModel mj_objectWithKeyValues:responseObject];
//        if ([model.rc isEqualToString:@"0"]) {
//            [J_BaseObject saveUserInfoDefault:model];
//            
//            //频道信息保存(全局)
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];//做一个NSUserdefaults对象
//            NSDictionary *pdDic;
//            if ([model.pdid isEqualToString:@""]||model.pdid.length == 0) {//未登录状态下和未创建私人频道时，默认保存为城市频道
//                //把频道信息保存到全局
//                pdDic = @{@"pd_id":@"2",@"pd_type":@"2",@"pd_name":@"城市频道"};
//            }else{
//                //把频道信息保存到全局
//                pdDic = @{@"pd_id":model.pdid,@"pd_type":@"2",@"pd_name":model.pdid};
//            }
//            [defaults setObject:pdDic forKey:kPdInfo];
//            [defaults synchronize];
//            
//            J_UserModel *userObj = [J_BaseObject getUserInfoDefault];
//            
//            [JPUSHService setAlias:userObj.ID callbackSelector:nil object:nil];
//            //建立socket连接
//            if ([[SooonerSocketManager shareInstance] isConnected]) {
//                //注册
//                NSMutableDictionary *mdicLoginInfo = [[NSMutableDictionary alloc] init];
//                [mdicLoginInfo setObject:@"rooodad" forKey:@"sp"];
//                
//                NSMutableDictionary *mdicUserInfo = [[NSMutableDictionary alloc] init];
//                [mdicUserInfo setObject:model.ID forKey:@"id"];
//                [mdicUserInfo setObject:model.name forKey:@"name"];
//                [mdicUserInfo setObject:model.head_img forKey:@"hImg"];
//                [mdicUserInfo setObject:model.sid forKey:@"sid"];
//                [mdicLoginInfo setObject:mdicUserInfo forKey:@"user"];
//                [[SooonerSocketManager shareInstance] regist:mdicLoginInfo withACK:^(NSArray *data) {
//                    if (data.count && [[data firstObject] isEqualToString:@"ok"]) {
//                        
//                    }else{
//                        
//                    }
//                }];
//            }else{
//                [[SooonerSocketManager shareInstance] connect:kIMConnectURL];
//            }
//            //检测并创建聊天记录文件夹(包含audio文件夹和db文件夹) 以userID 命名
//            [SessionDBManager creatSessionTableViewDicPath];
//            //刷新互动部分未读消息
//            [self refreshHuDongRedView];
//            
//            //登陆成功，刷新
//            [self loginInnotification];
//        }
//        else{
//            [MBManager showBriefAlert:model.des];
//        }
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        [MBManager hideAlert];
//        [MBManager showBriefAlert:@"网络异常"];
//        
//    }];
//}
#pragma mark getter and setter
-(MineTitleView *)titleView{
    if (_titleView == nil) {
        _titleView = [[MineTitleView alloc]init];
        //个人资料点击事件
        _titleView.infoBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *infoBackViewClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(infoBackViewClick)];
        [_titleView.infoBackView addGestureRecognizer:infoBackViewClick];
        //我的消息
        [_titleView.messageBtn addTarget:self action:@selector(messageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleView;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#1C1C1C"];
        _tableView.separatorColor = [UIColor colorWithHexString:@"#1C1C1C"];
    }
    return _tableView;
}
@end
