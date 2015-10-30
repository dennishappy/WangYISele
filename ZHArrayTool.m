//
//  ZHArrayTool.m
//  网易2
//
//  Created by dllo on 15/9/22.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import "ZHArrayTool.h"

@implementation ZHArrayTool


+(BOOL)JudgeNumberInArray:(NSMutableArray *)array andNumber:(NSNumber *)nub
{
    
    
    
    
    return nil;
}

+(BOOL)JudgeArraySort:(NSMutableArray *)array
{
  
    if (array.count <= 1) {
        return YES;
    }
    
    else
    {
        if (array[0] > array[1]) {
            for (int i = 1 ; i < array.count - 1 ;  i ++)
                
            {
                if (array[i] < array[i+1] ) {
                    
                    return  NO;
                    
                }
                
                
                
            }
            
            return YES;

           
        }
        
        
        
        
        else
        {
            
            for (int i = 1 ; i < array.count - 1 ;  i ++)
                
            {
                if (array[i] > array[i+1] ) {
                    
                    return  NO;
                    
                }
                
                
                
            }
            
            return YES;

            
            
        }
        
    }
    
    
    return nil;
    
    }

@end
