//
//  BaseViewController.m
//  iOSProjectFramework
//
//  Created by 洪冬介 on 2018/1/26.
//  Copyright © 2018年 洪冬介. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, copy) NSString *reloadMethodName;

@end

@implementation BaseViewController

- (NSMutableArray *)operateVeiwsArr {
    if (!_operateVeiwsArr) {
        _operateVeiwsArr = [NSMutableArray array];
    }
    return _operateVeiwsArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (HDJEmptyView *)emptyDataView {
    if (!_emptyDataView) {
        _emptyDataView = [[HDJEmptyView alloc] init];
        [self.view addSubview:_emptyDataView];
        [self.view sendSubviewToBack:_emptyDataView];
        [_emptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _emptyDataView.userInteractionEnabled = YES;
        UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doEmptyDataViewTapRec:)];
        [_emptyDataView addGestureRecognizer:tapRec];
    }
    [self.view bringSubviewToFront:_emptyDataView];
    return _emptyDataView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏
    [self initNavView];
}

- (void)initNavView {
    // 导航栏左侧按钮
    _navButtonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    _navButtonLeft.frame = CGRectMake(0, 0, NavigationBarIcon, NAVIGATIONBAR_HEIGHT);
    _navButtonLeft.centerY = 22;
    [_navButtonLeft setImage:[UIImage imageNamed:@"nav_jiantou_zuo"] forState:UIControlStateNormal];
    _navButtonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_navButtonLeft addTarget:self action:@selector(navLeftPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navButtonLeft];
    
    // 导航栏右侧按钮
    _navButtonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _navButtonRight.frame = CGRectMake(0, 0, NAVIGATIONBAR_HEIGHT + 30, NAVIGATIONBAR_HEIGHT + 14);
    _navButtonRight.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _navButtonRight.centerY = 22;
    _navButtonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_navButtonRight addTarget:self action:@selector(navRightPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navButtonRight];
    
    //    // 状态栏背景视图
    //    _statusBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -STATUSBAR_HEIGHT, SCREEN_WIDTH, STATUSBAR_HEIGHT)];
    //    _statusBarBgView.backgroundColor = MAIN_COLOR;
    //    [self.navigationController.navigationBar addSubview:_statusBarBgView];
    
    // 导航栏背景色
    self.navigationController.navigationBar.barTintColor = MAIN_COLOR;
    
    // 设置导航栏字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
}

#pragma mark - setNavTitle Method
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}

#pragma mark - 按钮点击事件
/**
 *  导航左按钮事件（默认返回上一页）
 */
- (void)navLeftPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  导航右按钮事件（默认无内容）
 */

- (void)navRightPressed:(id)sender {
    DLog(@"=> navRightPressed !");
}

- (void)showEmptyViewWithReloadMethodName:(NSString*)reloadMethodName {
    self.reloadMethodName = reloadMethodName;
    self.emptyDataView.hidden = NO;
}
- (void)hideEmptyView {
    self.emptyDataView.hidden = YES;
}
- (void)doEmptyDataViewTapRec:(UITapGestureRecognizer*)sender {
    if ([self respondsToSelector:NSSelectorFromString(self.reloadMethodName)]) {
        [self performSelector:NSSelectorFromString(self.reloadMethodName)];
    }
}


@end
