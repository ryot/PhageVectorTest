//
//  RTPhage.h
//  PhageVectorTest
//
//  Created by Ryo Tulman on 5/15/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "RTCell.h"
#import "RTPlayer.h"

@class RTCell;

@interface RTPhage : SKSpriteNode

@property (nonatomic, weak) RTPlayer *player;
@property (nonatomic, weak) RTCell *targetCell;
@property (nonatomic, strong) NSString *name;

-(instancetype)initWithCell:(RTCell *)cell;
-(void)updatePhage;

@end
