//
//  BlockButton.m
//  runtime的使用2
//
//  Created by mac on 2017/10/3.
//  Copyright © 2017年 macfei. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton
-(instancetype)init{
    if(self=[super init]){
        
        
        [self addTarget:self action:@selector(kk:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return self;
    
}
-(void)kk:(UIButton*)btn{
    self.blockB(btn);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
