//
//  CKSelectionTopBarCell.m
//  CommonKit
//
//  Created by 徐建波 on 2017/10/17.
//

#import "CKSelectionTopBarCell.h"
#import "UIColor+CKSelectionAssist.h"
#import "Masonry.h"
#import "UIButton+YYWebImage.h"

@interface CKSelectionTopBarCell()

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIView * bottomLine;

@end

@implementation CKSelectionTopBarCell

- (void)setItem:(CKSelectionTopBarItem *)item {
    _item = item;
    [self.button setTitle:item.title forState:UIControlStateNormal];
    UIColor * titleColor = _item.normalColor;
    UIColor * titleSelectedColor = _item.selectedColor;
    if (_item.isNight) {
        titleColor = _item.nightColor ?:_item.normalColor;
        titleSelectedColor = _item.selectedNightColor ?: _item.selectedColor;
    }
    [self.button setTitleColor:titleColor forState:UIControlStateNormal];
    [self.button setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    
    self.button.titleLabel.font = item.font;
    if (_item.titleBottomConstraint > 0 && _item.titleTopConstraint > 0) {
        [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(_item.titleTopConstraint);
            make.bottom.mas_equalTo(-_item.titleBottomConstraint);
            make.right.mas_equalTo(-8);
        }];
    }
    [self setSelected:self.selected];
    
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (!_item) {
        return;
    }
    if (selected) {
        if (_item.showBottomLine) {
            self.bottomLine.backgroundColor = _item.bottomLineColor;
            if (_item.bottomLineCornerRadius > 0) {
                self.bottomLine.layer.cornerRadius = _item.bottomLineCornerRadius;
            }
            self.bottomLine.hidden = NO;
            [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                CGFloat left = _item.bottomLineLeftOffset;
                CGFloat right = _item.bottomLineRightOffset;
                CGFloat bottom = _item.bottomLineBottomConstraint;
                CGFloat height = _item.bottomLineHeight;
                if (_item.bottomLineWidth > 0) {
                    make.bottom.mas_equalTo(-bottom);
                    make.height.mas_equalTo(height);
                    make.width.mas_equalTo(_item.bottomLineWidth);
                    make.centerX.equalTo(self.contentView);
                }else {
                    make.left.mas_equalTo(self.button.titleLabel.mas_left).offset(-left);
                    make.right.mas_equalTo(self.button.titleLabel.mas_right).offset(right);
                    make.bottom.mas_equalTo(-bottom);
                    make.height.mas_equalTo(height);
                }
                //                make.left.mas_equalTo(self.button.titleLabel.mas_left).offset(-left);
                //                make.right.mas_equalTo(self.button.titleLabel.mas_right).offset(right);
                //                make.bottom.mas_equalTo(-bottom);
                //                make.height.mas_equalTo(height);
            }];
        }
    } else {
        if (_item.showBottomLine) {
            self.bottomLine.hidden = YES;
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        if (selected) {
            self.button.selected = YES;
            if (self.item.selectedFont) {
                self.button.titleLabel.font = self.item.selectedFont;
            }
            if (self.item.selectedBorderColor) {
                UIColor * borderColor = self.item.selectedBorderColor;
                UIColor * backgroundColor = [UIColor whiteColor];
                if (self.item.isNight) {
                    borderColor = [UIColor clearColor];
                    backgroundColor = [UIColor colorWithHexString:@"#2c2c2c"];
                }
                self.button.backgroundColor = backgroundColor;
                self.button.layer.borderColor = borderColor.CGColor;
                
            } else {
                self.button.layer.borderColor = [UIColor clearColor].CGColor;
            }
            
            if (self.item.icon.length) {
                //选中i情况下，如果有icon的话，则替换文字为图片
                [self.button setTitle:nil forState:UIControlStateNormal];
                [self.button yy_setImageWithURL:[NSURL URLWithString:self.item.icon] forState:UIControlStateNormal placeholder:self.item.placeholderIcon];
            }
            
            //没有显示边框的情况下才要选中变大
            if (!self.item.isNotScale) {
                self.button.transform = CGAffineTransformMakeScale(1.15, 1.15);
            } else {
                self.button.transform = CGAffineTransformIdentity;
            }
        } else {
            if (self.item.icon.length) {
                [self.button setTitle:self.item.title forState:UIControlStateNormal];
                [self.button setImage:nil forState:UIControlStateNormal];
            }
            self.button.titleLabel.font = self.item.font;
            self.button.transform = CGAffineTransformIdentity;
            self.button.selected = NO;
            self.button.layer.borderColor = [UIColor clearColor].CGColor;
            self.button.backgroundColor = [UIColor clearColor];
        }
    }];
    
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_button];
        _button.layer.borderWidth = 0.5;
        _button.layer.cornerRadius = 12;
        _button.userInteractionEnabled = NO;
        _button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _button.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button.titleLabel.numberOfLines = 0;
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.top.mas_equalTo(8);
            make.bottom.mas_equalTo(-8);
            make.right.mas_equalTo(-8);
        }];
    }
    return _button;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        [self.contentView addSubview:_bottomLine];
        _bottomLine.hidden = YES;
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat left = 0;
            CGFloat right = 0;
            CGFloat bottom = 0;
            CGFloat height = 2;
            if (_item) {
                left = _item.bottomLineLeftOffset;
                right = _item.bottomLineRightOffset;
                bottom = _item.bottomLineBottomConstraint;
                height = _item.bottomLineHeight;
            }
            
            if (_item.bottomLineWidth > 0) {
                make.bottom.mas_equalTo(-bottom);
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(_item.bottomLineWidth);
                make.centerX.equalTo(self.contentView);
            }else {
                make.left.mas_equalTo(self.button.titleLabel.mas_left).offset(-left);
                make.right.mas_equalTo(self.button.titleLabel.mas_right).offset(right);
                make.bottom.mas_equalTo(-bottom);
                make.height.mas_equalTo(height);
            }
        }];
    }
    return _bottomLine;
}

@end

