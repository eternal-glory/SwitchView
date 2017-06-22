//
//  JRSwitchView.m
//  WHSwitchDome
//
//  Copyright © 2017年 lei JR. All rights reserved.
//

#import "JRSwitchView.h"

#define JRSwitchMaxHeight 80.0f
#define JRSwitchMinHeight 20.0f
#define JRSwitchMinWidth 40.0f

@interface JRSwitchView ()
/** 子控件View */
@property (strong, nonatomic) UIView * containerView;

@property (strong, nonatomic) UIView * onContentView;

@property (strong, nonatomic) UIView * offContentView;

/** 左文字Label */
@property (strong, nonatomic) UILabel * leftLabel;
/** 右文字Label */
@property (strong, nonatomic) UILabel * rightLabel;
/** 文字颜色 */
@property (strong, nonatomic) UIColor * textColor;
/** 中心旋转钮 */
@property (strong, nonatomic) UIView * knobView;

@property (assign, nonatomic) NSInteger ballSize;

@end

@implementation JRSwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initSubView];
    }
    
    return self;
}

- (void)initSubView {
    
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor whiteColor];
    
    self.ballSize = self.bounds.size.height * 0.9;
    
    _onTintColor = [UIColor colorWithRed:240/255.0 green:0/255.0 blue:130/255.0 alpha:1.0];
    _offTintColor = [UIColor colorWithRed:0 / 255.0 green:192 / 255.0 blue:246 / 255.0 alpha:1.0];
    _font = [UIFont systemFontOfSize:17.0f];
    
    [self addSubview:self.containerView];
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizerEvent:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizerEvent:)];
    [self addGestureRecognizer:panGesture];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    
    CGFloat radius = CGRectGetHeight(self.containerView.bounds) / 2.0f;
    
    self.containerView.layer.cornerRadius = radius;
    self.containerView.layer.masksToBounds = YES;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0f;
    CGFloat w = CGRectGetWidth(self.containerView.bounds);
    CGFloat h = CGRectGetHeight(self.containerView.bounds);
    
    if (!self.isOn) {
        
        self.onContentView.frame = CGRectMake(-w, 0, w, h);
        
        self.offContentView.frame = CGRectMake(0, 0, w, h);
        
        self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
    } else {
        
        self.onContentView.frame = CGRectMake(0, 0, w, h);
        self.offContentView.frame = CGRectMake(w, 0, w, h);
        self.knobView.frame = CGRectMake(w - margin - self.ballSize, margin, self.ballSize, self.ballSize);
        
    }
    
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = radius - (sqrtf(pow(radius, 2) - powf(lHeight / 2.0f, 2))) + margin;
    
    self.leftLabel.frame = CGRectMake(lMargin, radius - lHeight / 2.0f, w - lMargin - self.ballSize - 2 * margin, lHeight);
    self.rightLabel.frame = CGRectMake(self.ballSize + 2 * margin, radius - lHeight / 2.0f, w - lMargin - self.ballSize - 2 * margin, lHeight);
    
}

#pragma mark - - - setter 方法 - - -
- (void)setOnTintColor:(UIColor *)onTintColor {
    _onTintColor = onTintColor;
    _onContentView.backgroundColor = onTintColor;
}

- (void)setOffTintColor:(UIColor *)offTintColor {
    _offTintColor = offTintColor;
    _offContentView.backgroundColor = offTintColor;
}

- (void)setThumbTint:(UIColor *)thumbTint {
    _thumbTint = thumbTint;
    self.knobView.backgroundColor = thumbTint;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    
    self.leftLabel.font = font;
    self.rightLabel.font = font;
}

- (void)setLeftText:(NSString *)leftText {
    _leftText = leftText;
    self.leftLabel.text = leftText;
}

- (void)setRightText:(NSString *)rightText {
    _rightText = rightText;
    self.rightLabel.text = rightText;
}

- (void)setLeftColorText:(UIColor *)leftColorText {
    _leftColorText = leftColorText;
    self.leftLabel.textColor = leftColorText;
}

- (void)setRightColorText:(UIColor *)rightColorText {
    _rightColorText = rightColorText;
    self.rightLabel.textColor = rightColorText;
}

- (void)setBounds:(CGRect)bounds {
    
    [super setBounds:[self roundRect:bounds]];
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:[self roundRect:frame]];
    [self setNeedsLayout];
}

