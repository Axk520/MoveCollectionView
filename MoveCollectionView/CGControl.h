//
//  CGControl.h
//  Unity-iPhone
//
//  Created by AnXuKun on 15/9/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CGControl : NSObject

/**
 *  切割view某一个脚为圆角 0:左上角 1：右上角 2：左下角 3：右下角 4：全部角
 *
 *  @param view 要切换的view
 *  @param num  0:左上角 1：右上角 2：左下角 3：右下角 4：全部角
 *  @param size 切割弧度
 */
+ (void)viewWithLayerCornerRadiusWithButton:(UIView *)view andRadiusNum:(NSInteger)num andSize:(CGSize)size;

+ (UILabel *)createNetworkLoadLabelWithText:(NSString *)text;

+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIView *)createViewWithFrame:(CGRect)frame color:(UIColor *)color;

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(float)font text:(NSString *)text;

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName target:(id)target method:(SEL)select;

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

+ (UITextField *)createTextFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder bgImageName:(NSString *)imageName leftView:(UIView *)leftView rightView:(UIView *)rightView isPassWord:(BOOL)isPassWord;

+ (void)startAnimationWithView:(UIView *)animationView;

@end
