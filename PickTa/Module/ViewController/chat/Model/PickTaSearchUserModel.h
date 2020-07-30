//
//  PickTaSearchUserModel.h
//  PickTa
//
//  Created by mac on 2020/7/30.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaSearchUserModel : PickTaBaseModel

@property (nonatomic , copy) NSString              * account_number;
@property (nonatomic , copy) NSString              * autograph;
@property (nonatomic , copy) NSString              * head_portrait;
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * initials;
@property (nonatomic , copy) NSString              * invitation_code;
@property (nonatomic , copy) NSString              * my_id;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * phone;

@end

NS_ASSUME_NONNULL_END