#pragma mark - - - 私有方法 - - -
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    
    _on = on;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0f;
    CGFloat w = CGRectGetWidth(self.containerView.bounds);
    CGFloat h = CGRectGetHeight(self.containerView.bounds);
    
    if (!animated) {
        
        if (!self.isOn) {
            
            self.onContentView.frame = CGRectMake(-w, 0, w, h);
            
            self.offContentView.frame = CGRectMake(0, 0, w, h);
            
            self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
        } else {
            
            self.onContentView.frame = CGRectMake(0, 0, w, h);
            self.offContentView.frame = CGRectMake(w, 0, w, h);
            self.knobView.frame = CGRectMake(w - margin - self.ballSize, margin, self.ballSize, self.ballSize);
        }
        
    } else {
        
        if (self.isOn) {
            
            [UIView animateWithDuration:0.25f animations:^{
                self.knobView.frame = CGRectMake(w - margin - self.ballSize, margin, self.ballSize, self.ballSize);
            } completion:^(BOOL finished) {
                self.onContentView.frame = CGRectMake(0, 0, w, h);
                self.offContentView.frame = CGRectMake(w, 0, w, h);
            }];
            
        } else {
            
            [UIView animateWithDuration:0.25f animations:^{
                self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
            } completion:^(BOOL finished) {
                self.onContentView.frame = CGRectMake(-w, 0, w, h);
                self.offContentView.frame = CGRectMake(0, 0, w, h);
            }];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(wh_switchView:)]) {
        [self.delegate wh_switchView:self];
    }
}

- (void)handleTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:YES];
    }
}

- (void)handlePanGestureRecognizerEvent:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0f;
    
    CGFloat offSet = 6.0f;
    
    CGFloat w = CGRectGetWidth(self.containerView.bounds);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            
            if (!self.isOn) {
                [UIView animateWithDuration:0.25 animations:^{
                    self.knobView.frame = CGRectMake(margin, margin, self.ballSize + offSet, self.ballSize);
                }];
            } else {
                [UIView animateWithDuration:0.25f animations:^{
                    self.knobView.frame = CGRectMake(w - margin - (self.ballSize + offSet), margin, self.ballSize + offSet, self.ballSize);
                }];
            }
            
            break;
            
        case UIGestureRecognizerStateCancelled:
            
            break;
            
        case UIGestureRecognizerStateFailed:
            
            if (!self.isOn) {
                [UIView animateWithDuration:0.25f animations:^{
                    self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
                }];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                    self.knobView.frame = CGRectMake(w - self.ballSize, margin, self.ballSize, self.ballSize);
                }];
            }
            break;
        case UIGestureRecognizerStateChanged:
            
            break;
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn animated:YES];
            break;
        case UIGestureRecognizerStatePossible:
            break;
        default:
            break;
    }
    
}

- (CGRect)roundRect:(CGRect)frame {
    
    CGRect rect = frame;
    
    if (rect.size.height > JRSwitchMaxHeight) {
        rect.size.height = JRSwitchMaxHeight;
    }
    
    if (rect.size.height < JRSwitchMinHeight) {
        rect.size.height = JRSwitchMinHeight;
    }
    
    if (rect.size.width < JRSwitchMinWidth) {
        rect.size.width = JRSwitchMinWidth;
    }
    
    return rect;
}

#pragma mark - - - getter 方法 - - -

- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.backgroundColor = [UIColor clearColor];
        
        [_containerView addSubview:self.onContentView];
        [_containerView addSubview:self.offContentView];
        [_containerView addSubview:self.knobView];
    }
    
    return _containerView;
}

- (UIView *)onContentView {
    
    if (!_onContentView) {
        _onContentView = [[UIView alloc] initWithFrame:self.bounds];
        _onContentView.backgroundColor = _onTintColor;
        [_onContentView addSubview:self.leftLabel];
    }
    
    return _onContentView;
}

- (UIView *)offContentView {
    
    if (!_offContentView) {
        _offContentView = [[UIView alloc] initWithFrame:self.bounds];
        _offContentView.backgroundColor = _offTintColor;
        [_offContentView addSubview:self.rightLabel];
    }
    
    return _offContentView;
}

- (UIView *)knobView {
    
    if (!_knobView) {
        _knobView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.ballSize, self.ballSize)];
        _knobView.backgroundColor = [UIColor whiteColor];
        _knobView.layer.cornerRadius = self.ballSize / 2.0f;
        _knobView.layer.masksToBounds = YES;
    }
    
    return _knobView;
}

- (UILabel *)leftLabel {
    
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = _font;
        _leftLabel.textColor = self.textColor;
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.textColor = self.textColor;
        _rightLabel.font = _font;
    }
    return _rightLabel;
}
@end
