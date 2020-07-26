//
//  PTChatViewFactory.h
//  PickTa
//
//  Created by Stark on 2020/6/24.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTChatCurrentCell.h"
#import "PTContractsCell.h"
#import "PTChatBottomView.h"


NS_ASSUME_NONNULL_BEGIN

@interface PTChatViewFactory : NSObject

+(PTChatCurrentCell*)createChatCurrentCellForTableView:(UITableView*)tableView;

+(PTContractsCell*)createChatContractsCellForTableView:(UITableView*)tableView;

+(PTChatBottomView*)createChatBottomView;


@end

NS_ASSUME_NONNULL_END
