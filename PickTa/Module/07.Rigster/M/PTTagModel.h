//
//  PTTagModel.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/21.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTTagModel : PickTaBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
