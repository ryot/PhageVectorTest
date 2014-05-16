//
//  RTCell.m
//  PhageVectorTest
//
//  Created by Ryo Tulman on 5/15/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTCell.h"
#import "RTPhage.h"
#import "RTMyScene.h"

@implementation RTCell

-(instancetype)initWithPosition:(CGPoint)position color:(UIColor *)color
{
    if (self = [super init]) {
        self.name = @"Cell";
        self.position = position;
        _phages = [NSMutableArray new];
        self.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)].CGPath;
        self.fillColor = color;
        self.strokeColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
        self.glowWidth = 20;
    }
    return self;
}

-(void)spawnPhageOnScene:(RTMyScene *)gameScene
{
    RTPhage *newPhage = [[RTPhage alloc] initWithCell:self];
    newPhage.player = self.player;
    newPhage.position = CGPointMake(self.position.x + self.frame.size.width/2, self.position.y + self.frame.size.height/2);
    newPhage.targetCell = self;
    [_phages addObject:newPhage];
    [gameScene.phages addObject:newPhage];
    [gameScene addChild:newPhage];
}

@end
