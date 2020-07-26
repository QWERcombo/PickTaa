//
//  EqualSpaceFlowLayout.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/13.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  EqualSpaceFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end
@interface EqualSpaceFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<EqualSpaceFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
