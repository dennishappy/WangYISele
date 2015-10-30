//
//  ExchageItemViewController.m
//  sort
//
//  Created by liuzhishan on 15/10/11.
//  Copyright (c) 2015年 shanshan. All rights reserved.
//

#import "ExchageItemViewController.h"
#import "BigDicTion.h"
#define rowCount   4
#define  biLi      0.75

@interface ExchageItemViewController ()

@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) NSMutableArray *chaArray;
@property (nonatomic,assign) CGPoint point;
@property (nonatomic,assign) CGRect myRect;
@property (nonatomic,assign) BOOL isJump;
@property (nonatomic,retain) UIView *UpView;
@property (nonatomic,retain) UIView *DownView;
@property (nonatomic,retain) CAKeyframeAnimation *keyFA;





@end

@implementation ExchageItemViewController


-(void)clickAction2
{
    
    [self.dele setData:self.array];
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.array = self.titleArray;
    
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    for (NSString *str in [BigDicTion shareBigDic].titleArray) {
        
        if (![self.array containsObject:str]) {
            
            [array1 addObject:str];
            
        }
        
    }

    self.chaArray = array1;
    
    
    
    
    
    self.UpView = [[UIScrollView alloc]init];
    float height = [self getViewHeight:self.array];
    [self.UpView setMyFramewithX:0 andY:100 andWidth:375 andHeight:height + 50];

    [self.view addSubview:self.UpView];
    [_UpView release];
    
    UILabel *lable1 = [[UILabel alloc]init];
    [lable1 setMyFramewithX:0 andY:0 andWidth:100 andHeight:50];
    lable1.text = @"已有标题";
    lable1.font = [UIFont systemFontOfSize:12];
    lable1.textColor = [UIColor grayColor];
    [self.UpView addSubview:lable1];
    
    UILabel *lableb = [[UILabel alloc]init];
    [lableb setMyFramewithX:300 andY:0 andWidth:60 andHeight:50];
    lableb.textAlignment = NSTextAlignmentRight;
    lableb.text = @"长按编辑";
    lableb.font = [UIFont systemFontOfSize:12];
    lableb.textColor = [UIColor grayColor];
    [self.UpView addSubview:lableb];
    

    [self addScrollView:self.UpView andArray:self.array];

    
    self.DownView = [[UIScrollView alloc]init];
     float height1 = [self getViewHeight:self.chaArray];
    [self.DownView setMyFramewithX:0 andY:100 + height + 50  andWidth:375 andHeight:height1 + 50];
    [self.view addSubview:self.DownView];
    [_DownView release];
    
    UILabel *lable2 = [[UILabel alloc]init];
    [lable2 setMyFramewithX:0 andY:0 andWidth:375 andHeight:50];
    lable2.text = @"添加标题";
    
    lable2.font = [UIFont systemFontOfSize:12];
    lable2.textColor = [UIColor grayColor];
    
    
    [self.DownView addSubview:lable2];

    
   [self addScrollView:self.DownView andArray:self.chaArray];
    
    
    [self.view bringSubviewToFront:self.UpView];

    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setMyFramewithX:275 andY:45 andWidth:60 andHeight:35];
    btn1.backgroundColor = [UIColor colorWithRed:0.823 green:0.801 blue:0.805 alpha:1.000];
    [btn1 setTitleColor:[UIColor colorWithRed:1.000 green:0.163 blue:0.814 alpha:1.000] forState:(UIControlStateNormal)];
    
    [btn1 setTitle:@"完成" forState:UIControlStateNormal];
    
    [btn1 addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setMyFramewithX:20 andY:45 andWidth:60 andHeight:35];
    btn2.backgroundColor = [UIColor colorWithRed:0.823 green:0.806 blue:0.791 alpha:1.000];
    
    [btn2 setTitle:@"返回" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:1.000 green:0.163 blue:0.814 alpha:1.000] forState:(UIControlStateNormal)];
    
    [btn2 addTarget:self action:@selector(clickAction2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];

    
    
    
}

-(CGFloat)getViewHeight:(NSMutableArray*)array
{

    float height = 30;
    
    float rapHeight = 30;
    
    NSInteger row =  array.count / rowCount;
    
    

    
    float f = (height + rapHeight)*(row + 1) + 50;
    
    
    return  f;
    
    
    

    
    
}

