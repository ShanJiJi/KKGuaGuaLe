//
//  ViewController.m
//  测试
//
//  Created by 珍玮 on 16/6/29.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获得触摸位置
    UITouch *touch = touches.anyObject;
    //获得触摸位置在图片上的坐标
    CGPoint point = [touch locationInView:self.image];
    
    //设置清除点的大小
    CGRect rect = CGRectMake(point.x, point.y, 20, 20);
    
    //开启图片上下文，默认是去创建一个透明的视图
    UIGraphicsBeginImageContextWithOptions(self.image.bounds.size, NO, 0);
    
    //获取上下文画板
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //把imageView的layer映射到上下文中
    [self.image.layer renderInContext:ref];
    
    //清除划过的区域
    CGContextClearRect(ref, rect);
    
    //获取擦除后图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束图片的画板，意味着图片在上下文中消失
    UIGraphicsEndImageContext();
    
    self.image.image = image;
    
}

@end
