//
//  PTTaskDoingVC.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskDoingVC.h"


@interface PTTaskDoingVC ()
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PTTaskDoingVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)requestData{
    [self.taskVM.taskCommand execute:@{@"page":@"1",@"status":@(0)}];
}


@end
