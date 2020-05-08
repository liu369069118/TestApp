//
//  WBCommunityLayout.m
//  宝万盯盘
//
//  Created by 辛峰 on 2020/5/8.
//  Copyright © 2020 宝万盯盘. All rights reserved.
//

#import "WBCommunityLayout.h"
#import "CoreText/CoreText.h"

@interface WBCommunityLayout ()

@property (nonatomic, assign) BOOL isFromTopicDetail;

@end

@implementation WBCommunityLayout

- (instancetype)initWithTopicModel:(WBCommunityModel *)topicModel {
    return [self initWithTopicModel:topicModel isFromTopicDetail:NO];
}

- (instancetype)initWithTopicModel:(WBCommunityModel *)topicModel isFromTopicDetail:(BOOL)isFromTopicDetail {
    if (self = [super init]) {
        _topicModel = topicModel;
        _isFromTopicDetail = isFromTopicDetail;
        [self calculationLayout];
    }
    return self;
}

- (void)calculationLayout {
    _communityContentView_x = kWBCommunityCellLeftMargin;
    _communityContentView_y = kWBCommunityCellTopMargin;
    _communityContentView_w = kScreenWidth - kWBCommunityCellLeftMargin - kWBCommunityCellRightMargin;
    
    [self layoutHeaderView];
    [self layoutTopicView];
    [self layoutTitleView];
    [self layoutContentView];
    [self layoutPictureView];
    [self layoutFunctionView];
    
    _communityContentView_h = _functionView_y + _functionView_h;
    _communityCellHeight = _communityContentView_y + _communityContentView_h + kWBCommunityCellBottomMargin;
}

- (void)layoutHeaderView {
    _headerView_y = 0;
    _headerView_w = _communityContentView_w;
    
    if (_topicModel.userModel.nickname.length > 0 ||
        _topicModel.userModel.identity.length > 0) {
        _headerView_h = 18;
    } else {
        _headerView_h = 0;
    }
}

- (void)layoutTopicView {
    _topicView_w = _communityContentView_w;
    
    if (_topicModel.topicTagModel.name.length > 0 && !_isFromTopicDetail) {
        _topicView_y = _headerView_y + _headerView_h + kWBCommunityCellNormalMargin;
        _topicView_h = 21;
    } else {
        _topicView_y = _headerView_y + _headerView_h;
        _topicView_h = 0;
    }
}

- (void)layoutTitleView {
    _titleView_w = _communityContentView_w;
    
    if (_topicModel.title.length > 0) {
        _titleView_y = _topicView_y + _topicView_h + kWBCommunityCellSmallMargin;
         
        
        CGFloat currentHeight = [self sizeForText:_topicModel.title font:kWBCommunityTitleFont size:CGSizeMake(_titleView_w, kWBCommunityTitleFont.lineHeight * 3) mode:0].height;
        
        _titleView_h = currentHeight + 1;
    } else {
        _titleView_y = _topicView_y + _topicView_h;
        _titleView_h = 0;
    }
}

- (CGSize)sizeForText:(NSString *)text font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    UIFont *uiFont = font;
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef) uiFont.fontName, uiFont.pointSize, NULL);

    // When you create an attributed string the default paragraph style has a leading
    // of 0.0. Create a paragraph style that will set the line adjustment equal to
    // the leading value of the font.
    CGFloat leading = uiFont.lineHeight - uiFont.ascender + uiFont.descender;
    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof (CGFloat), &leading };

    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
    CFRange textRange = CFRangeMake(0, text.length);

    // Create an empty mutable string big enough to hold our test
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, text.length);

    // Inject our text into it
    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) text);

    // Apply our font and line spacing attributes over the span
    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, ctFont);
    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CFRange fitRange;

    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, CGSizeMake(size.width, size.height + uiFont.lineHeight), &fitRange);

    CFRelease(framesetter);
    CFRelease(string);
    
    return frameSize;
}

- (void)layoutContentView {
    if (_topicModel.title.length > 0) {
        _contentView_y = _titleView_y + _titleView_h;
        _contentView_h = 0;
        _contentView_w = 0;
        return;
    }
    if (_topicModel.content.length > 0) {
        _contentView_y = _titleView_y + _titleView_h + kWBCommunityCellNormalMargin;
        _contentLabel_w = _communityContentView_w;
        
        _contentNumberOfLine = 5;
        
        
        CGFloat maxHeight = [self sizeForText:_topicModel.content_str font:kWBCommunityContentFont size:CGSizeMake(_contentLabel_w, 2000) mode:0].height;

        CGFloat currentHeight = [self sizeForText:_topicModel.content_str font:kWBCommunityContentFont size:CGSizeMake(_contentLabel_w, kWBCommunityContentFont.lineHeight * _contentNumberOfLine) mode:0].height;
        
        _contentLabel_h = currentHeight;
        
        if (maxHeight > currentHeight) {
            _showRetractButton = YES;
            
            _retractButton_y = currentHeight + 4;
            _retractButton_w = 35;
            _retractButton_h = 15;
            
            currentHeight += 4 + _retractButton_h;
        } else {
            _showRetractButton = NO;
        }
        
        _contentView_h = currentHeight;
    } else {
        _contentView_y = _titleView_y + _titleView_h;
        _contentView_h = 0;
    }
    
    _contentView_w = _communityContentView_w;
}

- (void)layoutPictureView {
    if (_topicModel.title.length > 0) {
        _pictureView_y = _contentView_y + _contentView_h;
        _pictureView_h = 0;
        _pictureView_w = 0;
        return;
    }
    
    _pictureView_w = _communityContentView_w;
    
    if (_topicModel.img_data_list.count > 0) {
        _communityPictureSize = (_pictureView_w - 8) / 3;
        
        _pictureView_y = _contentView_y + _contentView_h + kWBCommunityCellNormalMargin;
        
        if (_topicModel.img_data_list.count == 1) {
            _pictureView_h = _topicModel.firstImageHeight;
        } else if (_topicModel.img_data_list.count == 2 ||
                   _topicModel.img_data_list.count == 3){
            _pictureView_h = _communityPictureSize;
        } else if (_topicModel.img_data_list.count == 4) {
            _pictureView_h = _communityPictureSize * 2 + kWBCommunityCellSmallMargin;
        }
    } else {
        _pictureView_y = _contentView_y + _contentView_h;
        
        _pictureView_h = 0;
    }
}

- (void)layoutFunctionView {
    _functionView_y = _pictureView_y + _pictureView_h;
    
    _functionView_w = _communityContentView_w;
    _functionView_h = 38;
}

@end
