//
//  HXLanguageManager.h
//  PickTa
//
//  Created by Sanpintian on 2020/7/7.
//  Copyright © 2020 laoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UserLanguage @"userLanguage"
#define ChangeLanguageNotificationName @"changeLanguage"
#define kLocalizedString(key, comment) [kLanguageManager localizedStringForKey:key value:comment]

@interface HXLanguageManager : NSObject

@property (nonatomic,copy) void (^completion)(NSString *currentLanguage);

- (NSString *)currentLanguage; //当前语言
- (NSString *)languageFormat:(NSString*)language;
- (void)setUserlanguage:(NSString *)language;//设置当前语言

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

- (UIImage *)ittemInternationalImageWithName:(NSString *)name;

+ (instancetype)shareInstance;

#define kLanguageManager [HXLanguageManager shareInstance]
@end

NS_ASSUME_NONNULL_END
