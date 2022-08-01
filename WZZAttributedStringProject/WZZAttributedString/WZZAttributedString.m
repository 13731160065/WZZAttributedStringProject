//
//  WZZAttributedString.m
//  HNBaoDai
//
//  Created by wyq_iMac on 2022/7/19.
//  Copyright © 2022 王泽众. All rights reserved.
//

#import "WZZAttributedString.h"

#define DEF_WeakSelf __weak WZZAttributedString * weakSelf = self

@interface WZZAttributedString ()

/// 富文本链
@property (strong, nonatomic) NSArray * stringLink;

@end

@implementation WZZAttributedString

+ (instancetype)string {
    WZZAttributedString * str = [[WZZAttributedString alloc] init];
    [str setup];
    return str;
}

+ (instancetype)stringWithText:(NSString *)text {
    WZZAttributedString * str = [WZZAttributedString string];
    str.text = text;
    return str;
}

- (void)setup {
    DEF_WeakSelf;
    self.stringLink = @[weakSelf];//弱引用，以免循环引用
}

- (NSAttributedString *)attributedText {
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] init];
    
    for (WZZAttributedString * item in self.stringLink) {
        if (!item.text) {
            continue;
        }
        NSMutableDictionary * mdic = [self handleSelfDic:item];
        
        NSAttributedString * itemAtt = [[NSAttributedString alloc] initWithString:item.text attributes:mdic];
        [string appendAttributedString:itemAtt];
        //挂件
        if (mdic[NSAttachmentAttributeName]) {
            [string appendAttributedString:[NSAttributedString attributedStringWithAttachment:mdic[NSAttachmentAttributeName]]];
        }
    }
    
    return string;
}

- (NSString *)plainText {
    NSMutableString * string = [NSMutableString string];
    
    for (WZZAttributedString * item in self.stringLink) {
        if (!item.text) {
            continue;
        }
        [string appendString:item.text];
    }
    
    return string;
}

- (NSMutableDictionary *)handleSelfDic:(WZZAttributedString *)item {
    NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
    if (item.font) {
        mdic[NSFontAttributeName] = item.font;
    }
    if (item.color) {
        mdic[NSForegroundColorAttributeName] = item.color;
    }
    if (item.backgroundColor) {
        mdic[NSBackgroundColorAttributeName] = item.backgroundColor;
    }
    if (item.paragraphStyle) {
        mdic[NSParagraphStyleAttributeName] = item.paragraphStyle;
    }
    if (item.ligature) {
        mdic[NSLigatureAttributeName] = item.paragraphStyle;
    }
    if (item.kern) {
        mdic[NSKernAttributeName] = item.kern;
    }
    if (item.tracking) {
        if (@available(iOS 14.0, *)) {
            mdic[NSTrackingAttributeName] = item.tracking;
        } else {
            
        }
    }
    if (item.strikethroughStyle) {
        mdic[NSStrikethroughStyleAttributeName] = item.strikethroughStyle;
    }
    if (item.strikethroughColor) {
        mdic[NSStrikethroughColorAttributeName] = item.strikethroughColor;
    }
    if (item.strokeColor) {
        mdic[NSStrokeColorAttributeName] = item.strokeColor;
    }
    if (item.strokeWidth) {
        mdic[NSStrokeWidthAttributeName] = item.strokeWidth;
    }
    if (item.shadow) {
        mdic[NSShadowAttributeName] = item.shadow;
    }
    if (item.textEffect) {
        mdic[NSTextEffectAttributeName] = item.textEffect;
    }
    if (item.attachment) {
        mdic[NSAttachmentAttributeName] = item.attachment;
    }
    if (item.link) {
        mdic[NSLinkAttributeName] = item.link;
    }
    if (item.baselineOffset) {
        mdic[NSBaselineOffsetAttributeName] = item.baselineOffset;
    }
    if (item.underlineColor) {
        mdic[NSUnderlineColorAttributeName] = item.underlineColor;
    }
    if (item.underlineStyle) {
        mdic[NSUnderlineStyleAttributeName] = item.underlineStyle;
    }
    if (item.obliqueness) {
        mdic[NSObliquenessAttributeName] = item.obliqueness;
    }
    if (item.expansion) {
        mdic[NSExpansionAttributeName] = item.expansion;
    }
    if (item.writingDirection) {
        mdic[NSWritingDirectionAttributeName] = item.writingDirection;
    }
    if (item.verticalGlyphForm) {
        mdic[NSVerticalGlyphFormAttributeName] = item.verticalGlyphForm;
    }
    return mdic;
}

