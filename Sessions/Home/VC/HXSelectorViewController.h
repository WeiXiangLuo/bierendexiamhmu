//
//  HXSelectorViewController.h
//  NewEnjoyDate
//
//  Created by 青山小明 on 16/10/29.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSelectorViewController : UIViewController
- (instancetype)initWithControllers:(NSArray<UIViewController*>*)controllers title:(NSArray<NSString*>*)titles;

//标题字的大小（默认14）
@property (nonatomic, assign)CGFloat fontSize;

//提示条大小（默认40，2）
@property (nonatomic ,assign)CGSize tipSize;

//选中颜色(默认为红色)
@property (nonatomic , assign)UIColor *selecedColor;

//未选中颜色（默认颜色）
@property (nonatomic ,assign)UIColor *normalColor;

@end
