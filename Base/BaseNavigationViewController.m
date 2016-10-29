//
//  BaseNavigationViewController.m
//  MyApplication
//
//  Created by XWQ on 16/10/26.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()
@property(nonatomic,retain)UIImageView *backgroundView;

@end

@implementation BaseNavigationViewController

#pragma mark Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height)];
    self.backgroundView.tag = 999;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.navigationBar addSubview:self.backgroundView];
    [self.navigationBar sendSubviewToBack:self.backgroundView];
    self.navigationBar.shadowImage=nil;
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"" size:19],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self initApplicationView];
    [self initApplicationSkin];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark 公共方法
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setBackgroundImage:(UIImage*)image
{
    if(nil!=image)
    {
        self.backgroundView.image=image;
    }
}

-(void)initApplicationView
{
    
}

-(void)initApplicationSkin
{
    self.view.backgroundColor=[UIColor whiteColor];
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        if ([[UIDevice currentDevice].systemVersion doubleValue]<7.0f) {
            [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"juxing"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=7.0f)
    {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"juxing"] forBarMetrics:UIBarMetricsDefault];        
    }else
    {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"juxing"] forBarMetrics:UIBarMetricsDefault];
    }
}
#pragma mark 设置状态了字体
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
