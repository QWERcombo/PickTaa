// The MIT License (MIT)
//
// Copyright (c) 2014 Suyeol Jeon (http:xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <objc/runtime.h>
#import "UITextView+Placeholder.h"

@implementation UITextView (Placeholder)

#pragma mark - Swizzle Dealloc

+ (void)load {
    // is this the best solution?
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}

- (void)swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UITextView *textView = objc_getAssociatedObject(self, @selector(placeholderTextView));
    if (textView) {
        for (NSString *key in self.class.observingKeys) {
            @try {
                [self removeObserver:self forKeyPath:key];
            } @catch (NSException *exception) {
                // Do nothing
            }
        }
    }
    [self swizzledDealloc];
}

#pragma mark - Class Methods
#pragma mark `defaultPlaceholderColor`

+ (UIColor *)defaultPlaceholderColor {
    if (@available(iOS 13, *)) {
        SEL selector = NSSelectorFromString(@"placeholderTextColor");
        if ([UIColor respondsToSelector:selector]) {
            return [UIColor performSelector:selector];
        }
    }
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @" ";
        NSDictionary *attributes = [textField.attributedPlaceholder attributesAtIndex:0 effectiveRange:nil];
        color = attributes[NSForegroundColorAttributeName];
        if (!color) {
            color = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
        }
    });
    return color;
}

#pragma mark - `observingKeys`

+ (NSArray *)observingKeys {
    return @[@"attributedText",
             @"bounds",
             @"font",
             @"frame",
             @"text",
             @"textAlignment",
             @"textContainerInset",
             @"textContainer.lineFragmentPadding",
             @"textContainer.exclusionPaths"];
}

#pragma mark - Properties
#pragma mark `placeholderTextView`

- (UITextView *)placeholderTextView {
    UITextView *textView = objc_getAssociatedObject(self, @selector(placeholderTextView));
    if (!textView) {
        NSAttributedString *originalText = self.attributedText;
        self.text = @" "; // lazily set font of `UITextView`.
        self.attributedText = originalText;

        textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [self.class defaultPlaceholderColor];
        textView.userInteractionEnabled = NO;
        textView.isAccessibilityElement = NO;
        objc_setAssociatedObject(self, @selector(placeholderTextView), textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

        self.needsUpdateFont = YES;
        [self updatePlaceholderTextView];
        self.needsUpdateFont = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePlaceholderTextView)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];

        for (NSString *key in self.class.observingKeys) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return textView;
}

#pragma mark `placeholder`

- (NSString *)placeholder {
    return self.placeholderTextView.text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.placeholderTextView.text = placeholder;
    [self updatePlaceholderTextView];
}

- (NSAttributedString *)attributedPlaceholder {
    return self.placeholderTextView.attributedText;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    self.placeholderTextView.attributedText = attributedPlaceholder;
    [self updatePlaceholderTextView];
}

#pragma mark `placeholderColor`

- (UIColor *)placeholderColor {
    return self.placeholderTextView.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    self.placeholderTextView.textColor = placeholderColor;
}

#pragma mark `needsUpdateFont`

- (BOOL)needsUpdateFont {
    return [objc_getAssociatedObject(self, @selector(needsUpdateFont)) boolValue];
}

- (void)setNeedsUpdateFont:(BOOL)needsUpdate {
    objc_setAssociatedObject(self, @selector(needsUpdateFont), @(needsUpdate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"font"]) {
        self.needsUpdateFont = (change[NSKeyValueChangeNewKey] != nil);
    }
    [self updatePlaceholderTextView];
}

#pragma mark - Update

- (void)updatePlaceholderTextView {
    if (self.text.length) {
        [self.placeholderTextView removeFromSuperview];
        self.accessibilityValue = self.text;
    } else {
        [self insertSubview:self.placeholderTextView atIndex:0];
        self.accessibilityValue = self.placeholder;
    }

    if (self.needsUpdateFont) {
        self.placeholderTextView.font = self.font;
        self.needsUpdateFont = NO;
    }
    if (self.placeholderTextView.attributedText.length == 0) {
        self.placeholderTextView.textAlignment = self.textAlignment;
    }
    self.placeholderTextView.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
    self.placeholderTextView.textContainerInset = self.textContainerInset;
    self.placeholderTextView.textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding;
    self.placeholderTextView.frame = self.bounds;
}

/**
 *  判斷字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;

    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair

        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];

            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];

    return returnValue;
}

/**
 *  判斷字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji:(NSString *)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];

    return isMatch;
}

//去除字符串中所帶的表情
- (NSString *)disable_emoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    
    return modifiedString;
}

/**
 判斷是不是九宮格
 @param string  輸入的字符
 @return YES(是九宮格拼音鍵盤)
 */
- (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;

    for (int i=0; i<len; i++) {
        if (!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }

    return YES;
}



@end
