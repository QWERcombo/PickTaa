//
//  PTTaskStatusBaseVC.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskStatusBaseVC.h"

@interface PTTaskStatusBaseVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *taskList;
@end

@implementation PTTaskStatusBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    self.tableView = [self createTableViewForFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-120-44) style:UITableViewStylePlain backGroundColor:nil tableViewDelegate:self tableViewDataSource:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)createVM{
    self.taskVM = [PTTaskVM new];
}

- (void)bindViewModel{
    [self.taskVM.taskCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x){
        self.taskList = x;
        [self.tableView reloadData];
    }];
    
}

- (void)requestData{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 132;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PTTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTTaskCell"];
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTTaskCell" owner:nil options:nil].firstObject;
    }
    cell.taskModel = self.taskList[indexPath.row];
    return cell;
}

@end
