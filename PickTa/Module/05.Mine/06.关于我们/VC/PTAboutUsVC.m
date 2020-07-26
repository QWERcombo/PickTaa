//
//  PTAboutUsVC.m
//  PickTa
//
//  Created by Sanpintian on 2020/7/25.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTAboutUsVC.h"
#import "PTWKWebViewVC.h"

@interface PTAboutUsVC ()
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@end

@implementation PTAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = kLocalizedString(@"about_us", @"关于我们");
    self.lable1.text = kLocalizedString(@"privacy", @"隐私政策");
    self.lable2.text = kLocalizedString(@"user_terms", @"用户条款");
    self.lable3.text = kLocalizedString(@"version", @"版本");
}

- (IBAction)onBtnAction:(UIButton *)sender {
    PTWKWebViewVC *vc = [[PTWKWebViewVC alloc] init];

    if (sender.tag == 101) {
        vc.title = kLocalizedString(@"privacy", @"隐私政策");
        vc.htmlStringContent = kLocalizedString(@"yinsi", @"yinsi");
    } else if  (sender.tag == 102) {
        vc.title = kLocalizedString(@"user_terms", @"用户条款");
        vc.htmlStringContent = kLocalizedString(@"tiaokuan", @"tiaokuan");
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
