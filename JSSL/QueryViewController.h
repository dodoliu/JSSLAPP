//
//  QueryViewController.h
//  JSSL
//
//  Created by LDY on 14-2-23.
//  Copyright (c) 2014年 DONLIU1987. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *queryText; //查询文本框
    UITableView *bookTableView; //显示搜索结果的table
    NSArray *aHarfArray; //存放a标签内容的array
    NSMutableArray *aHarfContentArray; //存放a标签内内容的array
}

//@property(nonatomic,strong)UITextField *queryText;
//@property(nonatomic,strong)UITableView *bookTableView;
//
//@property(nonatomic,strong)NSArray *aHarfArray;

@end
