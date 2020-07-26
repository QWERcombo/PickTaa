//
//  PTTaskModel.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTaskModel : PickTaBaseModel
@property (nonatomic , assign) NSInteger              pickID;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * condition;
@property (nonatomic , copy) NSString              * bean;
@property (nonatomic , copy) NSString              * activation;
@property (nonatomic , assign) CGFloat              daily;
@property (nonatomic , assign) NSInteger              date_term;
@property (nonatomic , copy) NSString              * created_at;
@property (nonatomic , copy) NSString              * updated_at;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              market_id;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * activation_weight;
@property (nonatomic , copy) NSString              * bean_get;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , copy) NSString              * start_time;
@property (nonatomic , assign) NSInteger              output_time;
@property (nonatomic , copy) NSString              * created_date;
@end

NS_ASSUME_NONNULL_END
