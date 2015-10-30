//
//  DicTionTool.m
//  ShanProject
//
//  Created by dllo on 15/9/30.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import "DicTionTool.h"
#import "BigDicTion.h"
#import "URLandController.h"
@implementation DicTionTool

+(NSString *)GetUrlWithDic:(NSString *)str
{


    URLandController *m = [[BigDicTion shareBigDic].dic  objectForKey:str];
    
    return m.urlStr;

}

+(NSString *)GetControllerWithDic:(NSString *)str
{
    NSLog(@"%@",str);
    URLandController *m = [[BigDicTion shareBigDic].dic objectForKey:str];
    
    return m.conName;
    
}
@end
