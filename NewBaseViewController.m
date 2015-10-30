//
//  NewBaseViewController.m
//  ShanProject
//
//  Created by dllo on 15/9/29.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import "NewBaseViewController.h"

@interface NewBaseViewController ()

@end

@implementation NewBaseViewController

-(void)dealloc
{
    [_strID release];
    [_strUrl release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
