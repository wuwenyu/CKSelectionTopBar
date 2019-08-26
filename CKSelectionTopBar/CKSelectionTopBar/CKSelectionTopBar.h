//
//  CKSelectionTopBar.h
//  CommonKit
//
//  Created by 徐建波 on 2017/10/10.
//

#import <UIKit/UIKit.h>

#define kCKTopBarHeight  40

typedef NS_ENUM(NSUInteger, CKSelectionViewMode) {
    CKSelectionViewModeDefault,      //默认不透明
    CKSelectionViewModeTranslucent,  //半透明的
};

@protocol CKSelectionTopBarDelegate;

@interface CKSelectionTopBar : UIView

@property (nonatomic, strong) NSArray * titlesArray;

@property (nonatomic, weak) id <CKSelectionTopBarDelegate>delegate;

@property (nonatomic, assign) NSInteger selectedIndex; //当前选中

@property (nonatomic, strong) UIFont * font;   //字体大小

@property (nonatomic, strong) UIFont * selectedFont; //选中状态字体颜色（默认用font）

@property (nonatomic, strong) UIColor * normalColor;  //正常状态颜色

@property (nonatomic, strong) UIColor * nightColor;   //夜间模式字体颜色

@property (nonatomic, strong) UIColor * selectedColor;//选中状态字体颜色

@property (nonatomic, strong) UIColor * selectedNightColor; //选中夜间模式颜色

@property (nonatomic, strong) UIColor * selectedBorderColor; //选中的边框颜色（默认无）

@property (nonatomic, strong) UIView * leftView; //左侧视图

@property (nonatomic, assign) CKSelectionViewMode leftViewMode; //左侧视图显示模式

@property (nonatomic, strong) UIView * rightView; //右侧视图

@property (nonatomic, assign) CKSelectionViewMode rightViewMode; //右侧视图显示模式

@property (nonatomic, assign) BOOL isNotScale; //选中是否放大

@property (nonatomic, assign) BOOL showBottomLine; //是否显示底部跟踪线条默认不显示
@property (nonatomic, assign) CGFloat bottomLineHeight;//底部跟踪线高度
@property (nonatomic, assign) CGFloat bottomLineBottomConstraint;//底部线距离底部距离(正值)
@property (nonatomic, assign) CGFloat bottomLineLeftOffset;//底部线距离label左边的偏移
@property (nonatomic, assign) CGFloat bottomLineRightOffset;//底部线距离label右边的偏移
@property (nonatomic, assign) CGFloat bottomLineWidth;//底部线宽度（大于0时，则居中显示，左右约束无效）
@property (nonatomic, assign) CGFloat titleBottomConstraint;//标题距离底部距离(正值)
@property (nonatomic, assign) CGFloat titleTopConstraint;//标题距离顶部距离(正值)

@property (nonatomic, strong) UIColor *bottomLineColor;//底部线颜色
@property (nonatomic, copy) NSString *replaceText;//替换推荐的文字（主要是活动的时候）
@property (nonatomic, copy) NSString *replaceIcon;//替换推荐的文字为图片（主要是活动的时候）
@property (nonatomic, strong) UIImage *replacePlaceholderIcon; //icon未加载出来时显示的占位图片

//刷新
- (void)reloadData;

//选中的文字
- (NSString *)selectedTitle;

//切换分页
- (void)setIndex:(NSUInteger)index animated:(BOOL)animated;

@end

/**
 代理方法
 */
@protocol CKSelectionTopBarDelegate <NSObject>

@optional

/**
 点击回调
 */
- (void)selectionTopBar:(CKSelectionTopBar *)selectionTopBar clickAtIndex:(NSUInteger)index;

@end

