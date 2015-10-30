//
//  ZHNewsViewController.h
//  网易2
//
//Created by LZS on 14/9/21.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHNewsViewController : UIViewController

@property (nonatomic,retain)  UIScrollView *TitleScrolView;
@property (nonatomic,retain)  UIView *lineView;
@property (nonatomic,retain)  UIScrollView *contentScrolView;

@property (nonatomic,retain)  NSMutableArray *contentTempArray;
@property (nonatomic,retain)  NSMutableArray *titleArray;
@property (nonatomic,retain)  NSMutableArray *contentArray;


@end
