//
//  UIView+Extension.h
//  Unity-iPhone
//
//  Created by 66-admin on 16/11/17.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *  截屏当前View
 *
 *  @return 截图
 */
- (UIImage *)snapshotImage;

- (void)imageViewShowAnimation;

- (UIViewController *)currentController;

@property (nonatomic, assign) CGFloat org_x;
@property (nonatomic, assign) CGFloat org_y;
@property (nonatomic, assign) CGFloat org_w;
@property (nonatomic, assign) CGFloat org_h;
@property (nonatomic, assign) CGSize  org_size;
@property (nonatomic, assign) CGPoint org_origin;

@end
