//
//  PTGroupListVC.m
//  PickTa
//
//  Created by 赵越 on 2020/7/29.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTGroupListVC.h"
#import "PTContractsCell.h"
#import "PTChatRecordModel.h"
#import "PTChatSearchVC.h"
@interface PTGroupListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation PTGroupListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = kLocalizedString(@"group_chata", @"群聊");
    self.datas = [NSMutableArray array];
    
}

- (void)setupUI {
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 62.f;
    self.tableView.separatorColor = ChatLineColor;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"chat_icon_0"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 40, 40);
    [[searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        PTChatSearchVC *search = [[PTChatSearchVC alloc] initWithNibName:@"PTChatSearchVC" bundle:nil];
        search.searchType = 2;
        PickTaNavigationController *navi = [[PickTaNavigationController alloc]initWithRootViewController:search];
        navi.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navi animated:YES completion:^{
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
}

- (void)requestData {
    
    [PickHttpManager.shared requestPOST:API_ChatMyGroup withParam:@{} withSuccess:^(id  _Nonnull obj) {
        [self.datas addObjectsFromArray:[NSArray modelArrayWithClass:[PTChatRecordModel class] json:obj]];
        
        if (self.datas.count) {
            UILabel *footerLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 62)];
            footerLab.font = [UIFont systemFontOfSize:12];
            footerLab.text = [NSString stringWithFormat:@"%ld个群聊", self.datas.count];
            footerLab.textAlignment = NSTextAlignmentCenter;
            footerLab.textColor = COLOR_HEX_RGB(0x666666);
            self.tableView.tableFooterView = footerLab;
        }
        [self.tableView reloadData];
    } withFailure:^(NSError * _Nonnull err) {
        [SVProgressHUD showErrorWithStatus:err.domain];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTContractsCell *cell = [PTChatViewFactory createChatContractsCellForTableView:tableView];
    
    if (self.datas.count) {
        PTChatRecordModel *model = [self.datas objectAtIndex:indexPath.row];
        [cell.contractIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:kChatPlaceHolder]];
        cell.contractType.text = model.nickname;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
