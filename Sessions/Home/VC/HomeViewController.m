//
//  HomeViewController.m
//  MyApplication
//
//  Created by XWQ on 16/10/27.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "HomeViewController.h"
#import "My_Header.h"
#import "HXSelectorViewController.h"
#define RowMagrin 10 //瀑布流上下间隔
#define ColMagrin 15 //瀑布流左右间隔
#define colHeight 40 //瀑布流高度



@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
       //页面的数组和标题数组
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"生活", @"商务", @"定制"];
    
    for (int i= 0; i<3; i++) {
        
        UIViewController *vc = [[UIViewController alloc]init];
        
        vc.view.backgroundColor =[UIColor whiteColor];
        
        [vcArr addObject:vc];
    }
    //初始化并PUSH
//    HXSelectorViewController *vc = [[HXSelectorViewController alloc]initWithControllers:vcArr title:titleArr];
//    
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    

    
 
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
