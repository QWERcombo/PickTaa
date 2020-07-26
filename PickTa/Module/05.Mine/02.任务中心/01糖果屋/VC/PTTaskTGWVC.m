//
//  PTTaskTGWVC.m
//  PickTa
//
//  Created by Stark on 2020/7/2.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskTGWVC.h"

@interface PTTaskTGWVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PTTaskTGWVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    self.title = kLocalizedString(@"candy_house", @"糖果屋");
    self.tableView = [self createTableViewForFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped backGroundColor:[UIColor whiteColor] tableViewDelegate:self tableViewDataSource:self];
    [self.view addSubview:self.tableView];
}

- (void)bindViewModel{
    
}

- (void)createVM{
    
}

- (void)requestData{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

@end
