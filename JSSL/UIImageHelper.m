//
//  UIImageHelper.m
//  JSSL
//
//  Created by LDY on 14-2-23.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//

#import "UIImageHelper.h"

@implementation UIImageHelper

-(UIImage *)scaleToSize:(UIImage *)oldImage newSize:(CGSize)newSize
{
    //创建一个bitmap的context
    //并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newSize);
    
    //绘制改变大小的图片
    [oldImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    //从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
