//
//  HomeTabBarViewController.m
//  MyApplication
//
//  Created by XWQ on 16/10/27.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "HomeTabBarViewController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "PublishViewController.h"
#import "HamletViewController.h"
#import "MyViewController.h"
#import "BaseNavigationViewController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"






/**
 *  屏幕的宽度
 *
 *  @since 2.0
 */
#define mScreenWidth          ([UIScreen mainScreen].bounds.size.width)


/**
 *  屏幕的高度
 *
 *  @since 2.0
 */
#define mScreenHeight         ([UIScreen mainScreen].bounds.size.height)

@interface HomeTabBarViewController ()

@end

@implementation HomeTabBarViewController
{
    UIButton *button;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    FindViewController *findVC = [[FindViewController alloc] init];
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    HamletViewController *hameltVC = [[HamletViewController alloc] init];
    MyViewController *myVC = [[MyViewController alloc] init];
    
    
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *navFind = [[UINavigationController alloc] initWithRootViewController:findVC];
    UINavigationController *navHamelt = [[UINavigationController alloc] initWithRootViewController:hameltVC];
    UINavigationController *navMy = [[UINavigationController alloc] initWithRootViewController:myVC];
    
    RDVTabBarController *tabBarController =self;
    tabBarController.delegate = self;
    [tabBarController setViewControllers:@[navHome, navFind,publishVC,
                                           navHamelt,navMy]];
    self.selectedIndex = 0;
    

    NSArray *tabBarItemImages=  @[@"first", @"found",@"",@"tribe",@"personal-center"];
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"Rent_Bottom"];
    imageview.frame = CGRectMake(0, -15, mScreenWidth, 64);
    [tabBarController.tabBar.backgroundView addSubview:imageview];
   
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"Lease_nomal"] forState:UIControlStateNormal];
    [self.tabBar addSubview:button];
    CGFloat btnWH = 45;
    button.frame = CGRectMake((mScreenWidth - btnWH) *0.5, -10 , btnWH, btnWH);
    [button addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSInteger index = 0;

    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        //item.itemHeight = 65;
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_nomal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        index++;
    }
}

-(void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [button setBackgroundImage:[UIImage imageNamed:@"Lease_nomal"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addButtonClick:(UIButton *)sender{
    [sender setBackgroundImage:[UIImage imageNamed:@"Renttheir_selected"] forState:UIControlStateNormal];

    NSLog(@"add");
}
@end
