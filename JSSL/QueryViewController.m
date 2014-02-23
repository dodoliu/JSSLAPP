//
//  QueryViewController.m
//  JSSL
//
//  Created by LDY on 14-2-23.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//

#import "QueryViewController.h"
#import "UIImageHelper.h"

@interface QueryViewController ()

@end

@implementation QueryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self drawViewController];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

//绘制书架视图
-(void) drawViewController
{
    CGRect cgText,cgBtn;
    //判断系统是ios6还是7
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        cgText = CGRectMake(5,22, self.view.frame.size.width-55, 25);
        cgBtn = CGRectMake(self.view.frame.size.width-45,22, 40, 25);
    }
    else{
        cgText = CGRectMake(5,2, self.view.frame.size.width-55, 25);
        cgBtn = CGRectMake(self.view.frame.size.width-45,2, 40, 25);
    }
    
    //声明搜索框
    UITextField *queryText = [[UITextField alloc] initWithFrame:cgText];
    [queryText setBorderStyle:UITextBorderStyleRoundedRect];//设置文本框圆角
    [queryText setClearButtonMode:UITextFieldViewModeAlways];//设置是否显示清空文本叉号
    [queryText setReturnKeyType:UIReturnKeySearch];//设置return按钮类型
    
    //为文本框左边添加搜索图片
    UIImage *queryImage = [UIImage imageNamed:@"Query_left"];
    //图片改变大小
    UIImageHelper *imageHelper = [[UIImageHelper alloc] init];
    UIImageView *queryIView = [[UIImageView alloc] initWithImage:[imageHelper scaleToSize:queryImage newSize:CGSizeMake(20, 20)]];
    [queryText setLeftView:queryIView];
    [queryText setLeftViewMode:UITextFieldViewModeAlways];
    
    
    UIButton *queryBtn = [[UIButton alloc] initWithFrame:cgBtn];
    [queryBtn.layer setMasksToBounds:YES];
    [queryBtn.layer setBorderWidth:1.0];
    [queryBtn.layer setCornerRadius:5.0];
    [queryBtn setBackgroundColor:[UIColor clearColor]];
    
    [queryBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(btnQuery) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%f",self.view.frame.origin.x);
    
    NSLog(@"%f",self.view.frame.origin.y);
    
    
    
    
    [self.view addSubview:queryText];
    [self.view addSubview:queryBtn];
    
    [queryText release];
    [queryBtn release];
    [imageHelper release];
    [queryIView release];

    
}

-(void)btnQuery
{
    NSLog(@"aaa");
    
    
    
}


@end
