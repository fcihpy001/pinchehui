//
//  HomeViewController.m
//  车商官家
//
//  Created by Apple on 14-10-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#define kScrollImgCount 4
#define kTabrViewH 60
#define kScreenSizeW 320
#define kScreenSizeH 568

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR(241, 241, 241, 241);
    //添加scrollView
    [self addScrollview];
    
    //添加scrollImg
    [self addScrollImg];
    
    //添加pageControll
    [self addPageControl];
    
    //添加收、发车button
    [self addButton];
}



#pragma mark -addSrollView
-(void)addScrollview{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, kScreenSizeW, 170);
    scrollView.showsHorizontalScrollIndicator = NO; // 隐藏水平滚动条
    
    CGSize size = scrollView.frame.size;
    scrollView.contentSize = CGSizeMake(size.width * kScrollImgCount, 0); // 内容尺寸
    scrollView.pagingEnabled = YES;   //是否分页
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    _scrollView = scrollView;
    
}

#pragma mark -添加scrollview图片
- (void)addScrollImg{
    CGSize size = _scrollView.frame.size;
    
    NSArray *imagArry = @[@"banner1",@"banner2",@"banner3",@"banner4"];
    
    for (int i = 0; i<kScrollImgCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        // 1.显示图片
      
        NSString *name = [NSString stringWithFormat:@"%@",imagArry[i]];
        imageView.image = [UIImage imageNamed:name];
        // 2.设置frame
        imageView.frame = CGRectMake(i * size.width, 0, size.width, size.height);
        [_scrollView addSubview:imageView];
        
        }
}

#pragma mark -addpageControl
- (void)addPageControl{
    
    CGSize size = self.view.frame.size;
    UIPageControl *pagecontrol = [[UIPageControl alloc]init];
    pagecontrol.frame = CGRectMake(size.width - 100,120 , 100, 30);
    pagecontrol.numberOfPages = kScrollImgCount;
    pagecontrol.currentPage = 0;
    pagecontrol.currentPageIndicatorTintColor = [UIColor greenColor];
    pagecontrol.pageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:pagecontrol];
    
    _pageControl = pagecontrol;
    
}


#pragma mark -scrollview 滚动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _pageControl.currentPage = scrollView.contentOffset.x /scrollView.frame.size.width;
    
}


#pragma mark -addButtonImg
- (void)addButton{
    

    
    self.specialCarButton = [self makeButtonWithFrame:CGRectMake(0, 240-64, 160, 180) AndTitle:@"" AndTag:1 setbackimg:@"homebtn_temai.png"];
    [self.view addSubview:self.specialCarButton];
    

    self.messageButton = [self makeButtonWithFrame:CGRectMake(161, 240-64, 159, 90) AndTitle:nil AndTag:2 setbackimg:@"homebtn_message"];
    [self.view addSubview:self.messageButton];
    
    
    self.loanButton = [self makeButtonWithFrame:CGRectMake(161, 331-64, 159, 89) AndTitle:nil AndTag:3 setbackimg:@"homebtn_rongzi"];
    [self.view addSubview:self.loanButton];
    
    
    self.setNewCarButton = [self makeButtonWithFrame:CGRectMake(0, 421-64+5, 160, 89) AndTitle:nil AndTag:4 setbackimg:@"homebtn_fache"];
    [self.view addSubview:self.setNewCarButton];
    
    self.getCarButton = [self makeButtonWithFrame:CGRectMake(161, 421-64+5, 159, 90) AndTitle:nil AndTag:5 setbackimg:@"homebtn_souche"];

    [self.view addSubview:self.getCarButton];

    
}


- (void)clickButton:(UIButton *)sender
{
    NSLog(@"clickButton,tag=%d",sender.tag);
    switch (sender.tag) {
        case 1:
        {
            //特卖车
            
        }
            break;
        case 2:
        {
            //消息
            
        }
            break;
        case 3:
        {
            //融资
            
        }
            break;
        case 4:
        {
            //发车
            
        }
            break;
        case 5:
        {
            //搜车
            
        }
            break;
            
    }
    
}


- (UIButton *)makeButtonWithFrame:(CGRect)frame AndTitle:(NSString *)title AndTag:(int)tagNumber setbackimg:(NSString *)backImg;
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.tag = tagNumber;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setBackgroundImage:[UIImage imageNamed:backImg] forState:UIControlStateNormal];
    
    
    return btn;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
