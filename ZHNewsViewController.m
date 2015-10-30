//
//  ZHNewsViewController.m
//  网易2
//
//Created by LZS on 14/9/21.
//  Copyright (c) 2014年 LiuZhishan. All rights reserved.
//

#import "ZHNewsViewController.h"
#import "UIView+Frame.h"
#import "ZHArrayTool.h"
#import "NewsItemViewController.h"
#import "DicTionTool.h"
#import "ExchageItemViewController.h"
#import "NewBaseViewController.h"

 

@interface ZHNewsViewController ()<UIScrollViewDelegate,reloadMyData>
{
    float titleLength;
    int  currentPage;
    float offsetX;
    float gunX; //记录上边滚之前的坐标
}

@property (nonatomic,assign) BOOL isRight;
@property (nonatomic,assign) BOOL isRightFirst;
@property (nonatomic,assign) BOOL isLeftFirst;
@property (nonatomic,assign) BOOL isClicking;
@property (nonatomic,assign) BOOL isFirstGun;

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,retain) NSMutableArray *storyArray;
@property (nonatomic,retain) NSMutableArray *lableArray;
@property (nonatomic,retain) NSMutableArray *stroyID;



@end

@implementation ZHNewsViewController

-(void)setData:(NSMutableArray *)array
{
    

    
    [self.TitleScrolView removeFromSuperview];
    [self.lineView removeFromSuperview];
    [self.contentScrolView removeFromSuperview];
    
    currentPage = 0;
    self.titleArray = array;
    [self reLineData];
}

-(void)dealloc
{
    
    [_storyArray release];
    [_lableArray release];
    [_TitleScrolView release];
    [_lineView release];
    [_contentScrolView release];
    [_contentTempArray release];
    [_titleArray release];
    [_contentArray release];
    
    [super dealloc];

}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    currentPage = 0;
    self.isRight = NO;
    self.isRightFirst =  YES;
    self.isLeftFirst  =  YES;
    self.isClicking   =  NO;
    self.isFirstGun = YES;
    
    offsetX = 0;
    
    
    self.storyArray = [NSMutableArray array];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
     self.navigationItem.title = @"网易";
    
    NSArray *array = @[@"头条",@"移动",@"暴力",@"馒头",@"大蛋",@"蛋蛋",@"杉杉"];
    
    self.titleArray = [NSMutableArray arrayWithArray:array];
   
 
    [self reLineData];

}


