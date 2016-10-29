//
//  BaseViewController.m
//  MyApplication
//
//  Created by XWQ on 16/10/26.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(void)setNavigationBarLeftItemOfButton:(UIButton *)button withFrame:(CGRect)frame withNormalImage:(UIImage *)normalImage withHighlightedImage:(UIImage *)highlightedImage withTarget:(id)target withSEL:(SEL)action
{
    button.frame = frame;
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)setNavigationBarRightItemOfButton:(UIButton *)button withFrame:(CGRect)frame withNormalImage:(UIImage *)normalImage withHighlightedImage:(UIImage *)highlightedImage withTarget:(id)target withSEL:(SEL)action
{
    button.frame = frame;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    button.backgroundColor = [UIColor clearColor];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
