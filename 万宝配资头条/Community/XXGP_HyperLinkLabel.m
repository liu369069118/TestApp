
#import "XXGP_HyperLinkLabel.h"
#import "DTCoreText.h"

@interface XXGP_HyperLinkLabel () <TYAttributedLabelDelegate>

@end

@implementation XXGP_HyperLinkLabel

#pragma mark -
#pragma mark - Public Method
- (void)setHyperLinkLabelText:(NSString *)textString {
    if (textString.length <= 0) return;
    if (![textString containsString:@"href"]) {
        self.text = textString;
        return;
    }
    
    NSMutableAttributedString *attributedString = [self getMainStringFromHTMLString:textString];
    [self addHyperlinkWithAttributedString:attributedString textColor:self.linkColor ? self.linkColor : [HCColor HCBlueColor]];
}
- (void)setHyperLinkLabelText:(NSString *)textString textColor:(UIColor *)textColor {
    if (textString.length <= 0) return;
    if (![textString containsString:@"href"]) {
        self.text = textString;
        return;
    }
    NSMutableAttributedString *attributedString = [self getMainStringFromHTMLString:textString];
    [self addHyperlinkWithAttributedString:attributedString textColor:textColor];
}

#pragma mark -
#pragma mark - Private Method
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.verticalAlignment = TYVerticalAlignmentCenter;
        self.linkFont = [HCFont pingfangRegular:14];
        self.numberOfLines = 2;
        self.lineBreakMode = kCTLineBreakByTruncatingTail;
        self.textColor = [HCColor grayColor:155];
        self.font = [HCFont pingfangRegular:14];
        self.linesSpacing = 20.f;
        self.characterSpacing = 0.f;
    }
    return self;
}

- (void)addHyperlinkWithAttributedString:(NSAttributedString *)attributedString textColor:(UIColor *)textColor {
    NSMutableArray *hyperlinkArray = [NSMutableArray arrayWithCapacity:1];
    
    [attributedString enumerateAttributesInRange:NSMakeRange(0, attributedString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSURL *linkUrl = [attrs valueForKey:NSLinkAttributeName];
        if ([linkUrl absoluteString].length > 0) {
            if ([[linkUrl absoluteString] containsString:@"hold://"] ||
                [[linkUrl absoluteString] containsString:@"https://"] ||
                [[linkUrl absoluteString] containsString:@"http://"]) {
                TYLinkTextStorage *linkTextStorage = [self createTextStorageWithLinkRange:range
                                                                                     font:self.linkFont
                                                                                textColor:textColor
                                                                                 linkData:[linkUrl absoluteString]];
                [hyperlinkArray addObject:linkTextStorage];
            }
        }
    }];
    
    self.textContainer.text = attributedString.string;
    [self addTextStorageArray:[hyperlinkArray copy]];
}

- (TYLinkTextStorage *)createTextStorageWithLinkRange:(NSRange)linkRange
                                                 font:(UIFont *)font
                                            textColor:(UIColor *)textColor
                                             linkData:(id)linkData {
    TYLinkTextStorage *linkTextStorage = [[TYLinkTextStorage alloc]init];
    linkTextStorage.range = linkRange;
    linkTextStorage.font = font;
    linkTextStorage.textColor = textColor;
    linkTextStorage.linkData = linkData;
    linkTextStorage.underLineStyle = kCTUnderlineStyleNone;
    
    return linkTextStorage;
}

#pragma mark -
#pragma mark - TYAttributedLabelDelegate
- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point {
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        NSString *linkString = ((TYLinkTextStorage*)TextRun).linkData;
        self.actionClickBlock ? self.actionClickBlock(linkString) : nil;
        
        if (_hyperLinkTextClickBlock) {
            _hyperLinkTextClickBlock(linkString);
            return;
        }
        if ([linkString containsString:@"hold://"]) {
//            [HCRouterManager openURL:linkString];
        } else if ([linkString containsString:@"https://"] ||
                   [linkString containsString:@"http://"]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
            [dict setValue:linkString forKey:@"url"];
//            [HCRouterManager openURL:[HCUtil getRouterName:@"HCArticleWebController"]
//                            withPara:dict];
        }
    }
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    if ([textStorage isKindOfClass:[TYLinkTextStorage class]]) {
        NSString *linkString = ((TYLinkTextStorage*)textStorage).linkData;
        if (_hyperLinkTextLongPressedBlock) {
            _hyperLinkTextLongPressedBlock(linkString);
            return;
        }
    }
}

- (NSMutableAttributedString *)getMainStringFromHTMLString:(NSString *)htmlString {
    if (htmlString.length <= 0) {
        return nil;
    }
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@"</br>"];
    // HTML 文本转换
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding)};
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置富文本
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithHTMLData:data documentAttributes:nil];
    
    return attributedString;
}


@end
