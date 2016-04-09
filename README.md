# YJCircleView
适用各种环形进度展示
###Example
初始化进度条

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
    _changeTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progressChange) userInfo:nil     repeats:YES];
    _circularView.valueLabel.text            = @"15";
    _circularView.descButton.titleLabel.text = @"今日里程(km)";

    _circularView.paddingStrokeColor         = [UIColor colorWithWhite:1 alpha:0.2];


    _circularView.circleStrokeColor          = [UIColor colorWithWhite:1 alpha:0.4];

    _circularView.activeCircleStrokeColor    = [UIColor colorWithWhite:1 alpha:0.8];

    [self.view addSubview:_circularView];

    }

###Remind
    附带设置渐变背景
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

