//
//  PickTaFriendCircleModel.h
//  PickTa
//
//  Created by Stark on 2020/6/27.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThumbnailItem :PickTaBaseModel
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * img_thumbnail;
@end


@interface Comment_listItem :PickTaBaseModel
@property (nonatomic , copy) NSString              * comments;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * f_id;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * my_id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * other_nickname;
@property (nonatomic , copy) NSString              * record_id;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * user_avatar;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * user_name;
@end


@interface DataItem :PickTaBaseModel
@property (nonatomic , assign) NSInteger              pickID;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , strong) NSArray <NSString *>              * img;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , assign) NSInteger              comment_num;
@property (nonatomic , assign) NSInteger              like_num;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , strong) NSArray <NSString *>              *in_like;
@property (nonatomic , assign) BOOL              is_in_like;
@property (nonatomic , strong) NSArray <ThumbnailItem *>              * thumbnail;
@property (nonatomic , copy) NSArray <Comment_listItem *>           * comment_list;
@property (nonatomic , copy) NSString              * user_name;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * user_avatar;
@property (nonatomic, assign) BOOL shouldShowMoreButton;
@property (nonatomic, assign) BOOL isOpening;
@end

@interface PickTaFriendCircleModel : PickTaBaseModel
@property (nonatomic , copy) NSString              * cover_photo;
@property (nonatomic , assign) NSInteger              count;
@property (nonatomic , copy) NSString              * page;
@property (nonatomic , strong) NSArray <DataItem *>              * data;
@end

NS_ASSUME_NONNULL_END
