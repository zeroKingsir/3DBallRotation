//
//  ViewController.m
//  3DBallRotation
//
//  Created by G.Z on 16/5/23.
//  Copyright © 2016年 G.Z. All rights reserved.
//

#import "ViewController.h"
#import "DBSphereView.h"
#import "ComicReader-Prefix Header.h"
@interface ViewController ()<UISearchBarDelegate>


@property (nonatomic, strong) NSArray *searchNameArray;
@property (nonatomic, retain) DBSphereView *sphereView;

@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    
    
    [self gainData];
    [self addShowTagView];
    [self initSubViews];
    
}


#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    
    return  YES;
}

- (void)buttonPressed:(UIButton *)button
{
    [self touchActionJumpWithParams:button.titleLabel.text];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)initSubViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditSearchBar:)];
    [self.contentScrollView addGestureRecognizer:tap];
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back_day.png"]];
    self.view.backgroundColor = color;
    self.searchBar.delegate = self;
    
}

- (void)gainData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchNamePlist" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *string = dict[@"online_params"][@"KeyWord"];
    _searchNameArray = [string componentsSeparatedByString:@","];
}


- (void)addShowTagView
{
    CGFloat bounds_Width = MIN(kScreenWidth, (kScreenHeight - CGRectGetMaxY(_searchBar.frame ) - 49));
    _sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0, 30, bounds_Width, bounds_Width)];
    self.contentScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_sphereView.frame));
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger i = 0; i < 50; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:_searchNameArray[i * 4 + arc4random()% 4] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.];
        btn.frame = CGRectMake(0, 0, 80, 20);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        [_sphereView addSubview:btn];
    }
    [_sphereView setCloudTags:array];
    _sphereView.backgroundColor = [UIColor clearColor];
    [self.contentScrollView insertSubview:_sphereView atIndex:0];
}

- (void)endEditSearchBar:(UITapGestureRecognizer *)tap
{
    [self.searchBar resignFirstResponder];
}

- (UIColor *)randomColor
{
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - search delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self touchActionJumpWithParams:searchBar.text];
}

- (void)touchActionJumpWithParams:(NSString*)params
{
    
    NSLog(@"\n****************%@",params);
    
}
@end

