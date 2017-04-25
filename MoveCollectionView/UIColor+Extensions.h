//
//  UIColor+Extensions.h
//  Unity-iPhone
//
//  Created by 66-admin on 16/11/27.
//
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B)     [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

@interface UIColor (Extensions)

/**
 *  获取前面带有透明度的十六进制颜色
 *
 *  @param hexColor 颜色
 *
 *  @return 对应颜色
 */
+ (UIColor *)getColorWithHexString:(NSString *)hexColor;

/**
 *  根据十六进制字符串转换为UIColor, 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @param colorStr 十六进制颜色字符串
 *
 *  @return 对应颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr;

/**
 *  根据十六进制字符串转换为UIColor, 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *
 *  @param colorStr   十六进制颜色字符串
 *  @param colorAlpha 透明度
 *
 *  @return 对应颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr
                          alpha:(CGFloat)colorAlpha;


+ (UIColor *)colorWithRGB:(int)color alpha:(float)alpha;

@end
