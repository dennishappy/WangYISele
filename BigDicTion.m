//
//  BigDicTion.m
//  ShanProject
//
//  Created by dllo on 15/9/30.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import "BigDicTion.h"
#import "URLandController.h"
@implementation BigDicTion

-(NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        
         NSArray *array = @[@"头条",@"移动",@"暴力",@"馒头",@"大蛋",@"蛋蛋",@"杉杉",@"啊啊",@"飒飒",@"东东",@"天天",@"音乐",@"额外",@"语言"];
        
        _titleArray = [[NSMutableArray arrayWithArray:array] retain];
    }
    
    return _titleArray;
    
}

-(NSMutableDictionary *)dic
{
    if (_dic ==nil) {
        
        
         NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        
        NSArray *array = @[@"头条",@"移动",@"暴力",@"馒头",@"大蛋",@"蛋蛋",@"杉杉",@"啊啊",@"飒飒",@"东东",@"天天",@"音乐",@"额外",@"语言"];
        
        
        NSArray *arrayUrl = @[@"http://c.m.163.com/nc/article/headline/T1348647853363",
                              @"http://c.3g.163.com/nc/article/list/T1429173683626",
                              @"http://c.3g.163.com/nc/article/list/T1348648517839",
                              @"http://c.3g.163.com/nc/article/list/T1348649079062",
                              @"http://c.3g.163.com/nc/article/list/T1414389941036",
                              @"http://c.3g.163.com/nc/article/list/T1348648756099",
                              @"http://c.3g.163.com/nc/article/list/T1348649580692",
                              @"http://c.3g.163.com/nc/article/list/T1348650593803",
                              @"http://c.3g.163.com/nc/article/list/T1350383429665",
                              @"http://c.3g.163.com/nc/article/list/T1348649145984",
                              @"http://c.m.163.com/nc/article/headline/T1348647853363",
                              @"http://c.3g.163.com/nc/article/list/T1429173683626",
                              @"http://c.3g.163.com/nc/article/list/T1348648517839",
                              @"http://c.3g.163.com/nc/article/list/T1348649079062"
                              
                              ];
        
        
        NSArray *arr1 = @[@"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController",
                          @"NewsItemViewController"
                          ];
        
        
        
          NSLog(@"aaa%ld",array.count);
          NSLog(@"aaa%ld",arrayUrl.count);
          NSLog(@"aaa%ld",arr1.count);
       
        for (int i = 0 ; i < arrayUrl.count ; i ++ ) {
            
            URLandController *model = [[URLandController alloc]init];
            model.urlStr = arrayUrl[i];
            NSLog(@"%@",arr1[i]);
            model.conName = arr1[i];
            
            [dic setObject:model forKey:array[i]];
            
            [model release];
            
        }
        
        _dic = [dic retain];

        
    }
    
    
    return  _dic;
    
}

+(instancetype)shareBigDic
{
    static BigDicTion *handle = nil;
    
    
    
    if (handle == nil) {
     
        
        
        handle = [[BigDicTion alloc]init];
        
        
    }
    
    
    return handle;
    
    
}
@end
