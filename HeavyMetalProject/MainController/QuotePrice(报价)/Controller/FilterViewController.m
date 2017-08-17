//
//  FilterViewController.m
//  HeavyMetalProject
//
//  Created by 张浩 on 2017/7/2.
//  Copyright © 2017年 张浩. All rights reserved.
//

#import "FilterViewController.h"
#import "BigClassObject.h"
#import "MidClassObject.h"
#import "FilterButton.h"
@interface FilterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , assign)NSInteger currentBigIndex;
@property (nonatomic , assign)NSInteger currentMidIndex;

@end
static NSString *cellIdentifier = @"TableViewCell";

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"请选择分类";
    self.view.backgroundColor = [UIColor blackColor];
    //tabelView
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    //cell加入缓存池
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    NSLog(@"%@",self.dataArr);
    
    //遍历获取当前midTitle 所在bigArr的index 和 midArr的index
    for (int i = 0;i<self.dataArr.count;i++) {
        BigClassObject *bigObj = self.dataArr[i];
        for (int j = 0;j<bigObj.midclasslst.count;j++) {
            MidClassObject *midObj = bigObj.midclasslst[j];
            if ([self.currentMidTitle isEqualToString:midObj.midclassname]) {
                self.currentBigIndex = i;
                self.currentMidIndex = j;
                break;
            }
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
#pragma tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BigClassObject *bigObj = self.dataArr[section];
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor colorWithHexString:kMainWordColorGray];
    UILabel *headLab = [[UILabel alloc]init];
    headLab.text = bigObj.bigclassname;
    headLab.font = [UIFont systemFontOfSize:KRealValue(14)];
    headLab.textColor = [UIColor whiteColor];
    [headView addSubview:headLab];
    [headLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(headView.mas_left).offset(KRealValue(20));
        make.height.mas_equalTo(KRealValue(30));
    }];
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor blackColor];
    BigClassObject *bigObj = self.dataArr[indexPath.section];
    UIView *lastView;
    for (int i = 0; i < bigObj.midclasslst.count; i++) {
        MidClassObject *midObj = bigObj.midclasslst[i];
        int lie = i%4;
        FilterButton *button = [[FilterButton alloc]init];
        if (indexPath.section == self.currentBigIndex && i == self.currentMidIndex) {
            [button setTitle:midObj.midclassname forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:KRealValue(12)];
            button.backgroundColor = [UIColor colorWithHexString:kMainWordColorGray];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = KRealValue(30)/2;
        }else{
            [button setTitle:midObj.midclassname forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:KRealValue(12)];
            button.backgroundColor = [UIColor blackColor];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = KRealValue(30)/2;
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            button.layer.borderWidth = 1;
        }
        button.currentMidIndex = i;
        button.currentBigIndex = indexPath.section;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [cell addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                if (lie == 0) {
                    make.top.mas_equalTo(lastView.mas_bottom).offset(KRealValue(20));
                    make.left.mas_equalTo(KRealValue(20));
                }else{
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right).offset(KRealValue(20));
                }
            }else{
                make.top.left.mas_equalTo(KRealValue(20));
            }
            make.width.mas_equalTo((KScreenWidth-100)/4);
            make.height.mas_equalTo(KRealValue(30));
        }];
        lastView = button;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BigClassObject *bigObj = self.dataArr[indexPath.section];
    //取整
    NSInteger row = (int)(bigObj.midclasslst.count/4)+1;
    //行间距+行高
    return (row-1+2) * KRealValue(20) + KRealValue(30) * (row);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    LBTabBarController *rootTab = (LBTabBarController *) [UIApplication sharedApplication].delegate.window.rootViewController;
    //    BaseNavigationController *nav = (BaseNavigationController*)rootTab.selectedViewController;
}
-(IBAction)btnClick:(id)sender{
    FilterButton *btn = (FilterButton *)sender;
    [[NSNotificationCenter defaultCenter] postNotificationName:kFilterChangeSegmentNotifiCation object:btn.titleLabel.text];
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
#pragma mark getter and setter

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:kMainColorDark];
        _tableView.separatorColor = [UIColor colorWithHexString:kMainColorDark];
    }
    return _tableView;
}
@end
