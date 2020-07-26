//
//  PickTaHeaderView.h
//  PickTa
//
//  Created by Stark on 2020/6/19.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import "PickTaBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickTaHeaderView : PickTaBaseView
@property (weak, nonatomic) IBOutlet UIImageView *bannerView;
+(PickTaHeaderView*)createHeaderView;
@end

NS_ASSUME_NONNULL_END
