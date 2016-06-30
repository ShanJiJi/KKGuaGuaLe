//
//  DrawView.m
//  测试
//
//  Created by 珍玮 on 16/6/29.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView{
    CGPoint startPoint;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    startPoint = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ref, 10);
    
    CGContextSetStrokeColorWithColor(ref, [UIColor grayColor].CGColor);
    
    CGContextMoveToPoint(ref, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ref, point.x, point.y);
    
    CGContextStrokePath(ref);
    
    UIGraphicsEndImageContext();

//    
//    for ( in <#collection#>) {
//        <#statements#>
//    }
//    
//    
//    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
