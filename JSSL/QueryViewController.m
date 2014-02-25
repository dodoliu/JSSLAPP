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
//
//@synthesize queryText;
//@synthesize bookTableView;
//@synthesize aHarfArray;

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
    
    
     //aHarfArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D", nil];
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
    CGRect cgText,cgBtn;//,//cgTbView;
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
    [queryText setDelegate:self];
    
    
    UIButton *queryBtn = [[UIButton alloc] initWithFrame:cgBtn];
    [queryBtn.layer setMasksToBounds:YES];
    [queryBtn.layer setBorderWidth:1.0];//设置边框宽度
    [queryBtn.layer setCornerRadius:5.0];//设置圆角半径
    [queryBtn setBackgroundColor:[UIColor clearColor]];
    
    [queryBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [queryBtn addTarget:self action:@selector(btnQuery) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    NSString *qtValue = [queryText text];
    if([qtValue length] > 0)
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:@"http://so.txt99.com/cse/search?q="];
        //对输入的nsstring进行编码
        [mutableStr appendString:[qtValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [mutableStr appendString:@"&s=11057906702270625234"];
        
        NSURL *url = [NSURL URLWithString:mutableStr];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        if(response == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"搜索失败！" message:@"服务器当前状态不可用，请联系管理员！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            return;
        }
        
        aHarfArray = [self parseData:response];
        aHarfContentArray = [self getAContent:aHarfArray];
        
        //添加书籍显示的表格
        if([[[UIDevice currentDevice] systemVersion] floatValue]>= 7.0)
        {
            bookTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 52, self.view.frame.size.width-10, self.view.frame.size.height-50) style:UITableViewStylePlain];
        }
        else
        {
            bookTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 32, self.view.frame.size.width-10, self.view.frame.size.height-50) style:UITableViewStylePlain];
        }
        //指定tableview的委托为当前controller
        [bookTableView setDelegate:self];
        //指定datasource的委托为当前controller
        [bookTableView setDataSource:self];
        
        [self.view addSubview:bookTableView];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入错误！" message:@"请输入关键字查询！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

//解析xml
-(NSArray *)parseData:(NSData *)data
{
    TFHpple *doc = [[TFHpple alloc] initWithData:data isXML:NO];
    
    //在页面中a标签
    NSArray *aTags = [doc searchWithXPathQuery:@"//a[@target='_blank']"];
    [doc release];
    return aTags;
}

//获取a标签内的相关内容
-(NSMutableArray *)getAContent:(NSArray *)aTags
{
    aHarfContentArray = [[NSMutableArray alloc] init];
    for (int i = 0;i < [aTags count]; i++) {
        TFHppleElement *element = [aTags objectAtIndex:i];
        NSString *str = [[element text] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [aHarfContentArray addObject:str];
    }
    return aHarfContentArray;
}

//点了return按钮后关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//table共有几个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//table每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [aHarfContentArray count];
}

//table每个分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"(搜索结果来自互联网，如果侵犯您的权益，请联系我们！)";
}

//绑定行数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [bookTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //给cell添加数据
    [[cell textLabel] setText:[aHarfContentArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)dealloc
{
    [bookTableView release];
    [aHarfArray release];
    [aHarfContentArray release];
    [super dealloc];
}



@end