- (NSDictionary<NSAttributedStringKey,id> *)attributesDictionary {
    return [self handleSelfDic:self];
}

- (WZZAttributedString *)findSubStringWithId:(NSString *)stringId {
    for (WZZAttributedString * item in self.stringLink) {
        if ([item.stringId isEqualToString:stringId]) {
            return item;
        }
    }
    return nil;
}

#pragma mark - 链式方法

- (WZZAttributedString *(^)(WZZAttributedString *))appendString {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(WZZAttributedString *) = ^WZZAttributedString *(WZZAttributedString *attString) {
        NSMutableArray * marr = [NSMutableArray arrayWithArray:weakSelf.stringLink];
        [marr addObjectsFromArray:attString.stringLink];
        attString.stringLink = marr;
        return attString;
    };
    return block;
}

- (WZZAttributedString *(^)(NSString *))appendNewString {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSString *) = ^WZZAttributedString *(NSString *text) {
        WZZAttributedString * string = [WZZAttributedString stringWithText:text];
        return weakSelf.appendString(string);
    };
    return block;
}

- (WZZAttributedString *(^)(NSString *))setupText {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSString *) = ^WZZAttributedString *(NSString * text) {
        weakSelf.text = text;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(UIColor *))setupColor {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(UIColor *) = ^WZZAttributedString *(UIColor * color) {
        weakSelf.color = color;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(UIFont *))setupFont {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(UIFont *) = ^WZZAttributedString *(UIFont * font) {
        weakSelf.font = font;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(UIColor *))setupBackgroundColor {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(UIColor *) = ^WZZAttributedString *(UIColor * color) {
        weakSelf.backgroundColor = color;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(NSTextAttachment *))setupAttachment {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSTextAttachment *) = ^WZZAttributedString *(NSTextAttachment * attachment) {
        weakSelf.attachment = attachment;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(UIImage *, CGRect))setupImageAttachment {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(UIImage *, CGRect) = ^WZZAttributedString *(UIImage * image, CGRect frame) {
        NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = frame;
        weakSelf.attachment = attachment;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(id))setupLink {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(id) = ^WZZAttributedString *(id link) {
        if ([link isKindOfClass:[NSURL class]] || [link isKindOfClass:[NSString class]]) {
            weakSelf.link = link;
        }
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(WZZAttributedString *__autoreleasing *))ref {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(WZZAttributedString *__autoreleasing *) = ^WZZAttributedString *(WZZAttributedString *__autoreleasing * refadd) {
        *refadd = weakSelf;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(NSString *))setupStringId {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSString *) = ^WZZAttributedString *(NSString * aid) {
        weakSelf.stringId = aid;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(NSNumber *))setupUnderlineStyle {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSNumber *) = ^WZZAttributedString *(NSNumber * obj) {
        weakSelf.underlineStyle = obj;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(UIColor *))setupUnderlineColor {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(UIColor *) = ^WZZAttributedString *(UIColor * obj) {
        weakSelf.underlineColor = obj;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(NSShadow *))setupShadow {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSShadow *) = ^WZZAttributedString *(NSShadow * obj) {
        weakSelf.shadow = obj;
        return weakSelf;
    };
    return block;
}

- (WZZAttributedString *(^)(NSParagraphStyle *))setupParagraphStyle {
    DEF_WeakSelf;
    WZZAttributedString *(^block)(NSParagraphStyle *) = ^WZZAttributedString *(NSParagraphStyle * obj) {
        weakSelf.paragraphStyle = obj;
        return weakSelf;
    };
    return block;
}

@end
