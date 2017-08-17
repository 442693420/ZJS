//
//  MineViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/26.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
#import "ConsumeListViewController.h"
#import "MyWalletViewController.h"
#import "PersonalInfoDetailViewController.h"
#import "MineTitleView.h"
//分享
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
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
    UserObject *userObj = [UserManger getUserInfoDefault];
    [self.titleView.titleImgView sd_setImageWithURL:[NSURL URLWithString:userObj.head_Img] placeholderImage:[UIImage imageNamed:@"defaultImg"]];
    self.titleView.nickNameLab.text = userObj.nickname;
    self.titleView.infoLab.text = [NSString stringWithFormat:@"我的金币数额:%@个",userObj.gold];
    NSArray *sec0 = @[@"绑定手机号",@"分享给朋友"];
    NSArray *sec1 = @[@"我的钱包",@"消费记录"];
    NSArray *sec2 = @[@"系统设置",@"客服电话",@"注销"];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:sec0,sec1,sec2,nil];
    [self.tableView reloadData];
}
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor blackColor];
    NSArray *arr = [self.dataArr objectAtIndex:indexPath.section];
    NSString *titleStr = arr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UserObject *userObj = [UserManger getUserInfoDefault];
            titleStr = [NSString stringWithFormat:@"%@ %@",arr[indexPath.row],userObj.tel];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    cell.textLabel.text = titleStr;
    cell.textLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0://绑定手机号，分享到朋友
            switch (indexPath.row) {
                case 1:
                {
                    [self shareAction];
                }
                    break;
                default:
                    break;
            }
            break;
        case 1://我的钱包，消费记录
        {
            switch (indexPath.row) {
                case 0:
                {
                    MyWalletViewController *walletInfoVC = [[MyWalletViewController alloc]init];
                    [self.navigationController pushViewController:walletInfoVC animated:YES];
                }
                    break;
                case 1:
                {
                    ConsumeListViewController *consumeListVC = [[ConsumeListViewController alloc]init];
                    [self.navigationController pushViewController:consumeListVC animated:YES];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2://系统设置，客服电话，注销
        {
            switch (indexPath.row) {
                case 0:
                {
                    SettingViewController *settingVC = [[SettingViewController alloc]init];
                    [self.navigationController pushViewController:settingVC animated:YES];
                }
                    break;
                case 1:
                {
                    
                    
                }
                    break;
                case 2:
                {
                    //移除本地信息
                    [UserManger removeUserInfoDefault];
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    [self.navigationController pushViewController:loginVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
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
    PersonalInfoDetailViewController *viewController = [[PersonalInfoDetailViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
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
//分享
-(void)shareAction{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"bigWXLogo"]];
    //                （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSString *shareurl = [NSString stringWithFormat:@"www.baidu.com"];
        //为了防止string转URL失败，中文要转码，然后过滤一下空格
        shareurl = [shareurl stringByReplacingOccurrencesOfString:@" " withString:@""];
        shareurl = [shareurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [[NSURL alloc]initWithString:shareurl];
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        NSString *contentText = [NSString stringWithFormat:@"xxxxx"];
        [shareParams SSDKSetupShareParamsByText:contentText
                                         images:imageArray
                                            url:url
                                          title:@"标题XXX"
                                           type:SSDKContentTypeAuto];
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
}
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
        //暂时隐藏消息和红点
        _titleView.messageBtn.hidden = YES;
        _titleView.messageUnreadPointView.hidden = YES;
    }
    return _titleView;
}
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
        _tableView.separatorColor = [UIColor colorWithHexString:kMainColorDark];
        _tableView.rowHeight = KRealValue(60);
    }
    return _tableView;
}
@end
