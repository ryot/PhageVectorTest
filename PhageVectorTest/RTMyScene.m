//
//  RTMyScene.m
//  PhageVectorTest
//
//  Created by Ryo Tulman on 5/15/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTMyScene.h"
#import "RTCell.h"
#import "RTPhage.h"

@interface RTMyScene ()
{
    CFTimeInterval _deltaTimeSinceSpawn;
    CFTimeInterval _prevTime;
}

@property (nonatomic, strong) NSMutableArray *cells;

@end

@implementation RTMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        RTPlayer *redPlayer = [RTPlayer new];
        RTPlayer *bluePlayer = [RTPlayer new];
        
        RTCell *originCell = [[RTCell alloc] initWithPosition:CGPointMake(100, 50) color:[UIColor redColor]];
        originCell.player = redPlayer;
        
        RTCell *destinationCell = [[RTCell alloc] initWithPosition:CGPointMake(100, 200) color:[UIColor blueColor]];
        destinationCell.player = bluePlayer;
        
        RTCell *thirdCell = [[RTCell alloc] initWithPosition:CGPointMake(200, 400) color:[UIColor redColor]];
        thirdCell.player = redPlayer;
        
        [self addChild:originCell];
        [self addChild:destinationCell];
        [self addChild:thirdCell];
        
        
        _phages = [NSMutableArray new];
        _cells = [NSMutableArray new];
        [_cells addObject:originCell];
        [_cells addObject:destinationCell];
        [_cells addObject:thirdCell];
        
        _deltaTimeSinceSpawn = 0;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        
        SKNode *node = [self nodeAtPoint:touchLocation];
        if ([node.name isEqualToString:@"Cell"]) {
            RTCell *cell = (RTCell *)node;
            for (RTPhage *phage in _phages) {
                phage.targetCell = cell;
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    CFTimeInterval deltaTime = currentTime - _prevTime;
    _prevTime = currentTime;
    _deltaTimeSinceSpawn = _deltaTimeSinceSpawn + deltaTime;
    if (_deltaTimeSinceSpawn > 0.1) {
        _deltaTimeSinceSpawn = 0;
        for (RTCell *cell  in _cells) {
            [cell spawnPhageOnScene:self];
        }
    }
    for (RTPhage *phage in _phages) {
        [phage updatePhage];
    }
}

@end
