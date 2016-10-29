//
//  HXSelectorViewController.m
//  NewEnjoyDate
//
//  Created by 青山小明 on 16/10/29.
//  Copyright © 2016年 Dangerous. All rights reserved.
//

#import "HXSelectorViewController.h"
#import "My_Header.h"
#define LXScreenWidth[[UIScreen mainScreen] bounds].size.width
#define  screenW [UIScreen mainScreen].bounds.size.width
#define  screenH  [UIScreen mainScreen].bounds.size.height

#define RowMagrin 10 //瀑布流上下间隔
#define ColMagrin 15 //瀑布流左右间隔
#define colHeight 40 //瀑布流高度

@interface HXSelectorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong)NSArray<UIViewController*> *controllers;//子控制器
@property (nonatomic , strong)NSArray<NSString*> *titles;//标题
@property (nonatomic , strong)UIView *selectorView;//顶部带选择标题容器
@property (nonatomic , strong)UIView *showView;//子控制器内容显示器
@property (nonatomic,  strong)NSArray <UIButton*>*titleButtons;//标题按钮
@property (nonatomic , strong)UIView *tipView;//位置提示条
@property (nonatomic ,strong) NSArray *originArray;
@property UITextField *searchTextFiled;
@property  UICollectionView * collect;
@property NSArray *cellArray;
@end

@implementation HXSelectorViewController
- (instancetype)initWithControllers:(NSArray<UIViewController*>*)controllers title:(NSArray<NSString*>*)titles{
    
    if (self = [super init]) {
        self.controllers =controllers;
        
        self.titles = titles;
        
        //默认
        
        self.fontSize = 14;
        
        self.tipSize = CGSizeMake(35, 2);
        
        self.normalColor = [UIColor blackColor];
        
        self.selecedColor = [UIColor redColor];
        
        
        
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handpan:)];
    
    [self.view addGestureRecognizer:pan];
    
    self.selectorView = [[UIView alloc]initWithFrame:CGRectMake(0, 64,screenW,70)];
    
   // self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, self.selectorView.frame.size.height+64, screenW, self.view.bounds.size.height - self.selectorView.frame.size.height)];
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, self.selectorView.frame.size.height+64, screenW, screenH-self.selectorView.frame.size.height-64)];
    
    NSMutableArray <UIButton *>*butttons = [NSMutableArray array];
    
    for (int i = 0; i<self.controllers.count; i++) {
        UIViewController *vc = self.controllers[i];
        
        vc.view.frame = CGRectMake(i*self.showView.bounds.size.width, 0, self.showView.bounds.size.width, self.showView.bounds.size.height);
        [self.showView addSubview:vc.view];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(self.selectorView.bounds.size.width/self.controllers.count), 0, self.selectorView.bounds.size.width/self.controllers.count, 44)];
        
        button.tag = i;
        [button.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:i==0? self.selecedColor:self.normalColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [butttons addObject:button];
        [self.selectorView addSubview:button];
        
        self.titleButtons = [NSArray arrayWithArray:butttons];
        
        self.tipView = [[UIView alloc]initWithFrame:CGRectMake(0, self.selectorView.bounds.size.height-2, 40, 2)];
        
        self.tipView.center = CGPointMake(self.titleButtons[0].center.x, self.tipView.center.y);
        
        self.tipView.backgroundColor = [UIColor redColor];
        
        [self.selectorView addSubview:self.tipView];
        
        [self.view addSubview:self.selectorView];
        
        [self.view addSubview:self.showView];
        
        //主页的导航条
        [self homeNav];
        //主页的瀑布流
        [self loadCollectionView];
        
    }
    

    
}
- (void)handlePan:(UIPanGestureRecognizer*)sender  {
    
    CGPoint point = [sender translationInView:self.showView];
    
    CGPoint poi = [sender velocityInView:self.showView];
    
    CGFloat x = self.showView.bounds.origin.x;
    
    if (fabs(point.x)>fabs(point.y)) {
        x-=point.x;
        
        if (x>=0&&x<=self.showView.bounds.size.width*(self.controllers.count-1)) {
            [self setAnimationWithOrigin:x];
        }
    }
    if (sender.state==UIGestureRecognizerStateEnded) {
        
        //poi为速度，point是位移
        //位移超过一半或者滑动结束时速度大于300就翻页，否则还原
        if (poi.x>300) {
            
            int count = (int)x/(int)self.showView.bounds.size.width;
            if (count>0) {
                x = self.showView.bounds.size.width*count;
            }else{
                x = 0;
            }
        }else if(poi.x<-300){
            int count = (int)x/(int)self.showView.bounds.size.width;
            if (count<self.controllers.count-1) {
                x = self.showView.bounds.size.width*(count+1);
            }else{
                x = self.showView.bounds.size.width*(self.controllers.count-1);
            }
        }else{
            int count = (int)x/(int)self.showView.bounds.size.width;
            int deviation = (int)x%(int)self.showView.bounds.size.width;
            if (deviation<self.showView.bounds.size.width/2) {
                x = count*self.showView.bounds.size.width;
            }else if(count<self.controllers.count-1){
                x = count*self.showView.bounds.size.width;
            }else{
                x = (self.controllers.count-1)*self.showView.bounds.size.width;
            }
            
        }
        [UIView animateWithDuration:0.3 animations:^{
            [self setAnimationWithOrigin:x];
        }];
    }
    
    
    [sender setTranslation:CGPointMake(0, 0)inView:self.showView];
    
    
}
- (void)didClickItem:(UIButton*)sender{
    [UIView animateWithDuration:0.3 animations:^{
        [self setAnimationWithOrigin:self.showView.bounds.size.width*sender.tag];
    }];
}
//根据bound偏移量，调整位置
-(void)setAnimationWithOrigin:(CGFloat)x{
    self.showView.bounds=CGRectMake(x, self.showView.bounds.origin.y,self.showView.bounds.size.width, self.showView.bounds.size.height);
    CGFloat tipX = self.selectorView.bounds.size.width/(self.controllers.count*2)+(x/(self.selectorView.bounds.size.width*(self.controllers.count-1)))*self.selectorView.bounds.size.width/(self.controllers.count)*(self.controllers.count-1);
    self.tipView.center=CGPointMake(tipX, self.tipView.center.y);
    [self.originArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((int)tipX==[obj intValue]) {
            [self selectTitleAt:idx];
        }
    }];
}
-(void)selectTitleAt:(NSInteger)index{
    for (int i =0; i<self.titleButtons.count; i++) {
        UIButton *button = self.titleButtons[i];
        [button setTitleColor:i == index?self.selecedColor:self.normalColor forState:UIControlStateNormal];
    }
}