-(void)addScrollView:(UIView *)View andArray:(NSMutableArray *)array
{
    float width =  80*WIDPro;
    float height = 30*HEIPro;
    
    
    
    float rapWidth = (self.view.width - rowCount * width)  /(rowCount +1);
    float rapHeight = 30*HEIPro;
    
    
    
    for (int i = 0 ;  i < array.count; i++) {
        
        
        int line = i % rowCount;
        int row =  i / rowCount;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        btn.backgroundColor = [UIColor colorWithRed:0.946 green:0.974 blue:1.000 alpha:1.000];
        [btn setTitleColor:[UIColor colorWithRed:1.000 green:0.118 blue:0.395 alpha:1.000] forState:(UIControlStateNormal)];
        
        btn.frame = CGRectMake(rapWidth + (rapWidth + width)*line, (50 * HEIPro)+(rapHeight + height) * row, width, height);
        
        [View addSubview:btn];
        
        
        if (array == self.array) {
            
            btn.tag = i + 1000;
            
            UILongPressGestureRecognizer *lon = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongAction:)];
            
            [btn addGestureRecognizer:lon];
            
            
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            //轻拍次数
            tap.numberOfTapsRequired = 2;
            //设置轻拍手指个数
            tap.numberOfTouchesRequired = 1;
            
            [btn addGestureRecognizer:tap];
            
        }
        
        else
        {
            
            btn.tag = i + 1000;
            [btn addTarget: self action:@selector(addMyItemBtn1:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    
        

}



-(void)addDownBtn:(UIButton *)bt
{
    
    float width =  80*WIDPro;
    float height = 30*HEIPro;
    
    float initY =  50*HEIPro;
    
    float rapWidth = (self.view.width - rowCount * width)  /(rowCount +1);
    float rapHeight = 30*HEIPro;
    
    
    
    [self.chaArray addObject:bt.titleLabel.text];
    
    
    int i = (int)self.chaArray.count - 1;
    
    
    int line = i % rowCount;
    int row =  i / rowCount;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    [btn setTitle:self.chaArray[i] forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor colorWithRed:0.946 green:0.974 blue:1.000 alpha:1.000];
    [btn setTitleColor:[UIColor colorWithRed:1.000 green:0.118 blue:0.395 alpha:1.000] forState:(UIControlStateNormal)];

    btn.frame = CGRectMake(rapWidth + (rapWidth + width)*line, initY + (rapHeight + height) * row, width, height);
    
    [self.DownView addSubview:btn];
    
    
    btn.tag = i + 1000;
    
    
    [btn addTarget: self action:@selector(addMyItemBtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}



-(void)tapAction:(UITapGestureRecognizer *)tap
{
    
    if (!self.isJump ) {
        
        
        return;
    }
    UIButton *btn = (UIButton *)tap.view;
    NSInteger myTag = btn.tag - 1000;
    
    if (self.array.count == 1) {
        
        return;
    }
    
    
    [self addDownBtn:btn];


    
    
    [UIView animateWithDuration:0.5 animations:^{
        for (NSInteger i = self.array.count - 1; i > myTag; i --) {
            
            [self.UpView viewWithTag:(i + 1000)].frame =   [self.UpView viewWithTag:(i + 1000 -1 )].frame;
        }
        
        [self.array removeObjectAtIndex:(btn.tag - 1000)];
        
    }completion:^(BOOL finished) {
        
        [UIView  animateWithDuration:0.5 animations:^{
            
            
            if (self.array.count % rowCount == 0) {
                
                self.UpView.height -= (60*HEIPro);
                
                self.DownView.y -= (60 *HEIPro);
                self.DownView.height += (60*HEIPro);
                
            
                
            }

            
        }];
        
        
        
        
    }];
    
    
    
    for (UIButton *v1  in self.UpView.subviews) {
        
        if (v1.tag >=1000) {
            
            int flag1 = 0;
            
            for (int l = 0;  l < self.array.count; l++) {
                
                if ([v1.titleLabel.text isEqualToString:self.array[l]]) {
                    
                    v1.tag = l + 1000;
                    
                    flag1 = 1;
                    
                }
                
            }
            
            if (flag1 == 0) {
                
                [v1 removeFromSuperview];
            }
            
            
        }
        
        
        
    }

    
}


-(void)addMyItemBtn1:(UIButton *)bt
{
    
    
    
    
    float width =  80*WIDPro;
    float height = 30*HEIPro;
    
    float initY = 50 *HEIPro;
    
    float rapWidth = (self.view.width - rowCount * width)  /(rowCount +1);
    float rapHeight = 30*HEIPro;
    
    
    
    [self.array addObject:bt.titleLabel.text];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        
        
        if (self.array.count % rowCount == 1) {
            
            self.UpView.height += (60*HEIPro);
            
            self.DownView.y += (60 *HEIPro);
            self.DownView.height -= (60*HEIPro);
            
            
            
        }

        
        
    }];
    

    
    
    int i = (int)self.array.count - 1;
    
    
    int line = i % rowCount;
    int row =  i / rowCount;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    [btn setTitle:self.array[i] forState:UIControlStateNormal];
    
    btn.backgroundColor =[UIColor colorWithRed:0.946 green:0.974 blue:1.000 alpha:1.000];
    [btn setTitleColor:[UIColor colorWithRed:1.000 green:0.118 blue:0.395 alpha:1.000] forState:(UIControlStateNormal)];
    
    btn.frame = CGRectMake(rapWidth + (rapWidth + width)*line, initY + (rapHeight + height) * row, width, height);
    [self.UpView addSubview:btn];
    
    if (self.keyFA != nil) {

            [btn.layer addAnimation:self.keyFA forKey:@"key"];
        
        
    }

    
    btn.tag = i + 1000;
    
    UILongPressGestureRecognizer *lon = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongAction:)];
    
    [btn addGestureRecognizer:lon];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //轻拍次数
    tap.numberOfTapsRequired = 2;
    //设置轻拍手指个数
    tap.numberOfTouchesRequired = 1;
    
    [btn addGestureRecognizer:tap];
    
    
    [self removeMyBtn:bt];
    
    
}

