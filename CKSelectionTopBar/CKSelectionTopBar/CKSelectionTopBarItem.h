//
//  CKSelectionTopBarItem.h
//  CommonKit
//
//  Created by 徐建波 on 2017/10/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CKSelectionTopBarItem : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString *icon; //选择情况下：当icon有值时，替换文字，显示为图片
@property (nonatomic, strong) UIImage *placeholderIcon; //icon未加载出来时显示的占位图片

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, strong) UIFont * font;   //字体大小

@property (nonatomic, strong) UIFont * selectedFont; //选中字体大小（默认用font）

@property (nonatomic, strong) UIColor * normalColor;  //正常状态颜色

@property (nonatomic, strong) UIColor * nightColor;  //夜间状态颜色

@property (nonatomic, strong) UIColor * selectedColor;//选中状态字体颜色

@property (nonatomic, strong) UIColor * selectedNightColor;//选中状态夜间模式颜色

@property (nonatomic, strong) UIColor * backgroundColor; //背景颜色

@property (nonatomic, strong) UIColor * selectedBorderColor; //选中状态边款颜色

@property (nonatomic, assign) BOOL isNight;//是否是夜间模式

@property (nonatomic, assign) BOOL isNotScale; //选中是否放大

@property (nonatomic, assign) BOOL showBottomLine; //显示底部跟踪线条
@property (nonatomic, assign) CGFloat bottomLineHeight;//底部跟踪线高度
@property (nonatomic, assign) CGFloat bottomLineBottomConstraint;//底部线距离底部距离(正值)
@property (nonatomic, strong) UIColor *bottomLineColor;//底部线颜色
@property (nonatomic, assign) CGFloat bottomLineLeftOffset;//底部线距离label左边的偏移
@property (nonatomic, assign) CGFloat bottomLineRightOffset;//底部线距离label右边的偏移
@property (nonatomic, assign) CGFloat bottomLineCornerRadius;//底部跟踪线圆角
@property (nonatomic, assign) CGFloat bottomLineWidth;//底部线宽度（大于0时，则居中显示，左右约束无效）
@property (nonatomic, assign) CGFloat titleBottomConstraint;//标题距离底部距离(正值)
@property (nonatomic, assign) CGFloat titleTopConstraint;//标题距离顶部距离(正值)
@end
