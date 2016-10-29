//
//  MyViewController.m
//  MyApplication
//
//  Created by XWQ on 16/10/27.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 88)];
    
    headerView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:headerView];
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
