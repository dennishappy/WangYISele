//
//  ExchageItemViewController.h
//  sort
//
//  Created by liuzhishan on 15/10/11.
//  Copyright (c) 2015年 shanshan. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol  reloadMyData <NSObject>

-(void)setData:(NSMutableArray *)array;

@end

@interface ExchageItemViewController : UIViewController

@property (nonatomic,retain)  NSMutableArray *titleArray;
@property (nonatomic,assign) id<reloadMyData> dele;

@end
