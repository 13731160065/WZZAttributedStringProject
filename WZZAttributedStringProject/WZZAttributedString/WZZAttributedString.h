//
//  WZZAttributedString.h
//  HNBaoDai
//
//  Created by wyq_iMac on 2022/7/19.
//  Copyright © 2022 王泽众. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WZZAttributedString : NSObject

/// 获取最终富文本
@property (strong, nonatomic, readonly) NSAttributedString * attributedText;
/// 获取最终纯文本
@property (strong, nonatomic, readonly) NSString * plainText;
/// 获取本段文本样式字典
@property (strong, nonatomic, readonly) NSDictionary<NSAttributedStringKey, id> *attributesDictionary;

/// 直接赋值引用
@property (strong, nonatomic, readonly) WZZAttributedString *(^ref)(WZZAttributedString **);

/// 添加富文本
@property (strong, nonatomic, readonly) WZZAttributedString *(^appendString)(WZZAttributedString *);

/// 添加新富文本
@property (strong, nonatomic, readonly) WZZAttributedString *(^appendNewString)(NSString *);

/// 设置文字id
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupStringId)(NSString *);
/// 设置文字
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupText)(NSString *);
/// 设置颜色
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupColor)(UIColor *);
/// 设置背景颜色
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupBackgroundColor)(UIColor *);
/// 设置字体
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupFont)(UIFont *);
/// 设置挂件
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupAttachment)(NSTextAttachment *);
/// 设置图片挂件，与设置挂件冲突
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupImageAttachment)(UIImage *, CGRect);
/// 设置链接
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupLink)(id);
/// 设置下划线颜色
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupUnderlineColor)(UIColor *);
/// 设置下划线样式
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupUnderlineStyle)(NSNumber *);
/// 设置阴影
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupShadow)(NSShadow *);
/// 设置阴影
@property (strong, nonatomic, readonly) WZZAttributedString *(^setupParagraphStyle)(NSParagraphStyle *);

#pragma mark - 富文本属性
/// 文字id，方便查找
@property (strong, nonatomic) NSString * stringId;
/// 文字
@property (strong, nonatomic) NSString * text;
/// 颜色
@property (strong, nonatomic) UIColor * color;
/// 背景颜色
@property (strong, nonatomic) UIColor * backgroundColor;
/// 字体
@property (strong, nonatomic) UIFont * font;
/// 挂件： NSTextAttachment, default nil
@property (strong, nonatomic) NSTextAttachment * attachment;
/// 链接： NSURL (preferred) or NSString
@property (strong, nonatomic) id link;
// 下划线样式：NSNumber containing integer, default 0: no underline
@property (strong, nonatomic) NSNumber * underlineStyle;
// 下划线颜色：UIColor, default nil: same as foreground color
@property (strong, nonatomic) UIColor * underlineColor;
/// 阴影：NSShadow, default nil: no shadow
@property (strong, nonatomic) NSShadow * shadow;
/// 段落样式
@property (strong, nonatomic) NSParagraphStyle * paragraphStyle;


@property (strong, nonatomic) NSNumber * ligature;
@property (strong, nonatomic) NSNumber * kern;
@property (strong, nonatomic) NSNumber * tracking;
// UIColor, default nil: same as foreground color
@property (strong, nonatomic) NSNumber * strokeColor;
// NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
@property (strong, nonatomic) NSNumber * strokeWidth;
// NSString, default nil: no text effect
@property (strong, nonatomic) NSString * textEffect;
// NSNumber containing floating point value, in points; offset from baseline, default 0
@property (strong, nonatomic) NSNumber * baselineOffset;
// NSNumber containing integer, default 0: no strikethrough
@property (strong, nonatomic) NSNumber * strikethroughStyle;
// UIColor, default nil: same as foreground color
@property (strong, nonatomic) UIColor * strikethroughColor;
// NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew
@property (strong, nonatomic) NSNumber * obliqueness;
// NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
@property (strong, nonatomic) NSNumber * expansion;
// NSArray of NSNumbers representing the nested levels of writing direction overrides as defined by Unicode LRE, RLE, LRO, and RLO characters.  The control characters can be obtained by masking NSWritingDirection and NSWritingDirectionFormatType values.  LRE: NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding, RLE: NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding, LRO: NSWritingDirectionLeftToRight|NSWritingDirectionOverride, RLO: NSWritingDirectionRightToLeft|NSWritingDirectionOverride,
@property (strong, nonatomic) NSArray <NSNumber *>* writingDirection;
// An NSNumber containing an integer value.  0 means horizontal text.  1 indicates vertical text.  If not specified, it could follow higher-level vertical orientation settings.  Currently on iOS, it's always horizontal.  The behavior for any other value is undefined.
@property (strong, nonatomic) NSNumber * verticalGlyphForm;

/// 初始化字符串
+ (instancetype)string;

/// 初始化字符串
/// @param text 文本
+ (instancetype)stringWithText:(NSString *)text;

/// 用字符串id获取部分字符串
/// @param stringId 字符串id
/// @return 子字符串
- (WZZAttributedString *)findSubStringWithId:(NSString *)stringId;

@end
