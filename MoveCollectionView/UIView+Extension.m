//
//  UIView+Extension.m
//  Unity-iPhone
//
//  Created by 66-admin on 16/11/17.
//
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (UIImage *)snapshotImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage * snap = UIGraphicsGetImageFromCurrentImageContext();
    CGContextConcatCTM(context, CGAffineTransformRotate(CGAffineTransformIdentity, - M_PI_2));
    UIGraphicsEndImageContext();
    return [UIImage imageWithCGImage:snap.CGImage scale:1.f orientation:UIImageOrientationRight];
}

- (void)imageViewShowAnimation {

    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.35;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    NSMutableArray * values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.4)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 1.4, 1.4)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.4)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

- (UIViewController *)currentController {
    
    UIResponder * next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (void)setOrg_x:(CGFloat)org_x {

    CGRect frame   = self.frame;
    frame.origin.x = org_x;
    self.frame     = frame;
}

- (CGFloat)org_x {
    
    return self.frame.origin.x;
}

- (void)setOrg_y:(CGFloat)org_y {
    
    CGRect frame   = self.frame;
    frame.origin.y = org_y;
    self.frame     = frame;
}

- (CGFloat)org_y {
    
    return self.frame.origin.y;
}

- (void)setOrg_w:(CGFloat)org_w {
    
    CGRect frame     = self.frame;
    frame.size.width = org_w;
    self.frame       = frame;
}

- (CGFloat)org_w {

    return self.frame.size.width;
}

- (void)setOrg_h:(CGFloat)org_h {
    
    CGRect frame      = self.frame;
    frame.size.height = org_h;
    self.frame        = frame;
}

- (CGFloat)org_h {
    
    return self.frame.size.height;
}

- (void)setOrg_size:(CGSize)org_size {

    CGRect frame = self.frame;
    frame.size   = org_size;
    self.frame   = frame;
}

- (CGSize)org_size {

    return self.frame.size;
}

- (void)setOrg_origin:(CGPoint)org_origin {

    CGRect frame = self.frame;
    frame.origin = org_origin;
    self.frame   = frame;
}

- (CGPoint)org_origin {

    return self.frame.origin;
}

@end
