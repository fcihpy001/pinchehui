////
////  MetaDataTool.m
////  车商官家
////
////  Created by Apple on 14-10-21.
////  Copyright (c) 2014年 Apple. All rights reserved.
////
//
//
//
//
//@implementation MetaDataTool
//singleton_implementation(MetaDataTool)
//
////获取用户id
///*
//- (void)setUid:(NSString *)uid{
//    
//    [HttpTool posWithPath:@"/api/regsiter" params:
//     @{
//       @"username":@"aaa"
//       }
//    success:^(id JSON) {
//        Account *account = [[Account alloc]init];
//        account.uid = JSON[@"uid"];
//        [[AccountTools sharedAccountTools] saveAccount:account];
//    } failure:^(NSError *error) {
//        NSLog(@"get uid error is%@",error.description);
//    }];
//    
//    _uid = uid;
//}
//
//*/
//
////获取carinfocell数据
//- (void)carInfoModelData{
//    
//    /*
//    //获取资源文件
//    NSArray *resourceArry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"carinfo" ofType:@"plist"]];
//                             
//    
//    //初始化
//    _tempCarInfoArry = [NSMutableArray array];
//    
//    //遍历数据组,将字典转换为模型
//    for (NSDictionary *dict in resourceArry) {
//        CarInfoCellModel *carmodel = [[CarInfoCellModel alloc]init];
//        [carmodel setValuesForKeysWithDictionary:dict];
//        [_tempCarInfoArry addObject:carmodel];
//    }
//    */
//  
//    
//    
//}
//
//- (void)CarResourceData{
//    
//    CarResourceModel *model1 = [[CarResourceModel alloc]init];
//    model1.name  = @"aaa";
//    
//    CarResourceModel *model2 = [[CarResourceModel alloc]init];
//    model2.name  = @"bbbb";
//    
//    CarResourceModel *model3 = [[CarResourceModel alloc]init];
//    model3.name  = @"accc";
//    
//    _tempCarInfoArry = [NSMutableArray array];
//    [_tempCarInfoArry addObject:model1];
//    [_tempCarInfoArry addObject:model2];
//    [_tempCarInfoArry addObject:model3];
//    
//    
//    _carResourceModelArry = _tempCarInfoArry;
//}
//
//
//@end
