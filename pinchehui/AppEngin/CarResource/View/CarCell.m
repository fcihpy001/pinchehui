//
//  CarCell.m
//  车商官家
//
//  Created by Apple on 14-10-20.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubViews];
        
        
    }
    return self;
}



- (void)initSubViews{
    
    _infoname =  [[UILabel alloc]initWithFrame:CGRectZero];
    _infosubname =  [[UILabel alloc]initWithFrame:CGRectZero];
    _price =  [[UILabel alloc]initWithFrame:CGRectZero];
    _city =  [[UILabel alloc]initWithFrame:CGRectZero];
    _time =  [[UILabel alloc]initWithFrame:CGRectZero];
   
    
    _titileIcon =  [[UIImageView alloc]initWithFrame:CGRectZero];
    _infoIcon =  [[UIImageView alloc]initWithFrame:CGRectZero];
    _companyicon =  [[UIImageView alloc]initWithFrame:CGRectZero];
    _authicon =  [[UIImageView alloc]initWithFrame:CGRectZero];
    
    [self.contentView addSubview:_infoname];
    [self.contentView addSubview:_infosubname];
    [self.contentView addSubview:_price];
    [self.contentView addSubview:_city];
    [self.contentView addSubview:_time];
    [self.contentView addSubview:_titileIcon];
    [self.contentView addSubview:_companyicon];
    [self.contentView addSubview:_infoIcon];
    [self.contentView addSubview:_authicon];
    [self.contentView addSubview:_time];
    
    
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
   
    _infoname.frame = CGRectMake(65, 0, 152, 21);
    _titileIcon.frame = CGRectMake(0, 0, 52, 21);
    _infoIcon.frame = CGRectMake(3, 3, 60, 60);
    
    _infosubname.frame = CGRectMake(65, 22, 152, 15);
    _infosubname.font = [UIFont systemFontOfSize:12];
    
    _price.frame = CGRectMake(65, 40, 40, 30);
    _price.font = [UIFont systemFontOfSize:12];
    
    _city.frame = CGRectMake(260, 22, 60, 30);
    _city.font = [UIFont systemFontOfSize:12];
    
    _companyicon.frame = CGRectMake(97, 7, 152, 18);
    _authicon.frame = CGRectMake(97, 7, 152, 21);
    
    _time.frame = CGRectMake(260, 40, 100, 30);
    _time.font = [UIFont systemFontOfSize:12];
    
    _infoname.text = _carResourceModel.name;
    
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
