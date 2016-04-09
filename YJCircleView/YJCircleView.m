//
//  YJCircleView.m
//  YJCircleView
//
//  Created by iOS on 16/4/9.
//  Copyright © 2016年 Junjie. All rights reserved.
//

#import "YJCircleView.h"

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180)
#define RADIANS_TO_DEGREES(radians) (radians * 180)/M_PI

@interface YJCircleView ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end

@implementation YJCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _width            = CGRectGetWidth(frame);
        _height           = _width;

        frame.size.height = frame.size.width;
        self.frame        = frame;

        _paddingWidth     = 0;
        _circleWidth      = (_width/2)/5;
        _lineStyle        = LineStyleFlat;
    }
    return self;
}

- (void)setAnticlockwise:(BOOL)anticlockwise {
    
    _anticlockwise = anticlockwise;
    [self setNeedsDisplay];
}

- (void)setPercent:(CGFloat)percent {
    
    _percent = percent;
    if (_percent > 1) {
        self.degrees = 360;
    } else {
        self.degrees = 360*_percent;
    }
}

- (void)setDegrees:(CGFloat)degrees {
    
    _degrees = degrees;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //General circle info
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    
    if (_paddingWidth > 0) {
        float radius             = _width/2 - _paddingWidth/2;

        UIBezierPath *edgeCircle = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:radius
                                                              startAngle:DEGREES_TO_RADIANS(0.0f)
                                                                endAngle:DEGREES_TO_RADIANS(360.0f)
                                                               clockwise:YES];
        [_paddingStrokeColor setStroke];
        edgeCircle.lineWidth     = _paddingWidth;
        [edgeCircle stroke];
    }
    
    
    float radius = _width/2 - _paddingWidth - _circleWidth/2;
    //Background circle
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:center
                                                          radius:radius
                                                      startAngle:DEGREES_TO_RADIANS(0.0f)
                                                        endAngle:DEGREES_TO_RADIANS(360.0f)
                                                       clockwise:YES];
    [_circleStrokeColor setStroke];
    circle.lineWidth = _circleWidth;
    [circle stroke];
    
    
    if (_degrees > 0) {
        
        //Active circle
        float startAngle = -90.0f;
        float endAngle    = startAngle+_degrees;
        
        if (_anticlockwise) {
            startAngle = -90 - _degrees;
            endAngle   = -90;
        }
        
        if (_lineStyle == LineStyleRound && _degrees != 360) {
            startAngle += 5;
        }
        
        circle = [UIBezierPath bezierPathWithArcCenter:center
                                                radius:radius
                                            startAngle:DEGREES_TO_RADIANS(startAngle)
                                              endAngle:DEGREES_TO_RADIANS(endAngle)
                                             clockwise:YES];
        
        [_activeCircleStrokeColor setStroke];
        circle.lineWidth = _circleWidth;
        [circle stroke];
        
        
        if (_lineStyle == LineStyleRound && _degrees != 360) {
            
            CGFloat x = center.x + radius*cos(DEGREES_TO_RADIANS(startAngle));
            CGFloat y = center.y + radius*sin(DEGREES_TO_RADIANS(startAngle));
            
            circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y)
                                                    radius:_circleWidth/2
                                                startAngle:0
                                                  endAngle:M_PI*2
                                                 clockwise:YES];
            
            [_activeCircleStrokeColor setFill];
            [circle fill];
            
            x = center.x + radius*cos(DEGREES_TO_RADIANS(endAngle));
            y = center.y + radius*sin(DEGREES_TO_RADIANS(endAngle));
            circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y)
                                                    radius:_circleWidth/2
                                                startAngle:0
                                                  endAngle:M_PI*2
                                                 clockwise:YES];
            
            [_activeCircleStrokeColor setFill];
            [circle fill];
        }
        
    }
}

- (UILabel*)valueLabel {
    
    if (_valueLabel == nil) {
        
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((_width-110 * _scale)/2,
                                                                (_height-40 * _scale)/2 + 10* _scale,
                                                                110 * _scale,
                                                                40  * _scale)];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font          = [UIFont fontWithName:@"DINSchrift" size:50];
        _valueLabel.textColor     = [UIColor whiteColor];
        [self addSubview:_valueLabel];
    }
    return _valueLabel;
}

- (UIButton *)descButton {
    
    if (_descButton == nil) {
        CGFloat interalRadius    = _width/2 - _paddingWidth - _circleWidth;
        CGFloat y                = CGRectGetMaxY(self.valueLabel.frame)-10 - interalRadius/2 - 20*_scale;
        
        _descButton              = [[UIButton alloc] initWithFrame:CGRectMake((_width-100)/2,
                                                                              y,
                                                                              100,
                                                                              20)];
        _descButton.titleLabel.font = [UIFont systemFontOfSize:12*_scale];
        _descButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_descButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateNormal];
        [_descButton setTitle:@"今日里程(km)" forState:UIControlStateNormal];
        [self addSubview:_descButton];
    }
    
    return _descButton;
}

@end
