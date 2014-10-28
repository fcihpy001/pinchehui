//
//  HomeViewController.h
//  车商官家
//
//  Created by Apple on 14-10-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIScrollViewAccessibilityDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

@property (strong, nonatomic) UIButton * setNewCarButton;   //发车
@property (strong, nonatomic) UIButton * getCarButton;      //收车
@property (strong, nonatomic) UIButton * specialCarButton;  //特卖车
@property (strong, nonatomic) UIButton * messageButton;     //消息
@property (strong, nonatomic) UIButton * loanButton;        //贷款

@end
