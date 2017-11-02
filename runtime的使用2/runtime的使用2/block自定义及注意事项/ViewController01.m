//
//  ViewController01.m
//  runtime的使用2
//
//  Created by mac on 2017/10/7.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "ViewController01.h"

@interface ViewController01 ()

@end

@implementation ViewController01

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=self.view.bounds;
    btn.backgroundColor=[UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(popViewControllr) forControlEvents:UIControlEventTouchUpInside];
    
    //[self popViewControllr];
    // Do any additional setup after loading the view.
}
-(void)popViewControllr{
    
    if (self.backBlock) {
        self.backBlock(@"夏夏", 521);
    }
    NSArray*a=@[@"xiaxia",@(521)];
    if (self.blockb) {
        self.blockb(a);
    }
    
  [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)push{
    ViewController01 *vc=[ViewController01 new];
    vc.backBlock = ^(NSString *str, int a) {
        NSLog(@"%@-%d",str,a);
    };
    [self.navigationController pushViewController:vc animated:YES];
    
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
