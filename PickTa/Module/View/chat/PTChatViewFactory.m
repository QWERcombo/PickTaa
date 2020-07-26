//
//  PTChatViewFactory.m
//  PickTa
//
//  Created by Stark on 2020/6/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PTChatViewFactory.h"

@implementation PTChatViewFactory



+ (PTChatCurrentCell *)createChatCurrentCellForTableView:(UITableView *)tableView{
    PTChatCurrentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTChatCurrentCell"];
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTChatViews" owner:nil options:nil].firstObject;
    }
    return cell;
}

+ (PTContractsCell *)createChatContractsCellForTableView:(UITableView *)tableView{
    PTContractsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PTContractsCell"];
    if(!cell){
        cell = [[NSBundle mainBundle]loadNibNamed:@"PTChatViews" owner:nil options:nil][1];
    }
    return cell;
}

+ (PTChatBottomView *)createChatBottomView{
    return [[NSBundle mainBundle]loadNibNamed:@"PTChatViews" owner:nil options:nil][2];
}

@end
