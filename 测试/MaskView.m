//
//  MaskView.m
//  Menultem
//
//  Created by 珍玮 on 16/6/29.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import "MaskView.h"

@interface MaskView (){
    
    CGPoint startPoint;//起始点
}

@property (nonatomic, strong) CALayer *maskLayer;

@property (nonatomic, assign) CGFloat lineWidth;//线宽

@end

@implementation MaskView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lineWidth = 5;
    self.layer.mask = [CALayer new];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //在开始点击的时候获得点击起始点的位置
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchLocation = [touch locationInView:self];
    
    startPoint = touchLocation;
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    //获得移动点
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchPoint = [touch locationInView:self];
    
    //新建层
    CAShapeLayer *layer = [CAShapeLayer new];
    
    //绘制路线
    layer.path = [self getPathFromPointA:startPoint toPointB:touchPoint].CGPath;
    
    //判断有没有遮盖层
    if (!_maskLayer) {
        _maskLayer = [CALayer new];
    }
    
    //将绘制好的层添加到遮盖层
    [_maskLayer addSublayer:layer];
    
    //将改变好的遮盖层赋值给当前视图的遮盖
    self.layer.mask = _maskLayer;
    
    //更新起始点
    startPoint = touchPoint;
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获得结束点
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint touchPoint = [touch locationInView:self];
    
    CAShapeLayer *layer = [CAShapeLayer new];
    
    layer.path = [self getPathFromPointA:startPoint toPointB:touchPoint].CGPath;
    
    if (!_maskLayer) {
        _maskLayer = [CALayer new];
    }
    
    [_maskLayer addSublayer:layer];
    
    self.layer.mask = _maskLayer;
    
}


-(UIBezierPath *)getPathFromPointA:(CGPoint)pointA toPointB:(CGPoint)pointB{
    
    UIBezierPath *path = [UIBezierPath new];
    
    //绘制直径为线宽的起点圆弧
    UIBezierPath *curv1 = [UIBezierPath bezierPathWithArcCenter:pointA radius:self.lineWidth startAngle:angleBetweenPoints(pointA,pointB) + M_PI_2 endAngle:angleBetweenPoints(pointA,pointB) + M_PI + M_PI_2 clockwise:pointB.x >= pointA.x];
    
    //将圆弧的绘制路径添加到总路径中
    [path appendPath:curv1];
    
    
    //绘制直径为线宽的终点圆弧
    UIBezierPath *curv2 = [UIBezierPath bezierPathWithArcCenter:pointB radius:self.lineWidth startAngle:angleBetweenPoints(pointA,pointB) - M_PI_2 endAngle:angleBetweenPoints(pointA, pointB) + M_PI_2 clockwise:pointB.x >= pointA.x];
    
    //绘制连个圆弧之间的第一条连线
    [path addLineToPoint:CGPointMake(pointB.x * 2 - curv2.currentPoint.x, pointB.y *2 - curv2.currentPoint.y)];
    //将终点圆弧添加到总路径中
    [path appendPath:curv2];
    
    //绘制两个圆弧之间的另一条闭合连线
    [path addLineToPoint:CGPointMake(pointA.x *2 - curv1.currentPoint.x, pointA.y * 2 - curv1.currentPoint.y)];
    
    //闭合绘制线路
    [path closePath];
    
    return path;
}


//获得两个点之间的度数
CGFloat angleBetweenPoints(CGPoint first, CGPoint second){
    
    CGFloat height = second.y - first.y;
    CGFloat width = first.x - second.x;
    
    CGFloat rands = atan(height/width);
    
    
    return -rands;
}



@end
