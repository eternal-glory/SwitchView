//
//  JRSwitchView.h
//  WHSwitchDome
//
//  Copyright © 2017年 lei JR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRSwitchView;

@protocol JRSwitchViewDetegate <NSObject>

@optional
- (void)wh_switchView:(JRSwitchView *)swithchView;

@end


@interface JRSwitchView : UIControl

@property (assign, nonatomic, getter=isOn) BOOL on;

@property (weak, nonatomic) id<JRSwitchViewDetegate> delegate;

@property (strong, nonatomic) UIColor * onTintColor;

@property (strong, nonatomic) UIColor * offTintColor;

@property (strong, nonatomic) UIColor * thumbTint;

/** 文字大小 */
@property (strong, nonatomic) UIFont * font;
/** 左文字颜色 */
@property (strong, nonatomic) UIColor * leftColorText;
/** 右文字颜色 */
@property (strong, nonatomic) UIColor * rightColorText;
/** 左文字 */
@property (strong, nonatomic) NSString * leftText;
/** 右文字 */
@property (strong, nonatomic) NSString * rightText;

@end
