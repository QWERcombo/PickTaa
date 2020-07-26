//
//  PTMyVM.h
//  PickTa
//
//  Created by Stark on 2020/6/22.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseViewModel.h"
#import "PTMyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PTMyVM : PickTaBaseViewModel
@property (nonatomic,strong) RACCommand *myCommand;

@property (nonatomic,strong) RACCommand *briefCommand;
@property (nonatomic,copy) NSDictionary *briefParam;




@end

NS_ASSUME_NONNULL_END
