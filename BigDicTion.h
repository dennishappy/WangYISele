//
//  BigDicTion.h
//  ShanProject
//
//  Created by dllo on 15/9/30.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigDicTion : NSObject

+(instancetype)shareBigDic;

@property (nonatomic,retain) NSMutableDictionary *dic;
@property (nonatomic,retain) NSMutableArray *titleArray;

@end
