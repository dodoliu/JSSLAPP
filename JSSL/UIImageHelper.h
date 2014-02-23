//
//  UIImageHelper.h
//  JSSL
//
//  Created by LDY on 14-2-23.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//
//处理图片的相关操作
//功能：放大缩小图片
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageHelper : NSObject

/**
 *图片放大缩小的方法
 * oldImage：原图片
 * newSize：改变后图片的大小
 */
-(UIImage *)scaleToSize:(UIImage *)oldImage newSize:(CGSize)newSize;

@end
