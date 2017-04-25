//
//  UIColor+Extensions.m
//  Unity-iPhone
//
//  Created by 66-admin on 16/11/27.
//
//

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (UIColor *)getColorWithHexString:(NSString *)hexColor {
    
    if (hexColor.length < 7) {
        return [UIColor clearColor];
    }
    
    unsigned int alpha, red, green, blue;
    NSRange range;
    range.length   = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&alpha];//透明度
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 7;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:(float)(alpha/255.0f)];
}

/**
 *  根据十六进制字符串转换为UIColor
 *
 *  @param colorStr 十六进制颜色字符串
 *
 *  @return 对应颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr {
    
    return [self colorWithHexString:colorStr alpha:1.0f];
}


/**
 *  根据十六进制字符串转换为UIColor
 *
 *  @param colorStr   十六进制颜色字符串
 *  @param colorAlpha 透明度
 *
 *  @return 对应颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorStr
                          alpha:(CGFloat)colorAlpha
{
    if (!colorStr || [colorStr isEqualToString:@""]) {
        return nil;
    }
    
    //删除字符串中的空格
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:colorAlpha];
}

+ (UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}


@end
