//
//  CarDetailInfoController.m
//  车商官家
//
//  Created by Apple on 14-10-20.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "CarDetailInfoController.h"

@interface CarDetailInfoController ()

@end

@implementation CarDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    // Do any additional setup after loading the view.
    //添加scollview
    [self addScrollview];
    
    
    
}


#pragma mark addscrollview
-(void)addScrollview{
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 64, self.view.frame.size.width, 150);
    scrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrollView];
    
    //addimgview
   
    
    
        
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
