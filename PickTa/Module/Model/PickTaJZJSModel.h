//
//  PickTaJZJSModel.h
//  PickTa
//
//  Created by Stark on 2020/7/3.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaJZJSModel : PickTaBaseModel
@property (nonatomic , assign) NSInteger            pickID;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * condition;
@property (nonatomic , copy) NSString              * bean;
@property (nonatomic , copy) NSString              * activation;
@property (nonatomic , assign) NSInteger              times_receive;
@property (nonatomic , copy) NSString              * daily;
@property (nonatomic , assign) NSInteger              date_term;
@property (nonatomic , copy) NSString              * created_at;
@property (nonatomic , copy) NSString              * updated_at;
@property (nonatomic , copy) NSString              * img;
@end

NS_ASSUME_NONNULL_END
