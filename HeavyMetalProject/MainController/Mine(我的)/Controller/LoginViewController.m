//
//  LoginViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/6/28.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginWithPwdViewController.h"
#import "LoginWithVerifyCodeViewController.h"

#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#define kView_W self.view.frame.size.width
#define kView_H self.view.frame.size.height
#define kPageCount 2
#define kButton_H 50
#define kTag 100
@interface LoginViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, assign)NSInteger currentPages;
@property (nonatomic, strong)LoginWithPwdViewController *pwdVC;
@property (nonatomic, strong)LoginWithVerifyCodeViewController *verifyCodeVC;
@end
static NSString *btnNormalColor = @"#E1E1E1";
static NSString *btnSelectColor = @"#EFEFF4";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.automaticallyAdjustsScrollViewInsets = YES;
    //隐藏返回按钮
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
    [leftButton setTitle:@"" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    self.title = @"登录";
    self.view.backgroundColor = [UIColor lightGrayColor];
    //设置可以左右滑动的ScrollView
    [self setupScrollView];
    
    //设置控制的每一个子控制器
    [self setupChildViewControll];
    
    //设置分页按钮
    [self setupPageButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

/**
 *  设置可以左右滑动的ScrollView
 */
- (void)setupScrollView{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kButton_H + 64, kView_W, kView_H - 64 - kButton_H)];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.showsVerticalScrollIndicator = NO;
    //方向锁
    _scroll.directionalLockEnabled = YES;
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scroll.contentSize = CGSizeMake(kView_W * kPageCount, kView_H - 64 - kButton_H);
    
    [self.view addSubview:_scroll];
}

/**
 *  设置控制的每一个子控制器
 */
- (void)setupChildViewControll{
    self.pwdVC = [[LoginWithPwdViewController alloc]init];
    self.verifyCodeVC = [[LoginWithVerifyCodeViewController alloc]init];
    
    [self.pwdVC.wxBtn addTarget:self action:@selector(wxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.verifyCodeVC.wxBtn addTarget:self action:@selector(wxBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //指定该控制器为其子控制器
    [self addChildViewController:_pwdVC];
    [self addChildViewController:_verifyCodeVC];
    
    //将视图加入ScrollView上
    [_scroll addSubview:_pwdVC.view];
    [_scroll addSubview:_verifyCodeVC.view];
    
    //设置两个控制器的尺寸
    _verifyCodeVC.view.frame = CGRectMake(kView_W, 0, kView_W, kView_H - 64 - kButton_H);
    _pwdVC.view.frame = CGRectMake(0, 0, kView_W, kView_H - 64 - kButton_H);
}
/**
 *  设置分页按钮
 */
- (void)setupPageButton{
    //button的index值应当从0开始
    UIButton *btn = [self setupButtonWithTitle:@"账号密码登录" Index:0];
    self.selectBtn = btn;
    [btn setBackgroundColor:[UIColor colorWithHexString:btnSelectColor]];
    [self setupButtonWithTitle:@"手机号快捷登录" Index:1];
}

- (UIButton *)setupButtonWithTitle:(NSString *)title Index:(NSInteger)index{
    CGFloat y = 64;
    CGFloat w = (kView_W)/kPageCount;
    CGFloat h = kButton_H;
    CGFloat x = index * w;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, y, w, h);
    [btn setBackgroundColor:[UIColor colorWithHexString:btnNormalColor]];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.tag = index + kTag;
    btn.titleLabel.font = [UIFont systemFontOfSize:KRealValue(14)];
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    return btn;
}
- (void)pageClick:(UIButton *)btn{
    self.currentPages = btn.tag - kTag;
    [self gotoCurrentPage];
}
/**
 *  设置选中button的样式
 */
- (void)setupSelectBtn{
    UIButton *btn = [self.view viewWithTag:self.currentPages + kTag];
    if ([self.selectBtn isEqual:btn]) {
        return;
    }
    [self.selectBtn setBackgroundColor:[UIColor colorWithHexString:btnNormalColor]];
    self.selectBtn = btn;
    [btn setBackgroundColor:[UIColor colorWithHexString:btnSelectColor]];
}
/**
 *  进入当前的选定页面
 */
- (void)gotoCurrentPage{
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.currentPages;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}


#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    
    //设置选中button的样式
    [self setupSelectBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 微信登录
-(IBAction)wxBtnClick:(id)sender{
    [MBManager showLoadingInView:self.view msg:@"登录中"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       NSString *unionid = [user.rawData objectForKey:@"unionid"];
                                       params[@"c_s"] = C_S;
                                       params[@"type"] = [NSNumber numberWithInteger:KLoginTypeWeChat];
                                       params[@"third_id"] = unionid;
                                       params[@"headimgurl"] = user.icon;
                                       params[@"nickname"] = user.nickname;
                                       associateHandler (user.uid, user, user);
                                       NSLog(@"dd%@",user.rawData);
                                       NSLog(@"dd%@",user.credential);
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    [MBManager hideAlert];
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        [self loadLoginDataparamar:params];
                                        
                                    }else {
                                        
                                    }
                                    
                                }];
}
- (void)loadLoginDataparamar:(NSMutableDictionary *)params {
    //三方登录
    [HMPAFNetWorkManager POST:API_LOGIN params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [MBManager hideAlert];
        if ([responseObject[@"rc"] isEqualToString:@"0"]) {
            UserObject *model = [UserObject mj_objectWithKeyValues:responseObject[@"msg"]];
            [UserManger saveUserInfoDefault:model];
            //跳转
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBManager showBriefMessage:responseObject[@"des"] InView:self.view];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
