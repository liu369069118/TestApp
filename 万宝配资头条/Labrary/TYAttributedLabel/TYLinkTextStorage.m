
#import "TYLinkTextStorage.h"

@implementation TYLinkTextStorage

- (instancetype)init
{
    if (self = [super init]) {
        self.underLineStyle = kCTUnderlineStyleSingle;
        self.modifier = kCTUnderlinePatternSolid;
    }
    return self;
}

#pragma mark - protocol

- (void)addTextStorageWithAttributedString:(NSMutableAttributedString *)attributedString
{
    [super addTextStorageWithAttributedString:attributedString];
    [attributedString addAttribute:kTYTextRunAttributedName value:self range:self.range];
    self.text = [attributedString.string substringWithRange:self.range];

}

@end
