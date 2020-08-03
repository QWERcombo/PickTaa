//
//  SDChatTableViewCell.m
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/2/13.
//  Copyright © 2016年 GSD. All rights reserved.
//

/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 362419100(2群) 459274049（1群已满）
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDChatTableViewCell.h"

#import "UIView+SDAutoLayout.h"


#define kLabelMargin 20.f
#define kLabelTopMargin 8.f
#define kLabelBottomMargin 20.f

#define kChatCellItemMargin 10.f

#define kChatCellIconImageViewWH 35.f

#define kMaxContainerWidth 220.f
#define kMaxLabelWidth (kMaxContainerWidth - kLabelMargin * 2)

#define kMaxChatImageViewWidth 200.f
#define kMaxChatImageViewHeight 300.f

@interface SDChatTableViewCell () <MLEmojiLabelDelegate>

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *containerBackgroundImageView;
@property (nonatomic, strong) MLEmojiLabel *label;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *maskImageView;

@end

@implementation SDChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _iconImageView = [UIImageView new];
    [self.contentView addSubview:_iconImageView];
    
    _container = [UIView new];
    [self.contentView addSubview:_container];
    
    _label = [MLEmojiLabel new];
    _label.delegate = self;
    _label.font = [UIFont systemFontOfSize:16.0f];
    _label.numberOfLines = 0;
    _label.textInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _label.isAttributedContent = YES;
    [_container addSubview:_label];
    
    _messageImageView = [UIImageView new];
    [_container addSubview:_messageImageView];
    
    _containerBackgroundImageView = [UIImageView new];
    [_container insertSubview:_containerBackgroundImageView atIndex:0];
    
    _maskImageView = [UIImageView new];
    
    
    [self setupAutoHeightWithBottomView:_container bottomMargin:0];
    
    // 设置containerBackgroundImageView填充父view
    _containerBackgroundImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
}


- (void)setModel:(PTChatRecordContentModel *)model
{
    _model = model;
    
    _label.text = model.content;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"login_logo"]];
    
    // 根据model设置cell左浮动或者右浮动样式
    [self setMessageOriginWithModel:model];
    
    if (!String_IsEmpty(model.pic)) { // 有图片的先看下设置图片自动布局
        
        // cell重用时候清除只有文字的情况下设置的container宽度自适应约束
        [self.container clearAutoWidthSettings];
        self.messageImageView.hidden = NO;
        self.messageImageView.size = CGSizeMake(120, 120);
        _container.sd_layout.widthIs(120).heightIs(120);
        [_container setupAutoHeightWithBottomView:self.messageImageView bottomMargin:kChatCellItemMargin];
        @weakify(self)
        [self.messageImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"chat_icon_9"] options:SDWebImageAvoidDecodeImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(self)
            // 根据图片的宽高尺寸设置图片约束
            CGFloat standardWidthHeightRatio = kMaxChatImageViewWidth / kMaxChatImageViewHeight;
            CGFloat widthHeightRatio = 0;
            CGFloat h = image.size.height;
            CGFloat w = image.size.width;
            
            if (w > kMaxChatImageViewWidth || w > kMaxChatImageViewHeight) {
                
                widthHeightRatio = w / h;
                
                if (widthHeightRatio > standardWidthHeightRatio) {
                    w = kMaxChatImageViewWidth;
                    h = w * (image.size.height / image.size.width);
                } else {
                    h = kMaxChatImageViewHeight;
                    w = h * widthHeightRatio;
                }
            }
            
            self.messageImageView.size = CGSizeMake(w, h);
            self->_container.sd_layout.widthIs(w).heightIs(h);
            
            // 设置container以messageImageView为bottomView高度自适应
            [self->_container setupAutoHeightWithBottomView:self.messageImageView bottomMargin:kChatCellItemMargin];
            
            // container按照maskImageView裁剪
            self.container.layer.mask = self.maskImageView.layer;
            
            @weakify(self)
            [self->_containerBackgroundImageView setDidFinishAutoLayoutBlock:^(CGRect frame) {
                // 在_containerBackgroundImageView的frame确定之后设置maskImageView的size等于containerBackgroundImageView的size
                @strongify(self)
                self.maskImageView.size = frame.size;
                [self.tableView reloadRow:self.tag inSection:0 withRowAnimation:UITableViewRowAnimationNone];
            }];
//            NSLog(@"--%@++%@", error, image);
        }];
        
    } else if (!String_IsEmpty(model.content)) { // 没有图片有文字情况下设置文字自动布局
        
        // 清除展示图片时候用到的mask
        [_container.layer.mask removeFromSuperlayer];
        
        self.messageImageView.hidden = YES;
        
        // 清除展示图片时候_containerBackgroundImageView用到的didFinishAutoLayoutBlock
        _containerBackgroundImageView.didFinishAutoLayoutBlock = nil;
        
        _label.sd_resetLayout
        .leftSpaceToView(_container, kLabelMargin)
        .topSpaceToView(_container, kLabelTopMargin)
        .autoHeightRatio(0); // 设置label纵向自适应
        
        // 设置label横向自适应
        [_label setSingleLineAutoResizeWithMaxWidth:kMaxContainerWidth];
        
        // container以label为rightView宽度自适应
        [_container setupAutoWidthWithRightView:_label rightMargin:kLabelMargin];
        
        // container以label为bottomView高度自适应
        [_container setupAutoHeightWithBottomView:_label bottomMargin:kLabelBottomMargin];
    }
}



- (void)setMessageOriginWithModel:(PTChatRecordContentModel *)model
{
    if (model.position == SDMessageTypeSendToOthers) {
        // 发出去的消息设置居右样式
        self.iconImageView.sd_resetLayout
        .rightSpaceToView(self.contentView, kChatCellItemMargin)
        .topSpaceToView(self.contentView, kChatCellItemMargin)
        .widthIs(kChatCellIconImageViewWH)
        .heightIs(kChatCellIconImageViewWH);
        
        _container.sd_resetLayout.topEqualToView(self.iconImageView).rightSpaceToView(self.iconImageView, kChatCellItemMargin);
        
        _containerBackgroundImageView.image = [[UIImage imageNamed:@"SenderTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    } else if (model.position == SDMessageTypeSendToMe) {
        
        // 收到的消息设置居左样式
        self.iconImageView.sd_resetLayout
        .leftSpaceToView(self.contentView, kChatCellItemMargin)
        .topSpaceToView(self.contentView, kChatCellItemMargin)
        .widthIs(kChatCellIconImageViewWH)
        .heightIs(kChatCellIconImageViewWH);
        
        _container.sd_resetLayout.topEqualToView(self.iconImageView).leftSpaceToView(self.iconImageView, kChatCellItemMargin);
        
        _containerBackgroundImageView.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }
    
    _maskImageView.image = _containerBackgroundImageView.image;
}



#pragma mark - MLEmojiLabelDelegate
/*
 - (void)mlEmojiLabel:(MLEmojiLabel *)emojiLabel didSelectLink:(NSString *)link withType:(MLEmojiLabelLinkType)type
 {
 if (self.didSelectLinkTextOperationBlock) {
 self.didSelectLinkTextOperationBlock(link, type);
 }
 }
 */

@end
