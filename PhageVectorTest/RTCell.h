//
//  RTCell.h
//  PhageVectorTest
//
//  Created by Ryo Tulman on 5/15/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RTMyScene.h"
#import "RTPlayer.h"
#import "RTPhage.h"

@interface RTCell : SKShapeNode

@property (nonatomic, strong) NSMutableArray *phages;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, weak) RTPlayer *player;


-(instancetype)initWithPosition:(CGPoint)position color:(UIColor *)color;
-(void)spawnPhageOnScene:(RTMyScene *)gameScene;
//-(void)recycleThisPhage:(RTPhage *)phage;

@end
