//
//  YJCircleView.h
//  YJCircleView
//
//  Created by iOS on 16/4/9.
//  Copyright © 2016年 Junjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJCircleView : UIView

typedef NS_ENUM(NSInteger, LineStyle) {
    LineStyleFlat,
    LineStyleRound,
};

@property (nonatomic, assign) CGFloat   paddingWidth;               // 外边宽度
@property (nonatomic, assign) CGFloat   circleWidth;                // 环宽

@property (nonatomic, strong) UIColor   *paddingStrokeColor;        // 外边色值
@property (nonatomic, strong) UIColor   *circleStrokeColor;         // 背景环色值
@property (nonatomic, strong) UIColor   *activeCircleStrokeColor;   //进度条环色值

@property (nonatomic, assign) NSInteger lineStyle;                  // 进度线条样式（圆顶、平顶）
@property (nonatomic, assign) CGFloat   degrees;                    // 进度条角度
@property (nonatomic, assign) CGFloat   percent;                    // 进度百分比
@property (nonatomic, assign) CGFloat   scale;                      // 界面缩放参数

@property (nonatomic, assign) BOOL      anticlockwise;              // 逆时针 default is NO


@property (nonatomic, strong) UILabel   *valueLabel;
@property (nonatomic, strong) UILabel   *unitLabel;
@property (nonatomic, strong) UIButton  *descButton;

@end
