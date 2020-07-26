//
//  PickTaCallDetailVC.m
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaCallDetailVC.h"
#import "PTDetailCell.h"

@interface PickTaCallDetailVC ()<UITableViewDelegate,UITableViewDataSource,G_MJRefreshProtocol>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PickTaCallDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    self.navigationItem.title = @"广告详情";
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain backGroundColor:nil tableViewDelegate:self tableViewDataSource:self];
    [self.view addSubview:self.tableView];
}

- (void)bindViewModel{
    
}

- (void)requestData{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTDetailCell"];
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTCallViews" owner:nil options:nil][2];
    }
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