-(void)reLineData
{
    
    self.count = 5;
    
    if (self.count > self.titleArray.count) {
        
        self.count = self.titleArray.count;
    }
    
    self.TitleScrolView = [[UIScrollView  alloc]initWithFrame:CGRectMake(0, 0,self.view.width * 0.92, 30)];// 58 * 6
    
    [self.view addSubview:self.TitleScrolView];
    self.TitleScrolView.delegate = self;
    self.TitleScrolView.showsHorizontalScrollIndicator = NO;
    self.TitleScrolView.showsVerticalScrollIndicator = NO;
    [_TitleScrolView release];
    
    
    
    self.lableArray = [NSMutableArray array];
    titleLength = 0;
    for (int i = 0;  i < self.titleArray.count; i++) {
        
        UILabel *lable = [[UILabel alloc]init];
        lable.tag = 1000 + i;
        lable.userInteractionEnabled = YES;
        NSString *str = self.titleArray[i];
        lable.text =  str;
        lable.font = [UIFont systemFontOfSize:16];
        
        
        
        lable.width =  self.TitleScrolView.width / self.count;
        
        lable.textAlignment = NSTextAlignmentCenter;
        lable.frame = CGRectMake(titleLength ,0 , lable.width, 25);
        titleLength = lable.x + lable.width;
        
        if (i == 0) {
            
            lable.textColor = [UIColor redColor];
            lable.font = [UIFont systemFontOfSize:17];
        }
        
        
        [self.TitleScrolView addSubview:lable];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [lable addGestureRecognizer:tap];
        [tap release];
        
        [self.lableArray addObject:lable];
        
        [lable release];
        
        
    }
    
    self.TitleScrolView.contentSize = CGSizeMake(titleLength, 0);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(self.TitleScrolView.x + self.TitleScrolView.width, self.TitleScrolView.y, self.view.width - self.TitleScrolView.x - self.TitleScrolView.width, self.TitleScrolView.height);
    btn.backgroundColor = [UIColor colorWithRed:0.971 green:1.000 blue:0.319 alpha:1.000];
    
    [btn addTarget:self action:@selector(showAllItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
    
    self.lineView = [[UIView alloc]init];
    
    UILabel *lable = (UILabel*)self.lableArray[0];
    
    self.lineView.frame = CGRectMake(lable.x + 10, 25,lable.width - 20, 2);
    self.lineView.centerX = lable.centerX;
    
    NSLog(@"%f",self.lineView.x);
    
    
    self.lineView.backgroundColor = [UIColor redColor];
    [self.TitleScrolView addSubview:self.lineView];
    [_lineView release];
    
    
    self.contentScrolView = [[ UIScrollView alloc]initWithFrame:CGRectMake(0, self.lineView.y + self.lineView.height + 1, self.view.width, self.view.height - self.lineView.y -  self.lineView.height)];
    [self.view addSubview:self.contentScrolView];
    [_contentScrolView release];
    self.contentScrolView.pagingEnabled = YES;
    
    self.contentScrolView.delegate = self;
    self.contentScrolView.showsVerticalScrollIndicator = NO;
    self.contentScrolView.showsHorizontalScrollIndicator = NO;
    
    
    self.contentScrolView.pagingEnabled = YES;
    
    self.contentScrolView.contentSize = CGSizeMake(self.view.width * self.titleArray.count, 0);
    
    self.contentArray = [NSMutableArray array];
    
    for (int i = 0;  i < self.titleArray.count; i++) {
        
        NSString *className =  [DicTionTool GetControllerWithDic:self.titleArray[i]];
        
        NewBaseViewController  *con = [[NSClassFromString(className) alloc]init];
        con.strUrl =  [DicTionTool GetUrlWithDic:self.titleArray[i]];
        
        [self.contentArray addObject:con];
        
        [con release];
        
        if ( i== 0) {
            
            [self addChildViewController:con];
            [self.contentScrolView addSubview:con.view];
            [self.storyArray addObject:[NSNumber numberWithInt:0]];
            
        }
        
        
    }
    

}


-(void)showAllItemAction
{
    ExchageItemViewController * ex = [[ExchageItemViewController alloc]init];
    ex.titleArray = self.titleArray;
    ex.dele = self;
    
    [self presentViewController:ex  animated:YES completion:^{
        
    }];
    
    [ex release];
    
    [self clearAllViews];
}


-(void)clearWithView:(UIViewController*)con
{
     [con.view removeFromSuperview];

     [con removeFromParentViewController];
    
    [self.contentArray  removeObject:con];
    
     con = nil;

 
}

-(void)titleClick:(UITapGestureRecognizer*)tap
{
    NSInteger tag1 = tap.view.tag - 1000;
   
    if ( tag1 != currentPage) {
        
        
        self.isClicking = YES;
        
        UILabel * lable = self.lableArray [tag1];
        lable.textColor = [UIColor redColor];
        lable.font = [UIFont systemFontOfSize:17];
        
        UILabel * lable1 = self.lableArray [currentPage];
        lable1.textColor = [UIColor blackColor];
        lable1.font = [UIFont systemFontOfSize:16];
        
        
        BOOL shan =     [self.storyArray containsObject:[NSNumber numberWithInteger:(tag1)]];
        
        
        if (shan == NO) {
            
            
            UIViewController *v1 = self.contentArray[tag1];
            
            v1.view.x = (tag1) *self.view.width;
            [self addChildViewController:v1];
            [self.contentScrolView addSubview:v1.view];
            
            NSNumber *nub = [NSNumber numberWithInteger:(tag1)];
            
            [self.storyArray addObject:nub];
            
       
        }
        
        else
        {
            [self.storyArray removeObject:[NSNumber numberWithInteger:(tag1)]];
            [self.storyArray addObject:[NSNumber numberWithInteger:(tag1)]];
        }
        
        
        [self judgeScrollViewAll];
        
        
       
        self.contentScrolView.contentOffset = CGPointMake(tag1 * self.view.width, 0);
        
  
        currentPage = (int)tag1;
 
        offsetX = currentPage *self.view.width;
 
       
        
        
        
        
        if (tag1 < (self.titleArray.count - self.count)) {
            
          
            [UIView animateWithDuration:0.5 animations:^{
                
                 self.TitleScrolView.contentOffset =  CGPointMake(tag1 * lable.width, 0);
                float comDistance = lable.centerX ;//- self.TitleScrolView.contentOffset.x
                
                 self.lineView.centerX =  comDistance ;
                
                
                NSLog(@"%f", self.TitleScrolView.contentOffset.x / lable.width);

                
                
            }];
           

            
           
            
        }
        
        else
        {
            [UIView animateWithDuration:0.5 animations:^{
                
                self.TitleScrolView.contentOffset = CGPointMake((self.titleArray.count - self.count) * lable.width, 0);
               
                float comDistance = lable.centerX ;//- self.TitleScrolView.contentOffset.x
                
                self.lineView.centerX =  comDistance ;
                
                
                NSLog(@"%f", self.TitleScrolView.contentOffset.x / lable.width);


  
            }];

      }
 
        
       self.isClicking = NO;
        
        
    }

}

-(void)judgeScrollViewAll
{
    
    int deleCount = (int)self.storyArray.count;
    
    for ( int i = 0; i < deleCount - 1; i ++ ) {
        
        
        NSInteger  index  =  [self.storyArray[0]  integerValue];
        
        UIViewController *con = self.contentArray[index];
        
        [self clearWithView:con];
        
        
        [self.storyArray  removeObjectAtIndex:0] ;
        [self createNewController:index];
        
    }

}

-(void)clearAllViews
{
    int deleCount = (int)self.storyArray.count;
    
    for ( int i = 0; i < deleCount; i ++ ) {
        
        
        NSInteger  index  =  [self.storyArray[0]  integerValue];
        
        UIViewController *con = self.contentArray[index];
        
        [self clearWithView:con];
        
        
        [self.storyArray  removeObjectAtIndex:0] ;
        [self createNewController:index];
        
    }

}

-(void)judgeScrollViewSubViews
{
    
  
    
 
    if ([ZHArrayTool JudgeArraySort:self.storyArray]) {
    
        
        NSInteger  index  =  [self.storyArray[0]  integerValue];
        
        UIViewController *con = self.contentArray[index];
        
        [self clearWithView:con];
        
        
        [self.storyArray  removeObjectAtIndex:0] ;
        [self createNewController:index];
        
    }
    
    else
        
    {
        
        if (self.storyArray.count >3) {
            
            int deleCount = (int)self.storyArray.count;
            
            for ( int i = 0; i < deleCount - 2; i ++ ) {
               
                
                
                NSInteger  index  =  [self.storyArray[0]  integerValue];
                
                UIViewController *con = self.contentArray[index];
                
                [self clearWithView:con];
                
                
                [self.storyArray  removeObjectAtIndex:0] ;
                [self createNewController:index];

            }
            
        }
    }
 
 
}

-(void)createNewController:(NSInteger)index
{
  
    
    NSString *className =   [DicTionTool GetControllerWithDic:self.titleArray[index]];
    
    NewBaseViewController  *con = [[NSClassFromString(className) alloc]init];
    con.strUrl = [DicTionTool GetUrlWithDic:self.titleArray[index]];
    [self.contentArray insertObject:con atIndex:index];
    [con release];

    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
    if ((scrollView == self.contentScrolView)&& ( self.isClicking == NO)) {
        
        
        if (self.isFirstGun == NO) {
            
            self.TitleScrolView.contentOffset = CGPointMake(gunX, 0);
            
        }
        self.isFirstGun =YES;
        
        if (scrollView.contentOffset.x > offsetX) {
            
            if (currentPage   <= self.titleArray.count -2  ) {
                
                
                BOOL jj =  scrollView.contentOffset.x > currentPage * self.view.width;
                if ((self.isRightFirst )&& jj) {
                    
                    self.isLeftFirst = YES;
                    NSLog(@"right");
                    
                    BOOL shan =     [self.storyArray containsObject:[NSNumber numberWithInt:(currentPage + 1)]];
                    
                    
                    if (shan == NO) {
                        
                        
                        UIViewController *v1 = self.contentArray[currentPage + 1];
                        
                        v1.view.x = (currentPage +1) *self.view.width;
                        [self addChildViewController:v1];
                        [self.contentScrolView addSubview:v1.view];
                        
                        NSNumber *nub = [NSNumber numberWithInt:(currentPage + 1)];
                        
                        [self.storyArray addObject:nub];
                        
                        if (self.storyArray.count >= 3) {
                            
                            [self judgeScrollViewSubViews];
                        }
                        
                        
                        
                    }
                    
                    else
                    {
                        [self.storyArray removeObject:[NSNumber numberWithInt:(currentPage + 1)]];
                        [self.storyArray addObject:[NSNumber numberWithInt:(currentPage + 1)]];
                    }
                    
                    
                  
                    
                    self.isRightFirst = NO;
                    
                    
                    
                    
                }
                
            }
            
            
            self.isRight = YES;
            
            
        }
        
        else if (scrollView.contentOffset.x < offsetX)
        {
            if (currentPage >= 1 ) {
                
                
                BOOL jj = scrollView.contentOffset.x < currentPage * self.view.width;
                              
                
                if (self.isLeftFirst && jj)
                {
                    self.isRightFirst = YES;
                    
                    NSLog(@"left");
                    
                    
                    BOOL shan =     [self.storyArray containsObject:[NSNumber numberWithInt:(currentPage - 1)]];
                    
                    if (shan == NO) {
                        
                        UIViewController *v1 = self.contentArray[currentPage - 1];
                        v1.view.x = (currentPage - 1) *self.view.width;
                        [self addChildViewController:v1];
                        [self.contentScrolView addSubview:v1.view];
                        
                        
                        NSNumber *nub = [NSNumber numberWithInt:(currentPage - 1)];
                        
                        [self.storyArray addObject:nub];
                        
                        if (self.storyArray.count >= 3) {
                            
                             [self judgeScrollViewSubViews];
                        }
                        
                        
                       
                    }
                    
                    
                    else
                    {
                        [self.storyArray removeObject:[NSNumber numberWithInt:(currentPage - 1)]];
                        [self.storyArray addObject:[NSNumber numberWithInt:(currentPage - 1)]];
                    }
                 
                    
                    
                     self.isLeftFirst = NO;
                    
                }
                
            }
            
            
            
            self.isRight = NO;
            
            
        }
        
        
        
        
        float distant =  (scrollView.contentOffset.x - self.view.width * currentPage)/self.view.width;
        
        if (distant <= 0) {
            
            distant = -distant;
        }
        
        if (distant >= 0.996) {
            
            
            if((self.isRight)&&(currentPage <= self.titleArray.count -2))
            {
                
                UILabel *lable = self.lableArray[currentPage];
                
                lable.textColor = [UIColor blackColor];
                lable.font = [UIFont systemFontOfSize:16];
                
                lable = self.lableArray[currentPage+1];
                lable.textColor = [UIColor redColor];
                lable.font = [UIFont systemFontOfSize:17];
                currentPage ++;
                self.isRightFirst = YES;
                
                
            }
            
            else
            {
                if  (currentPage >= 1 )
                {
                    UILabel *lable = self.lableArray[currentPage];
                    lable.textColor = [UIColor blackColor];
                    lable.font = [UIFont systemFontOfSize:16];
                    
                    lable = self.lableArray[currentPage-1];
                    lable.textColor = [UIColor redColor];
                    lable.font = [UIFont systemFontOfSize:17];
                    currentPage --;
                    self.isLeftFirst = YES;
                }
                
            }
            
        }
        
        offsetX = scrollView.contentOffset.x;
        
        
       
        UILabel *lable = self.lableArray[0];
        
        float len = lable.width * scrollView.contentOffset.x /self.view.width ;
       
        
        if (scrollView.contentOffset.x <= (self.titleArray.count - self.count)* self.view.width) {
            
            self.TitleScrolView.contentOffset = CGPointMake(len, 0);
            
            
            self.lineView.centerX = lable.centerX + len;
       

            
            
        }
        
        else
        {

            self.lineView.centerX =  lable.centerX + len ;
            
            NSLog(@"%f",(self.lineView.x - 10) / lable.width);

        }
        
    }
    
    
    
    if (self.TitleScrolView == scrollView) {
        
        if(self.isFirstGun == YES)
        {
            gunX = self.TitleScrolView.contentOffset.x;
        }
        
        self.isFirstGun = NO;
        
    }
 

   
 
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if (scrollView == self.contentScrolView)
        
    {
    
   BOOL shan =     [self.storyArray containsObject:[NSNumber numberWithInt:currentPage]];
    
    if (shan == NO) {
        
        
        UIViewController *v1 = self.contentArray[currentPage];
        v1.view.x = (currentPage - 1) *self.view.width;
        [self addChildViewController:v1];
        [self.contentScrolView addSubview:v1.view];
        
        
        NSNumber *nub = [NSNumber numberWithInt:(currentPage)];
        
        [self.storyArray addObject:nub];
        
        if (self.storyArray.count >= 3) {
            
            [self judgeScrollViewSubViews];
        }

        
        
        
    }
        
        else
        {
            [self.storyArray removeObject:[NSNumber numberWithInt:currentPage ]];
            [self.storyArray addObject:[NSNumber numberWithInt:currentPage ]];
            

        }
    

 
    offsetX = scrollView.x;
    self.isRightFirst = YES;
    self.isLeftFirst = YES;
   
    }

}

@end
