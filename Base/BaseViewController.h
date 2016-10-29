//
//  BaseViewController.h
//  MyApplication
//
//  Created by XWQ on 16/10/26.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  设置左边按钮
 *  @since 2.0
 */
-(void)setNavigationBarLeftItemOfButton:(UIButton *)button withFrame:(CGRect)frame withNormalImage:(UIImage *)normalImage withHighlightedImage:(UIImage *)highlightedImage withTarget:(id)target withSEL:(SEL)action;


/**
 *  设置右边按钮
 *  @since 2.0
 */
-(void)setNavigationBarRightItemOfButton:(UIButton *)button withFrame:(CGRect)frame withNormalImage:(UIImage *)normalImage withHighlightedImage:(UIImage *)highlightedImage withTarget:(id)target withSEL:(SEL)action;



@end
