//
//  PickTaAdvDiscoverModel.h
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdvDiscoverUser :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * avatar;

@end


@interface PickTaAdvDiscoverModel : PickTaBaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , assign) NSInteger              time;
@property (nonatomic , assign) NSInteger              comment_num;
@property (nonatomic , assign) NSInteger              like_num;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * start_time;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * images;
@property (nonatomic , copy) NSString              * like_reward;
@property (nonatomic , copy) NSString              * created_at;
@property (nonatomic , copy) NSString              * updated_at;
@property (nonatomic , assign) NSInteger              is_top;
@property (nonatomic , assign) NSInteger              is_call;
@property (nonatomic , strong) AdvDiscoverUser              * user;
// 54 + 20 +18 + 10 + (screenWidth - 63.5 -16 - 11.5*2 )/1.74  + 文本高度
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) NSString *banner;
@end

NS_ASSUME_NONNULL_END
