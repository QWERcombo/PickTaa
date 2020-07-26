//
//  PTTaskAlreadyVC.m
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTTaskAlreadyVC.h"

@interface PTTaskAlreadyVC ()

@end

@implementation PTTaskAlreadyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)requestData{
    [self.taskVM.taskCommand execute:@{@"page":@"1",@"status":@(2)}];
}


@end