-(NSArray *)originArray{
    if (!_originArray) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (int i=0; i<self.controllers.count; i++) {
            [tempArr addObject:@(self.selectorView.bounds.size.width/(self.controllers.count*2)+self.selectorView.bounds.size.width*i/self.controllers.count)];
        }
        _originArray = [NSArray arrayWithArray:tempArr];
    }
    return _originArray;
}

-(void)homeNav {

    //影藏导航条
    self.navigationController.navigationBar.hidden =YES;
    
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,screenW, 64)];
    
    headerImageView.image = [UIImage imageNamed:@"red_nav.png"];
    
    [self.view addSubview:headerImageView];

    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //西安
    leftButton.frame = CGRectMake(10, 37, 45, 13);
    
    [leftButton setTitle:@"西安" forState:UIControlStateNormal];
    
    
    [headerImageView addSubview:leftButton];
    
    //imageView
    
    UIImageView *sanjiaoImageView= [[UIImageView alloc]init];
    
    sanjiaoImageView.image = [UIImage imageNamed: @"location.png"];
    
    sanjiaoImageView.frame = CGRectMake(50, 40, 5, 5);
    
    [headerImageView addSubview:sanjiaoImageView];
    //搜索框图片视图
    UIImageView *searchImageView = [UIImageView new];
    
    searchImageView.frame = CGRectMake(screenW/2-100, 29, screenW*0.6, 28);
    
    searchImageView.image = [UIImage imageNamed:@"searchBar_back.png"];
    
    [headerImageView addSubview:searchImageView];
    
    UIButton *leftSearchImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftSearchImageButton.frame = CGRectMake(9, 9, 10, 10);
    
    [leftSearchImageButton setImage:[UIImage imageNamed:@"leftSearchButton.png"] forState: UIControlStateNormal ];
    
    
    [searchImageView addSubview:leftSearchImageButton];
    
    //搜索框Textfiled
    
    _searchTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(27, 12, 141, 11)];
    
    _searchTextFiled.attributedPlaceholder = [self addAttribute:@"账号/昵称搜索/条件筛选"];
    
    [searchImageView addSubview:_searchTextFiled];
    
    UIButton *rightSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightSearchButton.frame = CGRectMake(searchImageView.frame.size.width-20, 9, 9, 9);
    
    [rightSearchButton setImage:[UIImage imageNamed:@"screen.png"] forState:UIControlStateNormal];
    
    
    
    [searchImageView addSubview:rightSearchButton];
    //右边的按钮
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightButton.frame = CGRectMake(screenW-40, 25, 28, 31);
    
    
    [rightButton setImage:[UIImage imageNamed:@"ssage_nomal.png"] forState:UIControlStateNormal];
    
    [rightButton setImage: [UIImage imageNamed: @"tribe_selected.png"]forState:UIControlStateHighlighted ];
    
    [headerImageView addSubview:rightButton];

}
#pragma mark----输入框字体的自定义
- (NSMutableAttributedString *)addAttribute:(NSString *)string {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, string.length)];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string.length)];
    return attribute;
}
- (void)loadCollectionView {
    _cellArray = @[@"1.png"];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //每个cell的间距
    CGFloat minimum = 6;
    //一行cell 的个数
    CGFloat count = 2;
    //每一行的上下距离
    CGFloat minimum2 = screenW*0.03;
    //每个cell的宽
    CGFloat cellW = (screenW  - minimum *count - minimum)/count ;
    
    
    //每个cell的高
    CGFloat cellH = cellW+screenW*0.13;
    
    layout.itemSize = CGSizeMake(cellW, cellH);
    
    // 设置每一行的间距
    layout.minimumLineSpacing = minimum2;
    
    // 设置每个cell的间距
    layout.minimumInteritemSpacing = minimum;
    
    // 设置每组的内边距
    layout.sectionInset = UIEdgeInsetsMake(12, minimum, 0, minimum);
    
    //创建collectionView 通过一个布局策略layout来创建
    _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, screenW, screenH-153) collectionViewLayout:layout];
    //代理设置
    _collect.delegate=self;
    _collect.dataSource=self;
    //注册item类型 这里使用系统的类型
    [_collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
    [_showView addSubview:_collect];
    
}
//返回每个分区的item个数

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
    
    
    cell.backgroundColor=[UIColor whiteColor];
    
    float width =(screenW-6*2-6)/2;
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, width+screenW*0.13)];
    
    view.backgroundColor =[UIColor whiteColor];
    
    [cell.contentView addSubview:view];
    
    
    UIImageView *photo =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    
    photo.image = [UIImage imageNamed:@"1.png"];
    
    
    [view addSubview:photo];
    
    
    
    UIImageView * photoBackground =[[UIImageView alloc]initWithFrame:CGRectMake(0, width-screenW*0.1, width,screenW*0.1)];
    photoBackground.image =[UIImage imageNamed:@"1.png"];
    [view addSubview:photoBackground];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(9, 2+width, screenW*0.3,screenW*0.04)];
    name.text =@"Baby";
    name.textColor =[UIColor redColor];
    name.font =[UIFont boldSystemFontOfSize:11.5];
    [view addSubview:name];
    
    UIImageView *sexImageView = [[UIImageView alloc]init];
    
    sexImageView.image = [UIImage imageNamed:@""];
    
    
    
    
    return cell;
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
