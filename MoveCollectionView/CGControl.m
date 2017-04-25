//
//  CGControl.m
//  Unity-iPhone
//
//  Created by AnXuKun on 15/9/15.
//
//

#import "CGControl.h"

@implementation CGControl

+ (void)viewWithLayerCornerRadiusWithButton:(UIView *)view andRadiusNum:(NSInteger)num andSize:(CGSize)size {
    
    UIBezierPath * maskPath;
    if (num == 0) {
        maskPath  = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft       cornerRadii:size];
    }else if (num == 1) {
        maskPath  = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopRight      cornerRadii:size];
    }else if (num == 2) {
        maskPath  = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft    cornerRadii:size];
    }else if (num == 3) {
        maskPath  = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomRight   cornerRadii:size];
    }else {
        maskPath  = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners    cornerRadii:size];
    }
    
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path  = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (UILabel *)createNetworkLoadLabelWithText:(NSString *)text {
    
    UILabel * lb_desc = [[UILabel alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 25)/2.0 - 64, [UIScreen mainScreen].bounds.size.width, 25)];
    lb_desc.lineBreakMode   = NSLineBreakByTruncatingTail;
    lb_desc.numberOfLines   = 1;
    lb_desc.contentMode     = UIViewContentModeCenter;
    lb_desc.backgroundColor = [UIColor clearColor];
    lb_desc.textColor       = [UIColor grayColor];
    lb_desc.textAlignment   = NSTextAlignmentCenter;
    lb_desc.font = [UIFont boldSystemFontOfSize:13.0];
    lb_desc.text = text;
    return lb_desc;
}

+ (void)startAnimationWithView:(UIView *)animationView {
    
    CABasicAnimation * theAnimation;
    theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    theAnimation.duration    = 0.5;
    theAnimation.repeatCount = INTMAX_MAX;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue   = [NSNumber numberWithFloat:M_PI*2];
    [animationView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

+ (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * endImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return endImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIView *)createViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView * view = [[UIView alloc] initWithFrame:frame];
    if (color != nil) {
        view.backgroundColor = color;
    }
    
    return view;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame font:(float)font text:(NSString *)text {
    
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:font];
    //设置折行方式
//    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    if (text) {
        label.text = text;
    }
    label.textAlignment = NSTextAlignmentLeft;
    label.layer.masksToBounds = YES;
    
    return label;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName target:(id)target method:(SEL)select {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    
    [button addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName {
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    
    if (imageName) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    
    imageView.userInteractionEnabled = YES;
    imageView.layer.masksToBounds    = YES;
    
    return imageView;
}

+ (UITextField *)createTextFieldFrame:(CGRect)frame placeholder:(NSString *)placeholder bgImageName:(NSString *)imageName leftView:(UIView *)leftView rightView:(UIView *)rightView isPassWord:(BOOL)isPassWord {
    
    UITextField * textField = [[UITextField alloc] initWithFrame:frame];
    
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    if (imageName) {
        textField.background = [UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView = rightView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry = YES;
    }
    
    return textField;
}

@end
