//
//  CustomTopCell.m
//  Unity-iPhone
//
//  Created by 66-admin on 2017/1/20.
//
//

#import "CustomTopCell.h"
#import "UIColor+Extensions.h"
#import "CGControl.h"
#import "UIView+Extension.h"

#define LabelToLabel    12.f
#define LabelToYH       5.f
#define ImageWidth      12.f

@interface CustomTopCell ()

@property (nonatomic, strong) UIView            *   bgView;
@property (nonatomic, strong) UIImageView       *   deleteImageView;
@property (nonatomic, strong) UILabel           *   titleLabel;
@property (nonatomic, assign) CGFloat               bordWidth;
@property (nonatomic, assign) CGFloat               textFont;

@end

@implementation CustomTopCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.bordWidth = 0.5f;
        self.textFont  = 13.f;
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.deleteImageView];
    }
    return self;
}

- (UIView *)bgView {

    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor    = [UIColor colorWithHexString:@"ebecee"];
        _bgView.layer.cornerRadius = 3.0;
        _bgView.layer.borderWidth  = self.bordWidth;
        _bgView.layer.borderColor  = [UIColor colorWithHexString:@"#e3e3e3" alpha:1.0].CGColor;
    }
    return _bgView;
}

- (UILabel *)titleLabel {

    if (_titleLabel == nil) {
        _titleLabel = [CGControl createLabelWithFrame:CGRectZero font:self.textFont text:nil];
        _titleLabel.backgroundColor = [UIColor colorWithHexString:@"ebecee"];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)deleteImageView {

    if (_deleteImageView == nil) {
        _deleteImageView = [CGControl createImageViewFrame:CGRectZero imageName:@"channel_edit_delete@2x.png"];
        _deleteImageView.backgroundColor     = [UIColor clearColor];
        _deleteImageView.layer.masksToBounds = YES;
    }
    return _deleteImageView;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    _bgView.frame = CGRectMake(LabelToLabel / 2.0, LabelToYH, self.org_w - LabelToLabel, self.org_h - LabelToYH * 2);
    _titleLabel.frame = CGRectMake(_bgView.org_x, _bgView.org_y, _bgView.org_w, _bgView.org_h);
    _deleteImageView.frame = CGRectMake(_bgView.org_x + _bgView.org_w - ImageWidth / 2.0, _bgView.org_y - ImageWidth / 2.0 + 1.5f, ImageWidth, ImageWidth);
}

- (void)refreshCustomTopCellWithData:(NSDictionary *)dataDict {

    _titleLabel.text = [NSString stringWithFormat:@"%@", [dataDict objectForKey:@"tname"]];
}

@end

@interface CustomBottomCell ()

@property (nonatomic, strong) UIView            *   bgView;
@property (nonatomic, strong) UILabel           *   titleLabel;
@property (nonatomic, assign) CGFloat               bordWidth;
@property (nonatomic, assign) CGFloat               textFont;

@end

@implementation CustomBottomCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.bordWidth = 0.5f;
        self.textFont  = 13.f;
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
    }
    return self;
}

- (UIView *)bgView {
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor    = [UIColor colorWithHexString:@"ebecee"];
        _bgView.layer.cornerRadius = 3.0;
        _bgView.layer.borderWidth  = self.bordWidth;
        _bgView.layer.borderColor  = [UIColor colorWithHexString:@"#e3e3e3" alpha:1.0].CGColor;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel == nil) {
        _titleLabel = [CGControl createLabelWithFrame:CGRectZero font:self.textFont text:nil];
        _titleLabel.backgroundColor = [UIColor colorWithHexString:@"ebecee"];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _bgView.frame = CGRectMake(LabelToLabel / 2.0, LabelToYH, self.org_w - LabelToLabel, self.org_h - LabelToYH * 2);
    _titleLabel.frame = CGRectMake(0, 0, _bgView.org_w, _bgView.org_h);
}

- (void)refreshCustomBottomCellWithData:(NSDictionary *)dataDict {

    _titleLabel.text = [NSString stringWithFormat:@"+ %@", [dataDict objectForKey:@"tname"]];
}

@end
