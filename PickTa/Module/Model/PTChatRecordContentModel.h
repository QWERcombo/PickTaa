//
//  PTChatRecordContentModel.h
//  PickTa
//
//  Created by Stark on 2020/6/26.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTChatRecordContentModel : PickTaBaseModel
@property (nonatomic , assign) NSInteger              pickID;
@property (nonatomic , assign) NSInteger              from_id;
@property (nonatomic , assign) NSInteger              to_id;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              chat_type;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) NSInteger              time;
@property (nonatomic , assign) NSInteger              is_read;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , assign) NSInteger              receive_time;
@property (nonatomic , assign) NSInteger              total;
@property (nonatomic , assign) NSInteger              receive_num;
@property (nonatomic , assign) NSInteger              is_random;
@property (nonatomic , copy) NSString              * read_list;
@property (nonatomic , copy) NSString              * real_value;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              is_del;
@property (nonatomic , assign) NSInteger              position;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * date_time;
@property (nonatomic , copy) NSString              * nickname;
@end

NS_ASSUME_NONNULL_END
