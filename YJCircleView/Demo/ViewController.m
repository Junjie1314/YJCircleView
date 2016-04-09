//
//  ViewController.m
//  YJCircleView
//
//  Created by iOS on 16/4/9.
//  Copyright © 2016年 Junjie. All rights reserved.
//

#import "ViewController.h"
#import "YJCircleView.h"
#import "sys/utsname.h"
#define headColor [UIColor colorWithRed:18/255. green:55/255. blue:60/255. alpha:1]
#define tailColor [UIColor colorWithRed:150/255. green:188/255. blue:130/255. alpha:1]
@interface ViewController ()

@property (nonatomic, strong) YJCircleView *circularView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSTimer *changeTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _width  = CGRectGetWidth(self.view.frame);
    _height = CGRectGetHeight(self.view.frame);
    _scale  = _width/320.;
    [self setBackColor];
    [self initCircularView];
}

//设置渐变背景
- (void)setBackColor {
    
    UIView* view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];// 设置渐变效果
    _gradientLayer.bounds           = view.bounds;
    _gradientLayer.borderWidth      = 0;
    _gradientLayer.frame            = view.bounds;
    _gradientLayer.colors           = [NSArray arrayWithObjects:
                                       (id)[headColor CGColor],
                                       (id)[tailColor CGColor], nil];
    
    [view.layer insertSublayer:_gradientLayer atIndex:0];
    
    [self.view insertSubview:view atIndex:0];
}

- (void)initCircularView {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    CGFloat width = (320-60*2)*_scale;
    
    if ([deviceString isEqualToString:@"iPhone4,1"]) {
        
        _circularView = [[YJCircleView alloc] initWithFrame:CGRectMake((_width-width)/2,
                                                                         (_height-49*2 - width - 20*2*_scale - 60*_scale),
                                                                         width,
                                                                         width)];
    }else {
        
        _circularView = [[YJCircleView alloc] initWithFrame:CGRectMake((_width-width)/2,
                                                                         (_height-49*2 - width - 20*2*_scale - 60*_scale)-50*_scale,
                                                                         width,
                                                                         width)];
        
    }
    _circularView.backgroundColor = [UIColor clearColor];
    _circularView.scale           = _scale;
    _circularView.lineStyle       = LineStyleRound;
    _circularView.paddingWidth    = 15*_scale;
    _circularView.circleWidth     = 10*_scale;
    _circularView.degrees         = 1;
    _changeTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    _circularView.valueLabel.text            = @"15";
    _circularView.descButton.titleLabel.text = @"今日里程(km)";

    _circularView.paddingStrokeColor         = [UIColor colorWithWhite:1 alpha:0.2];


    _circularView.circleStrokeColor          = [UIColor colorWithWhite:1 alpha:0.4];

    _circularView.activeCircleStrokeColor    = [UIColor colorWithWhite:1 alpha:0.8];

    [self.view addSubview:_circularView];
    
}

- (void)progressChange {
    
    self.circularView.percent += 0.01;
    if (self.circularView.percent > 0.6f) {
        [_changeTimer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
