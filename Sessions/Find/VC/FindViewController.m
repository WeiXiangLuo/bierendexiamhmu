//
//  FindViewController.m
//  MyApplication
//
//  Created by XWQ on 16/10/27.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "FindViewController.h"
#import "BaseViewController.h"
#import "LXViewSelectorController.h"

#define  screenW [UIScreen mainScreen].bounds.size.width
#define  screenH  [UIScreen mainScreen].bounds.size.height
#define RandomColor [UIColor colorWithRed:(random()%255)/255.0 green:(random()%255)/255.0 blue:(random()%255)/255.0 alpha:1]

@interface FindViewController ()
@property UIView *myView;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //页面的数组和标题数组
    
    NSMutableArray *vcArr = [NSMutableArray array];
    NSArray *titleArr = @[@"最新", @"最热"];
    
    
    for (int i= 0; i<2; i++) {
    
        UIViewController *vc = [[UIViewController alloc]init];
        
        vc.view.backgroundColor = RandomColor;
        
        [vcArr addObject:vc];
    }
    //初始化并PUSH
    LXViewSelectorController *vc = [[LXViewSelectorController alloc]initWithControllers:vcArr title:titleArr];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
    
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