-(void)removeMyBtn:(UIButton*)btn
{
    
    NSInteger myTag = btn.tag - 1000;
    // CGRect    rect = btn.frame;
    
   
    
    
    [UIView animateWithDuration:0.5 animations:^{
        for (NSInteger i = self.chaArray.count - 1; i > myTag; i --) {
            
            [self.DownView viewWithTag:(i + 1000)].frame =   [self.DownView viewWithTag:(i + 1000 -1 )].frame;
        }
        
        [self.chaArray removeObjectAtIndex:(btn.tag - 1000)];
        
    }];
    
    
    
    for (UIButton *v1  in self.DownView.subviews) {
        
        if (v1.tag >=1000  ) {
            
            int flag1 = 0;
            
            for (int l = 0;  l < self.chaArray.count; l++) {
                
                if ([v1.titleLabel.text isEqualToString:self.chaArray[l]]) {
                    
                    v1.tag = l + 1000;
                    
                    flag1 = 1;
                    
                }
                
            }
            
            if (flag1 == 0) {
                
                [v1 removeFromSuperview];
            }
            
            
        }
        
        
        
    }
    
    
    
}




-(void)LongAction:(UILongPressGestureRecognizer*)lon
{
    
    if (lon.state == UIGestureRecognizerStateBegan)
    {
        
        self.isJump = YES;
        
        CAKeyframeAnimation *keyFA = [CAKeyframeAnimation animation];
        
        //动画播放一次的时长
        keyFA.duration = 0.1;
        
        //设置关键帧类型,是按照什么属性进行动画播放
        
        keyFA.keyPath = @"transform.rotation";
        
        
        //设置抖动范围
        CGFloat top = -M_PI/64;
        CGFloat bom = M_PI/64;
        
        
        
        keyFA.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:top],[NSNumber numberWithFloat:bom], nil];
        
        
        //播放次数
        [keyFA setRepeatCount:NSIntegerMax];
        
        for (int i = 0; i < self.array.count; i++) {
            
            [ [self.UpView viewWithTag:(i+1000)].layer addAnimation:keyFA forKey:@"key"];
            
            
        }
        
        self.keyFA = keyFA;
        
        

        
        [self.UpView bringSubviewToFront:lon.view];
        
        self.point  = [lon locationInView:lon.view];
        self.myRect = lon.view.frame;
        
        
        
    }
    
    else if (lon.state == UIGestureRecognizerStateChanged)
    {
        
        lon.view.x += [lon locationInView:lon.view].x - self.point.x;
        lon.view.y += [lon locationInView:lon.view].y - self.point.y;
        
        if (lon.view.y < 0 ) {
            
            lon.view.y = 0;
        }
        if (lon.view.y > (self.UpView.height - lon.view.height )) {
            
            lon.view.y = self.UpView.height - lon.view.height;
        }
        
        
        NSInteger myTag = lon.view.tag  -  1000;
        UIView *currenView  = [self.UpView viewWithTag:lon.view.tag];
        
        
        
        for (int i = 0 ;i < self.array.count ; i++ ) {
            
            
            if (i != myTag) {
                
                
                
                
                UIView *tempView = [self.UpView viewWithTag:(i + 1000)];
                
                CGRect rect = CGRectIntersection(tempView.frame,currenView.frame);
                float tempBi  =  rect.size.width * rect.size.height / (2400.0*WIDPro * HEIPro);
                
                if (tempBi > biLi ) {
                    
                    
                    if (myTag > i) {
                        
                        
                        
                        NSString *str = self.array[myTag];
                        
                        for (NSInteger kw = myTag ; kw >i; kw--) {
                            
                            self.array[kw] = self.array[kw - 1];
                            
                        }
                        
                        self.array[i] = str;
                        
                        
                        [UIView animateWithDuration:1 animations:^{
                            
                        
                            
                            currenView.frame = tempView.frame;
                            
                            
                            for (int k = i ; k < myTag -1 ; k++) {
                                
                                [self.UpView viewWithTag:(1000+k)].frame =  [self.UpView viewWithTag:(1000+k+1)].frame;
                                
                            }
                            
                            
                            [self.UpView viewWithTag:(1000+myTag -1 )].frame = self.myRect;
                            
                            

                            
                            
                            
                        }];
                        
                        self.myRect = currenView.frame;
                        
                        
                        for (UIButton *v1  in self.UpView.subviews) {
                            
                            if (v1.tag >=1000) {
                                
                                for (int l = 0;  l < self.array.count; l++) {
                                    
                                    if ([v1.titleLabel.text isEqualToString:self.array[l]]) {
                                        
                                        v1.tag = l + 1000;
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        i = 10000;
                        
                    }
                    
                    
                    
                    else if (myTag < i) {
                        
                        NSString *str = self.array[myTag];
                        
                        for (NSInteger kw = myTag  ; kw < i  ; kw ++ ) {
                            
                            self.array[kw] = self.array[kw + 1];
                            
                            
                        }
                        
                        self.array[i] = str;
                        
                        
                     
                        
                        
                        [UIView animateWithDuration:1 animations:^{
                            
                            currenView.frame = tempView.frame;
                            
                            
                            
                            for (int k = i;  k >=myTag + 2 ; k--) {
                                
                                [self.UpView viewWithTag:(1000 + k)].frame =  [self.UpView viewWithTag:(1000 + k - 1)].frame;
                            }
                            
                            [self.UpView viewWithTag:(1000+myTag + 1)].frame = self.myRect;
                            
                            
                        }];
                        
                        self.myRect = currenView.frame;
                        
                        
                        for (UIButton *v1  in self.UpView.subviews) {
                            
                            if (v1.tag >=1000) {
                                
                                for (int l = 0;  l < self.array.count; l++) {
                                    
                                    if ([v1.titleLabel.text isEqualToString:self.array[l]]) {
                                        
                                        v1.tag = l + 1000;
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        i = 10000;
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        

        
        
       
    }
    
    
    else if(lon.state == UIGestureRecognizerStateEnded)
    {

        
        [UIView animateWithDuration:0.5 animations:^{
            
            lon.view.frame = self.myRect;
        }];
        
        
        
    }
    
    
    

}


-(void)clickAction
{
    
    for (int i = 0; i < self.array.count; i++) {
        
        [ [self.UpView viewWithTag:(i+1000)].layer removeAnimationForKey:@"key"];
        
        
    }
    
    self.isJump = NO;
    self.keyFA = nil;
    
    
    
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
