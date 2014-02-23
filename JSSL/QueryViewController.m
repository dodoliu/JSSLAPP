//
//  QueryViewController.m
//  JSSL
//
//  Created by LDY on 14-2-23.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//

#import "QueryViewController.h"
#import "UIImageHelper.h"
#import "TFHpple.h"

@interface QueryViewController ()

@end

@implementation QueryViewController

@synthesize queryText;

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
    
    //键盘弹出后，触摸屏幕空白处，隐藏键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)dismissKeyboard
{
    [queryText resignFirstResponder];
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
    queryText = [[UITextField alloc] initWithFrame:cgText];
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
    //隐藏键盘
    //声明文本框的代理为当前controller，让当前controller去实现把键盘往下收的方法。这个方法在UITextFieldDelegate里所以我们要采用UITextFieldDelegate这个协议
    queryText.delegate = self;
    
    
    UIButton *queryBtn = [[UIButton alloc] initWithFrame:cgBtn];
    [queryBtn.layer setMasksToBounds:YES];
    [queryBtn.layer setBorderWidth:1.0];//设置边框宽度
    [queryBtn.layer setCornerRadius:5.0];//设置圆角半径
    [queryBtn setBackgroundColor:[UIColor clearColor]];
    
    [queryBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(btnQuery) forControlEvents:UIControlEventTouchUpInside];

    UISearchBar *sb = [[UISearchBar alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:sb];
    
    
    [self.view addSubview:queryText];
    [self.view addSubview:queryBtn];
    
    [queryText release];
    [queryBtn release];
    [imageHelper release];
    [queryIView release];
}

-(void)btnQuery
{
    [queryText resignFirstResponder];
    
    //访问的url
    //http://so.txt99.com/cse/search?q=是&s=11057906702270625234
    //cse/search?q=死神&s=11057906702270625234
    NSURL *url = [NSURL URLWithString:@"http://so.txt99.com/cse/search?q=shen&s=11057906702270625234"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(response == nil)
    {
        NSLog(@"没有返回");
    }
    
    
    
    
    //11057906702270625234
    //11057906702270625234
    //11057906702270625234
    
    NSArray *aTagsData = [self parseData:response];
    
    NSLog(@"%@",aTagsData);
    
}

//解析xml
-(NSArray *)parseData:(NSData *)data
{
    TFHpple *doc = [[TFHpple alloc] initWithData:data isXML:NO];
    
    //在页面中a标签
    NSArray *aTags = [doc searchWithXPathQuery:@"//a"];
    [doc release];
    return aTags;
    
}





// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    //[textField resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}


@end
