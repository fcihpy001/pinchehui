//
//  CarCell.h
//  车商官家
//
//  Created by Apple on 14-10-20.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarResourceModel.h"

@interface CarCell : UITableViewCell

@property(nonatomic,strong) UIImageView *titileIcon;  //特卖、真实、商家等标签
@property(nonatomic,strong) UILabel *infoname;        //信息名称
@property(nonatomic,strong) UIImageView *infoIcon;   //汽车图片
@property(nonatomic,strong) UILabel *infosubname;      //信息子名称
@property(nonatomic,strong) UILabel *price;        //汽车价格
@property(nonatomic,strong) UIImageView *companyicon;  //商家围标
@property(nonatomic,strong) UIImageView *authicon;     //认证图标
@property(nonatomic,strong) UILabel *city;   //地区
@property(nonatomic,strong) UILabel *time;  //时间

@property(nonatomic,strong) CarResourceModel *carResourceModel;


@end
